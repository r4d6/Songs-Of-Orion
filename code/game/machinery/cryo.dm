#define HEAT_CAPACITY_HUMAN 100 //249840 J/K, for a 72 kg person.

/obj/machinery/atmospherics/unary/cryo_cell
	name = "cryo cell"
	icon = 'icons/obj/cryogenics.dmi' // map only
	icon_state = "pod_preview"
	density = TRUE
	anchored = TRUE
	layer = ABOVE_WINDOW_LAYER
	plane = GAME_PLANE
	interact_offline = 1

	var/on = FALSE
	use_power = IDLE_POWER_USE
	idle_power_usage = 20
	active_power_usage = 200

	var/temperature_archived
	var/mob/living/carbon/occupant = null
	var/obj/item/reagent_containers/glass/beaker = null

	var/current_heat_capacity = 50

/obj/machinery/atmospherics/unary/cryo_cell/LateInitialize()
	..()
	icon = 'icons/obj/cryogenics_split.dmi'
	update_icon()
	initialize_directions = dir

/obj/machinery/atmospherics/unary/cryo_cell/Destroy()
	var/turf/T = loc
	T.contents += contents
	if(beaker)
		beaker.loc = get_step(loc, SOUTH) //Beaker is carefully ejected from the wreckage of the cryotube
	. = ..()

/obj/machinery/atmospherics/unary/cryo_cell/atmos_init()
	if(node1) return
	var/node1_connect = dir
	for(var/obj/machinery/atmospherics/target in get_step(src,node1_connect))
		if(target.initialize_directions & get_dir(target,src))
			node1 = target
			break

/obj/machinery/atmospherics/unary/cryo_cell/Process()
	..()
	if(!node1)
		return
	if(!on)
		return

	if(occupant)
		if(occupant.stat != DEAD)
			process_occupant()

	if(air_contents)
		temperature_archived = air_contents.temperature
		heat_gas_contents()
		expel_gas()

	if(abs(temperature_archived-air_contents.temperature) > 1)
		network.update = 1

	return 1

/obj/machinery/atmospherics/unary/cryo_cell/relaymove(mob/user as mob)
	// note that relaymove will also be called for mobs outside the cell with UI open
	if(src.occupant == user && !user.stat)
		go_out()

/obj/machinery/atmospherics/unary/cryo_cell/attack_hand(mob/user)
	nano_ui_interact(user)

 /**
  * The nano_ui_interact proc is used to open and update Nano UIs
  * If nano_ui_interact is not used then the UI will not update correctly
  * nano_ui_interact is currently defined for /atom/movable (which is inherited by /obj and /mob)
  *
  * @param user /mob The mob who is interacting with this ui
  * @param ui_key string A string key to use for this ui. Allows for multiple unique uis on one obj/mob (defaut value "main")
  * @param ui /datum/nanoui This parameter is passed by the nanoui process() proc when updating an open ui
  *
  * @return nothing
  */
/obj/machinery/atmospherics/unary/cryo_cell/nano_ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = NANOUI_FOCUS)

	if(user == occupant || user.stat)
		return

	// this is the data which will be sent to the ui
	var/data[0]
	data["isOperating"] = on
	data["hasOccupant"] = occupant ? 1 : 0

	var/occupantData[0]
	if (occupant)
		occupantData["name"] = occupant.name
		occupantData["stat"] = occupant.stat
		occupantData["health"] = occupant.health
		occupantData["maxHealth"] = occupant.maxHealth
		occupantData["minHealth"] = HEALTH_THRESHOLD_DEAD
		occupantData["bruteLoss"] = occupant.getBruteLoss()
		occupantData["oxyLoss"] = occupant.getOxyLoss()
		occupantData["toxLoss"] = occupant.getToxLoss()
		occupantData["fireLoss"] = occupant.getFireLoss()
		occupantData["bodyTemperature"] = occupant.bodytemperature
	data["occupant"] = occupantData;

	data["cellTemperature"] = round(air_contents.temperature)
	data["cellTemperatureStatus"] = "good"
	if(air_contents.temperature > T0C) // if greater than 273.15 kelvin (0 celcius)
		data["cellTemperatureStatus"] = "bad"
	else if(air_contents.temperature > 225)
		data["cellTemperatureStatus"] = "average"

	data["isBeakerLoaded"] = beaker ? 1 : 0
	/* // Removing beaker contents list from front-end, replacing with a total remaining volume
	var beakerContents[0]
	if(beaker && beaker.reagents && beaker.reagents.reagent_list.len)
		for(var/datum/reagent/R in beaker.reagents.reagent_list)
			beakerContents.Add(list(list("name" = R.name, "volume" = R.volume))) // list in a list because Byond merges the first list...
	data["beakerContents"] = beakerContents
	*/
	data["beakerLabel"] = null
	data["beakerVolume"] = 0
	if(beaker)
		data["beakerLabel"] = beaker.label_text ? beaker.label_text : null
		if (beaker.reagents && beaker.reagents.reagent_list.len)
			for(var/datum/reagent/R in beaker.reagents.reagent_list)
				data["beakerVolume"] += R.volume

	data["beakerVolume"] = num2text( round(data["beakerVolume"], 0.1) )

	// update the ui if it exists, returns null if no ui is passed/found
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		// the ui does not exist, so we'll create a new() one
	// for a list of parameters and their descriptions see the code docs in \code\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "cryo.tmpl", "Cryo Cell Control System", 520, 410)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()
		// auto update every Master Controller tick
		ui.set_auto_update(1)

