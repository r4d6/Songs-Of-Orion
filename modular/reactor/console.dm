/obj/machinery/multistructure/nuclear_reactor_part/console
	icon_state = "console"
	density = TRUE
	var/datum/multistructure/nuclear_reactor/Reactor

/obj/machinery/multistructure/nuclear_reactor_part/console/New()
	..()
	update_icon()

/obj/machinery/multistructure/nuclear_reactor_part/console/update_icon()
	add_overlay("power_key")
	add_overlay("smmon_2")

/obj/machinery/multistructure/nuclear_reactor_part/console/attack_hand(mob/user as mob)
	interact(user)

/obj/machinery/multistructure/nuclear_reactor_part/console/ui_interact(mob/user, datum/tgui/ui)
	// Reactor.ui_interact(user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NuclearReactorConsole")
		ui.open()
	return

/obj/machinery/multistructure/nuclear_reactor_part/console/ui_data(mob/user)
	var/list/data = list()
	data["integrity"] = Reactor.get_integrity()
	data["control_average"] = Reactor.control_average
	data["temperature"] = Reactor.temperature
	data["cutoffTemp"] = Reactor.cutoff_temp
	data["gas_input"] = list()
	data["gas_output"] = list()
	data["gas_storage"] = list()
	data["controlRods"] = list()
	data["fuelRods"] = list()

	for(var/obj/machinery/multistructure/nuclear_reactor_part/control_rod/CR in Reactor.control_spots)
		if(CR.current_step < STEP_PULLED && CR.control)
			data["controlRods"] += list(list(
				"height" = CR.height,
				"minHeight" = CR.min_height,
				"maxHeight" = CR.max_height,
		))

	for(var/obj/machinery/multistructure/nuclear_reactor_part/fuel_rod/FR in Reactor.fuel_spots)
		if(FR.current_step < STEP_PULLED && FR.fuel)
			data["fuelRods"] += list(list(
				"name" = FR.fuel.name,
				"desc" = FR.fuel.desc,
				"meltingPoint" = FR.fuel.melting_point,
				"life" = FR.fuel.life,
				"lifespan" = FR.fuel.lifespan,
				"temperature" = FR.fuel.temperature,
				"insertion" = FR.fuel.insertion,
		))

	data["gas_input"] += list(
		"temperature" = Reactor.gas_input.temperature,
		"gas" = Reactor.gas_input.gas
	)

	data["gas_storage"] += list(
		"temperature" = Reactor.gas_storage.temperature,
		"gas" = Reactor.gas_storage.gas
	)
	data["gas_output"] += list(
		"temperature" = Reactor.gas_output.temperature,
		"gas" = Reactor.gas_output.gas
	)

	return data

/obj/machinery/multistructure/nuclear_reactor_part/console/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(action == "scram")
		Reactor.scram()
		return
	if(action == "set_target_height")
		Reactor.Set_Control_Rod_Height(params["target_height"])
		return

/obj/machinery/multistructure/nuclear_reactor_part/console/Topic(href, href_list)
	..()
	//Ignore input if we are broken or guy is not touching us, AI can control from a ways away
	if(stat & (BROKEN) || (get_dist(src, usr) > 1 && !isAI(usr)))
		usr.unset_machine()
		usr << browse(null, "window=NRcontrol")
		return

	if(href_list["close"])
		usr << browse(null, "window=NRcontrol")
		usr.unset_machine()
		return

	Reactor.Topic(href, href_list)

	updateDialog()
	return
