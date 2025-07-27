/obj/machinery/nuclear_centrifuge
	name = "nuclear centrifuge"
	desc = "A device designed to refill spent nuclear fuel rods."
	icon = './astra_centrifuge.dmi'
	icon_state = "off"
	anchored = TRUE
	density = TRUE
	bound_width = 64
	bound_height = 64
	var/obj/item/fuel_rod/fuel
	var/obj/item/reagent_containers/container
	var/active = FALSE
	var/refill_rate = 10 // Amount of reagent used to refill every Process()

/obj/machinery/nuclear_centrifuge/examine(mob/user)
	. = ..()
	if(fuel)
		to_chat(user, SPAN_NOTICE("[src] contain \an [fuel] at [fuel.life]% capacity. It can be refilled with [fuel.refill_reagent]."))
	if(container)
		to_chat(user, SPAN_NOTICE("[src] contain \an [container] that contains [container.reagents.total_volume]u of chemicals."))

/obj/machinery/nuclear_centrifuge/attack_hand(mob/user)
	if(!active)
		start_working()
	else
		stop_working()

	to_chat(user, "You turn [src] [active ? "on" : "off"].")

	update_icon()

/obj/machinery/nuclear_centrifuge/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/reagent_containers)) // Is it something that hold chems ?
		// Do we already have one inside?
		if(container)
			to_chat(user, "[src] already got a beaker.")
			return
		else
			if(insert_item(W, user))

				container = W
				//to_chat(user, "You add [W] to [src].")
				return

	if(istype(W, /obj/item/fuel_rod))
		if(fuel)
			to_chat(user, "[src] already got a fuel rod.")
			return

		var/obj/item/fuel_rod/F = W
		if(F.life == initial(F.life))
			to_chat(user, "[F] is already filled.")
			return

		if(insert_item(F, user))
			fuel = F
			return

	..()
	return

/obj/machinery/nuclear_centrifuge/update_icon()
	..()
	if(active)
		icon_state = "on"
	else
		icon_state = "off"

/obj/machinery/nuclear_centrifuge/Destroy()
	STOP_PROCESSING(SSmachines, src)
	. = ..()

/obj/machinery/nuclear_centrifuge/Process()
	if(!fuel || !container)
		stop_working()
		visible_message("[src] stops due to missing a fuel rod or reagent container.")
		return

	/*if(fuel.life >= initial(fuel.life))
		STOP_PROCESSING(SSmachines, src)
		active = FALSE
		update_icon()
		visible_message("[src] stops as the fuel rod is fully refilled.")
		return*/

	// Determine the amount of reagent to use this tick with either the refill rate, the amount left to fill on the fuel rod, or the amount of reagent available, depending on which is smallest.
	var/refill_amount = min(refill_rate, initial(fuel.life) - fuel.life, container.reagents.get_reagent_amount(fuel.refill_reagent))

	if(refill_amount == 0)
		stop_working()
		visible_message("[src] stops as it is unable to fill [fuel] any further.")
		return

	if(container.reagents.remove_reagent(fuel.refill_reagent, refill_amount))
		fuel.life = clamp(fuel.life + refill_amount, 0, initial(fuel.life))
		fuel.name = initial(fuel.name)

/obj/machinery/nuclear_centrifuge/proc/start_working()
	START_PROCESSING(SSmachines, src)
	active = TRUE
	update_icon()

/obj/machinery/nuclear_centrifuge/proc/stop_working()
	STOP_PROCESSING(SSmachines, src)
	active = FALSE
	update_icon()

/obj/machinery/nuclear_centrifuge/verb/eject_fuel()
	set name = "Eject Fuel Rod"
	set src in view(1)
	if(!fuel)
		to_chat(usr, SPAN_NOTICE("There is no fuel in [src]."))
		return

	to_chat(usr, SPAN_NOTICE("You remove [fuel] from [src]."))
	fuel.loc = loc
	fuel = null

	if(active)
		stop_working()

/obj/machinery/nuclear_centrifuge/verb/eject_container()
	set name = "Eject Reagent Container"
	set src in view(1)
	if(!container)
		to_chat(usr, SPAN_NOTICE("There is no container in [src]."))
		return

	to_chat(usr, SPAN_NOTICE("You remove [container] from [src]."))
	container.loc = loc
	container = null

	if(active)
		stop_working()