/obj/machinery/atmospherics/unary/cryo_cell/Topic(href, href_list)
	if(usr == occupant)
		return 0 // don't update UIs attached to this object

	if(..())
		return 0 // don't update UIs attached to this object

	if(href_list["switchOn"])
		on = TRUE
		update_icon()

	if(href_list["switchOff"])
		on = FALSE
		update_icon()

	if(href_list["ejectBeaker"])
		if(beaker)
			beaker.loc = get_step(loc, SOUTH)
			beaker = null

	if(href_list["ejectOccupant"])
		if(!occupant || isslime(usr) || ispAI(usr))
			return 0 // don't update UIs attached to this object
		go_out()

	add_fingerprint(usr)
	playsound(loc, 'sound/machines/machine_switch.ogg', 100, 1)
	return 1 // update UIs attached to this object

/obj/machinery/atmospherics/unary/cryo_cell/affect_grab(var/mob/user, var/mob/target)
	for(var/mob/living/carbon/slime/M in range(1,target))
		if(M.Victim == target)
			to_chat(user, "[target] will not fit into the cryo because they have a slime latched onto their head.")
			return
	return put_mob(target)

/obj/machinery/atmospherics/unary/cryo_cell/attackby(var/obj/item/W as obj, var/mob/user as mob)
	if(istype(W, /obj/item/reagent_containers/glass))
		if(beaker)
			to_chat(user, SPAN_WARNING("A beaker is already loaded into the machine."))
			return
		if(user.unEquip(W, src))
			beaker = W
			user.visible_message(
				"[user] adds \a [W] to \the [src]!",
				"You add \a [W] to \the [src]!"
			)
	return

/obj/machinery/atmospherics/unary/cryo_cell/update_icon()
	overlays.Cut()
	icon_state = "pod[on]"
	var/image/I

	I = image(icon, "pod[on]_top")
	I.layer = WALL_OBJ_LAYER
	I.pixel_z = 32
	overlays += I

	if(occupant)
		var/image/pickle = image(occupant.icon, occupant.icon_state)
		pickle.overlays = occupant.overlays
		pickle.pixel_z = 18
		pickle.layer = WALL_OBJ_LAYER
		overlays += pickle

	I = image(icon, "lid[on]")
	I.layer = WALL_OBJ_LAYER
	overlays += I

	I = image(icon, "lid[on]_top")
	I.layer = WALL_OBJ_LAYER
	I.pixel_z = 32
	overlays += I

/obj/machinery/atmospherics/unary/cryo_cell/proc/process_occupant()
	if(air_contents.total_moles < 10)
		return
	if(occupant)
		if(occupant.stat == DEAD)
			return
		occupant.bodytemperature += 2*(air_contents.temperature - occupant.bodytemperature)*current_heat_capacity/(current_heat_capacity + air_contents.heat_capacity())
		occupant.bodytemperature = max(occupant.bodytemperature, air_contents.temperature) // this is so ugly i'm sorry for doing it i'll fix it later i promise
		occupant.stat = UNCONSCIOUS
		if(occupant.bodytemperature < T0C)
			occupant.sleeping = max(5, (1/occupant.bodytemperature)*2000)
			occupant.Paralyse(max(5, (1/occupant.bodytemperature)*3000))
			if(air_contents.gas["oxygen"] > 2)
				if(occupant.getOxyLoss()) occupant.adjustOxyLoss(-1)
			else
				occupant.adjustOxyLoss(-1)
			//severe damage should heal waaay slower without proper chemicals
			if(occupant.bodytemperature < 225)
				var/heal_brute = occupant.getBruteLoss() ? min(1, 20/occupant.getBruteLoss()) : 0
				var/heal_fire = occupant.getFireLoss() ? min(1, 20/occupant.getFireLoss()) : 0
				occupant.heal_organ_damage(heal_brute,heal_fire)
		var/has_cryo = occupant.reagents.get_reagent_amount("cryoxadone") >= 1
		var/has_clonexa = occupant.reagents.get_reagent_amount("clonexadone") >= 1
		var/has_cryo_medicine = has_cryo || has_clonexa
		if(beaker && !has_cryo_medicine)
			beaker.reagents.trans_to_mob(occupant, 1, CHEM_BLOOD, 10)

/obj/machinery/atmospherics/unary/cryo_cell/proc/heat_gas_contents()
	if(air_contents.total_moles < 1)
		return
	var/air_heat_capacity = air_contents.heat_capacity()
	var/combined_heat_capacity = current_heat_capacity + air_heat_capacity
	if(combined_heat_capacity > 0)
		var/combined_energy = T20C*current_heat_capacity + air_heat_capacity*air_contents.temperature
		air_contents.temperature = combined_energy/combined_heat_capacity

