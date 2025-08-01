#define waypoint_sector(waypoint) map_sectors["[waypoint.z]"]

/datum/shuttle/autodock/overmap
	warmup_time = 10

	var/range = 0	//how many overmap tiles can shuttle go, for picking destinations and returning.
	var/fuel_consumption = 0 //Amount of moles of gas consumed per trip; If zero, then shuttle is magic and does not need fuel
	var/list/obj/structure/fuel_port/fuel_ports //the fuel ports of the shuttle (but usually just one)

	category = /datum/shuttle/autodock/overmap

/datum/shuttle/autodock/overmap/New(var/_name, var/obj/effect/shuttle_landmark/start_waypoint)
	..(_name, start_waypoint)
	refresh_fuel_ports_list()

/datum/shuttle/autodock/overmap/proc/refresh_fuel_ports_list() //loop through all
	fuel_ports = list()
	for(var/area/A in shuttle_area)
		for(var/obj/structure/fuel_port/fuel_port_in_area in A)
			fuel_port_in_area.parent_shuttle = src
			fuel_ports += fuel_port_in_area

/datum/shuttle/autodock/overmap/fuel_check()
	if(!src.try_consume_fuel()) //insufficient fuel
		for(var/area/A in shuttle_area)
			for(var/mob/living/M in A)
				M.show_message("<spawn class='warning'>You hear the shuttle engines sputter... perhaps it doesn't have enough fuel?", 2,
				"<spawn class='warning'>The shuttle shakes but fails to take off.", 1)
				return 0 //failure!
	return 1 //sucess, continue with launch

/datum/shuttle/autodock/overmap/proc/can_go()
	if(!next_location)
		return FALSE
	if(moving_status == SHUTTLE_INTRANSIT)
		return FALSE //already going somewhere, current_location may be an intransit location instead of in a sector
	return get_dist(waypoint_sector(current_location), waypoint_sector(next_location)) <= range

/datum/shuttle/autodock/overmap/can_launch()
	return ..() && can_go()

/datum/shuttle/autodock/overmap/can_force()
	return ..() && can_go()

/datum/shuttle/autodock/overmap/proc/get_location_name()
	if(moving_status == SHUTTLE_INTRANSIT)
		return "In transit"
	var/obj/effect/overmap/sector/S = waypoint_sector(current_location)
	return "[S.name_stages[1]] - [current_location]"

/datum/shuttle/autodock/overmap/proc/get_destination_name()
	if(!next_location)
		return "None"
	var/obj/effect/overmap/sector/S = waypoint_sector(next_location)
	return "[S.name_stages[1]] - [next_location]"

/datum/shuttle/autodock/overmap/proc/try_consume_fuel() //returns 1 if sucessful, returns 0 if error (like insufficient fuel)
	if(!fuel_consumption)
		return 1 //shuttles with zero fuel consumption are magic and can always launch
	else
		if(fuel_ports.len)
			var/list/obj/item/tank/fuel_tanks = list()
			for(var/obj/structure/FP in fuel_ports) //loop through fuel ports and assemble list of all fuel tanks
				if(FP.contents.len)
					var/obj/item/tank/FT = FP.contents[1]
					if(istype(FT))
						fuel_tanks += FT
			if(!fuel_tanks.len)
				return 0 //can't launch if you have no fuel TANKS in the ports
			var/total_flammable_gas_moles = 0
			for(var/obj/item/tank/FT in fuel_tanks)
				total_flammable_gas_moles += FT.air_contents.get_by_flag(XGM_GAS_FUEL)
			if(total_flammable_gas_moles >= fuel_consumption) //launch is possible, so start consuming that fuel
				var/fuel_to_consume = fuel_consumption
				for(var/obj/item/tank/FT in fuel_tanks) //loop through tanks, consume their fuel one by one
					if(FT.air_contents.get_by_flag(XGM_GAS_FUEL) >= fuel_to_consume)
						FT.air_contents.remove_by_flag(XGM_GAS_FUEL, fuel_to_consume)
						log_and_message_admins("shuttle has began his voyage from [current_location] to [next_location]")
						return 1 //ALL REQUIRED FUEL HAS BEEN CONSUMED, GO FOR LAUNCH!
					else //this tank doesn't have enough to launch shuttle by itself, so remove all its fuel, then continue loop
						fuel_to_consume -= FT.air_contents.get_by_flag(XGM_GAS_FUEL)
						FT.air_contents.remove_by_flag(XGM_GAS_FUEL, FT.air_contents.get_by_flag(XGM_GAS_FUEL))
			else
				return 0 //can't launch if you have insufficient fuel
		else
			return 0 //can't launch if you have no fuel PORTS at all

/obj/structure/fuel_port
	name = "fuel port"
	desc = "The fuel input port of the shuttle. Holds one fuel tank. Use a crowbar to open and close it."
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "fuel_port"
	density = FALSE
	anchored = TRUE
	var/icon_closed = "fuel_port"
	var/icon_empty = "fuel_port_empty"
	var/icon_full = "fuel_port_full"
	var/opened = 0
	var/parent_shuttle

/obj/structure/fuel_port/New()
	src.contents.Add(new/obj/item/tank/plasma)

/obj/structure/fuel_port/attack_hand(mob/user)
	if(!opened)
		to_chat(user, "<spawn class='notice'>The door is secured tightly. You'll need a crowbar to open it.")
		return
	else if(contents.len > 0)
		user.put_in_hands(contents[1])
	update_icon()

/obj/structure/fuel_port/update_icon()
	if(opened)
		if(contents.len > 0)
			icon_state = icon_full
		else
			icon_state = icon_empty
	else
		icon_state = icon_closed

/obj/structure/fuel_port/attackby(obj/item/W as obj, mob/user)
	if(QUALITY_PRYING in W.tool_qualities)
		if(W.use_tool(user, src, WORKTIME_NEAR_INSTANT, QUALITY_PRYING, FAILCHANCE_EASY, required_stat = STAT_ROB))
			if(opened)
				to_chat(user, "<spawn class='notice'>You tightly shut \the [src] door.")
				playsound(loc, 'sound/machines/Custom_closetclose.ogg', 25, 0, -3)
				opened = 0
			else
				to_chat(user, "<spawn class='notice'>You open up \the [src] door.")
				playsound(loc, 'sound/machines/Custom_closetopen.ogg', 15, 1, -3)
				opened = 1
	else if(istype(W,/obj/item/tank))
		if(!opened)
			to_chat(user, "<spawn class='warning'>\The [src] door is still closed!")
			return
		if(contents.len == 0)
			user.drop_from_inventory(W)
			W.forceMove(src)
	update_icon()