/obj/machinery/atmospherics/unary/cryo_cell/proc/expel_gas()
	if(air_contents.total_moles < 1)
		return
//	var/datum/gas_mixture/expel_gas = new
//	var/remove_amount = air_contents.total_moles()/50
//	expel_gas = air_contents.remove(remove_amount)

	// Just have the gas disappear to nowhere.
	//expel_gas.temperature = T20C // Lets expel hot gas and see if that helps people not die as they are removed
	//loc.assume_air(expel_gas)

/obj/machinery/atmospherics/unary/cryo_cell/proc/go_out()
	if(!( occupant ))
		return
	//for(var/obj/O in src)
	//	O.loc = loc
	if (occupant.client)
		occupant.client.eye = occupant.client.mob
		occupant.client.perspective = MOB_PERSPECTIVE
	occupant.forceMove(get_step(loc, SOUTH))	//this doesn't account for walls or anything, but i don't forsee that being a problem.
	if (occupant.bodytemperature < 261 && occupant.bodytemperature >= 70) //Patch by Aranclanos to stop people from taking burn damage after being ejected
		occupant.bodytemperature = 261									  // Changed to 70 from 140 by Zuhayr due to reoccurance of bug.
//	occupant.metabslow = 0
	occupant = null
	current_heat_capacity = initial(current_heat_capacity)
	set_power_use(IDLE_POWER_USE)
	update_icon()
	return

/obj/machinery/atmospherics/unary/cryo_cell/proc/put_mob(mob/living/carbon/M as mob)
	if (stat & (NOPOWER|BROKEN))
		to_chat(usr, SPAN_WARNING("The cryo cell is not functioning."))
		return
	if (!istype(M))
		to_chat(usr, SPAN_DANGER("The cryo cell cannot handle such a lifeform!"))
		return
	if (occupant)
		to_chat(usr, SPAN_DANGER("The cryo cell is already occupied!"))
		return
	if (M.abiotic())
		to_chat(usr, SPAN_WARNING("Subject may not have abiotic items on."))
		return
	if(!node1)
		to_chat(usr, SPAN_WARNING("The cell is not correctly connected to its pipe network!"))
		return
	if (M.client)
		M.client.perspective = EYE_PERSPECTIVE
		M.client.eye = src
	M.stop_pulling()
	M.forceMove(src)
	M.ExtinguishMob()
	if(M.health > -100 && (M.health < 0 || M.sleeping))
		to_chat(M, SPAN_NOTICE("<b>You feel a cold liquid surround you. Your skin starts to freeze up.</b>"))
	occupant = M
	current_heat_capacity = HEAT_CAPACITY_HUMAN
	set_power_use(ACTIVE_POWER_USE)
//	M.metabslow = 1
	add_fingerprint(usr)
	update_icon()
	return 1

/obj/machinery/atmospherics/unary/cryo_cell/MouseDrop_T(var/mob/target, var/mob/user)
	if(!ismob(target))
		return
	if (target.buckled)
		to_chat(usr, SPAN_WARNING("Unbuckle the subject before attempting to move them."))
		return
	user.visible_message(
		SPAN_NOTICE("\The [user] begins placing \the [target] into \the [src]."),
		SPAN_NOTICE("You start placing \the [target] into \the [src].")
	)
	if(!do_after(user, 30, src) || !Adjacent(target))
		return
	put_mob(target)
	return


/obj/machinery/atmospherics/unary/cryo_cell/verb/move_eject()
	set name = "Eject occupant"
	set category = "Object"
	set src in oview(1)
	if(usr == occupant)//If the user is inside the tube...
		if(usr.stat == DEAD)//and he's not dead....
			return
		to_chat(usr, SPAN_NOTICE("Release sequence activated. This will take two minutes."))
		sleep(1200)
		if(!src || !usr || !occupant || (occupant != usr)) //Check if someone's released/replaced/bombed him already
			return
		go_out()//and release him from the eternal prison.
	else
		if(usr.stat)
			return
		go_out()
	add_fingerprint(usr)
	return

/obj/machinery/atmospherics/unary/cryo_cell/verb/move_inside()
	set name = "Move Inside"
	set category = "Object"
	set src in oview(1)
	for(var/mob/living/carbon/slime/M in range(1,usr))
		if(M.Victim == usr)
			to_chat(usr, "You're too busy getting your life sucked out of you.")
			return
	if (usr.stat != 0)
		return
	put_mob(usr)
	return

/atom/proc/return_air_for_internal_lifeform()
	return return_air()

/obj/machinery/atmospherics/unary/cryo_cell/return_air_for_internal_lifeform()
	//assume that the cryo cell has some kind of breath mask or something that
	//draws from the cryo tube's environment, instead of the cold internal air.
	if(loc)
		return loc.return_air()
	else
		return null

/datum/data/function/proc/reset()
	return

/datum/data/function/proc/r_input(href, href_list, mob/user as mob)
	return

/datum/data/function/proc/display()
	return
