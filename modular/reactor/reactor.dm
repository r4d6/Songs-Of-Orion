// This is the actual reactor.

/datum/multistructure/nuclear_reactor
	structure = list(
		list(/obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall),
		list(/obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/control_rod, /obj/machinery/multistructure/nuclear_reactor_part/fuel_rod, /obj/machinery/multistructure/nuclear_reactor_part/control_rod, /obj/machinery/multistructure/nuclear_reactor_part/wall),
		list(/obj/machinery/multistructure/nuclear_reactor_part/wall_input, /obj/machinery/multistructure/nuclear_reactor_part/fuel_rod, /obj/machinery/multistructure/nuclear_reactor_part/control_rod, /obj/machinery/multistructure/nuclear_reactor_part/fuel_rod, /obj/machinery/multistructure/nuclear_reactor_part/wall_output),
		list(/obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/control_rod, /obj/machinery/multistructure/nuclear_reactor_part/fuel_rod, /obj/machinery/multistructure/nuclear_reactor_part/control_rod, /obj/machinery/multistructure/nuclear_reactor_part/wall),
		list(/obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall)
					)

	var/control_average
	var/list/walls = list()
	var/list/fuel_spots = list()
	var/list/control_spots = list()
	var/wall_input
	var/wall_output
	var/obj/machinery/multistructure/nuclear_reactor_part/console/Console

	var/datum/gas_mixture/gas_input
	var/datum/gas_mixture/gas_storage
	var/datum/gas_mixture/gas_output

	var/health = 200
	var/max_health = 200

	var/announce = 1
	var/decay_archived = 0
	var/exploded = 0
	var/envefficiency = 1 //0.01
	var/gasefficiency = 1 //0.5
	var/warning_delay = 20
	var/meltwarned = 0
	var/lastwarning = 0
	var/cutoff_temp = 1200
	// Material properties from Tungsten Carbide, otherwise core'll be too weak.
	// Material properties for the core are just it's heat exchange system, not the entire core.
	var/specific_heat = 40	// J/(mol*K)
	var/molar_mass = 0.196	// kg/mol
	var/mass = 200			// kg
	var/max_temp = 0 //3058
	var/temperature = T20C
	var/list/obj/item/fuel_rod/rods
	var/obj/item/device/radio/radio

/datum/multistructure/nuclear_reactor/connect_elements()
	..()
	gas_storage = new()

	for(var/obj/machinery/multistructure/nuclear_reactor_part/part in elements)
		if(istype(part, /obj/machinery/multistructure/nuclear_reactor_part/wall))
			walls += part
			continue
		if(istype(part, /obj/machinery/multistructure/nuclear_reactor_part/control_rod))
			control_spots += part
			continue
		if(istype(part, /obj/machinery/multistructure/nuclear_reactor_part/fuel_rod))
			fuel_spots += part
			continue
		if(istype(part, /obj/machinery/multistructure/nuclear_reactor_part/wall_input))
			walls += part
			wall_input = part
			continue
		if(istype(part, /obj/machinery/multistructure/nuclear_reactor_part/wall_output))
			walls += part
			wall_output = part
			continue

	gas_input = Get_Pipe_Input()
	gas_output = Get_Pipe_Output()
	control_average = Get_Average_Control_Height()
	Console = locate() in get_area(wall_input)
	Console?.Reactor = src
	radio = new()
	START_PROCESSING(SSprocessing, src)

/datum/multistructure/nuclear_reactor/Process()
	control_average = Get_Average_Control_Height()
	rods = Get_Fuel_Rods(FALSE)

	if(!Console)
		Console = locate() in get_area(wall_input)
		Console?.Reactor = src

	gas_input = Get_Pipe_Input()
	gas_output = Get_Pipe_Output()

	if(gas_input)
		pump_gas_passive(src, gas_input, gas_storage)

	var/decay_heat = 0
	var/activerods = 0
	var/disabledrods = 0
	var/meltedrods = 0
	var/meltingrods = 0

	for(var/obj/item/fuel_rod/rod in rods)
		if(rod.is_melted())
			meltedrods++
		else if(rod.temperature >= rod.melting_point)
			meltingrods++
		if(cutoff_temp > 0 && rod.reflective && temperature > cutoff_temp && rod.insertion > 0)
			rod.insertion = 0
			disabledrods++
		if(rod.life > 0)
			decay_heat += rod.tick_life(decay_archived > 0 ? 1 : 0)
			if(rod.reflective)
				activerods += rod.get_insertion()
			else
				activerods -= rod.get_insertion()

	if(disabledrods > 0 && !exploded)
		radio.autosay("Core exceeded temperature bounds, and has been shut down.", "Nuclear Monitor", "Engineering")
	announce_warning(meltedrods, meltingrods, (temperature >= max_temp && !(max_temp <= 0)) ? 1 : 0)

	decay_archived = decay_heat
	adjust_thermal_energy(decay_heat * activerods * (control_average/100))

	for(var/obj/item/fuel_rod/rod in rods)
		rod.equalize(src, gasefficiency)

	equalize(gas_storage, envefficiency)

	if(max_temp > 0 && temperature > max_temp && health > 0) // Overheating, reduce structural integrity, emit more rads.
		health = max(0, health - (temperature / max_temp))
		health = clamp( health, 0,  max_health)
		//if(health < 1)
			//go_nuclear()

	var/healthmul = ((health / max_health) - 1) / -1
	var/power = (decay_heat / REACTOR_RADS_TO_MJ) * max(healthmul, 0.1)
	PulseRadiation(src, max(power * REACTOR_RADIATION_MULTIPLIER, 0), 10)

	if(gas_output)
		pump_gas_passive(src, gas_storage, gas_output)


/datum/multistructure/nuclear_reactor/Topic(href, href_list)
	..()

	if(href_list["close"])
		usr << browse(null, "window=NRcontrol")
		usr.unset_machine()
		return

	if(href_list["scram"])
		scram()
		Console?.updateDialog()
		return

	if(href_list["set_target_height"])
		var/new_height = input(usr, "What height should the control rods be at?", "Control Rods", 0) as null|num
		for(var/obj/machinery/multistructure/nuclear_reactor_part/control_rod/CR in control_spots)
			CR.height = clamp(new_height, 0, 100)
		control_average = Get_Average_Control_Height()
		Console?.updateDialog()
		return

	Console?.updateDialog()
	return

/datum/multistructure/nuclear_reactor/proc/scram()
	for(var/obj/machinery/multistructure/nuclear_reactor_part/control_rod/CR in control_spots)
		CR.height = 0

/datum/multistructure/nuclear_reactor/proc/Get_Average_Control_Height()
	var/sum_rod = 0
	for(var/obj/machinery/multistructure/nuclear_reactor_part/control_rod/CR in control_spots)
		sum_rod += CR.Get_Rod_Height()
	var/average = sum_rod / control_spots.len
	return average

/datum/multistructure/nuclear_reactor/proc/Get_Fuel_Rods(var/count_empty = TRUE)
	. = list()
	for(var/obj/machinery/multistructure/nuclear_reactor_part/fuel_rod/FR in fuel_spots)
		if(FR.current_step < STEP_PULLED && FR.fuel)
			if(count_empty)
				. += FR.fuel
			else if(FR.fuel.integrity > 0)
				. += FR.fuel

/datum/multistructure/nuclear_reactor/proc/Get_Pipe_Input()
	var/obj/machinery/atmospherics/pipe/P = locate() in orange(1, wall_input)
	return P?.return_air()

/datum/multistructure/nuclear_reactor/proc/Get_Pipe_Output()
	var/obj/machinery/atmospherics/pipe/P = locate() in orange(1, wall_output)
	return P?.return_air()

/datum/multistructure/nuclear_reactor/proc/Get_HTML()
	var/dat = ""
	dat += "Nuclear Reactor Control Panel<BR>"
	dat += "<A href='?src=\ref[src];close=1'>Close</A><BR>"
	dat += "<A href='?src=\ref[src];refresh=1'>Refresh</A><BR>"
	dat += "<A href='?src=\ref[src];scram=1'>SCRAM</A><BR>"
	dat += "Reactor Integrity : [get_integrity()]%<BR>"
	dat += "Control Rods Height: [control_average]% | <A href='?src=\ref[src];set_target_height=1'>Set</A><BR>"
	dat += "Reactor Temperature: [temperature - T0C] C<BR>"

	if(!gas_input)
		dat += "WARNING! NO INPUT DETECTED!<BR>"

	if(!gas_output)
		dat += "WARNING! NO OUTPUT DETECTED!<BR>"

	dat += "Fuel Rods Status: <BR>"
	var/counter = 0
	for(var/obj/item/fuel_rod/FR in Get_Fuel_Rods())
		counter++
		dat += "Fuel Rod [counter] - [FR.life]%<BR>"

	return dat

// ----------------

/datum/multistructure/nuclear_reactor/proc/equalize(datum/gas_mixture/env, var/efficiency)
	var/datum/gas_mixture/sharer = env.remove(efficiency * env.total_moles)

	if(!sharer)
		return

	var/our_heatcap = heat_capacity()
	var/share_heatcap = sharer.heat_capacity()

	if((abs(temperature-sharer.temperature)>MINIMUM_MEANINGFUL_TEMPERATURE_DELTA) && our_heatcap + share_heatcap)
		var/new_temperature = ((temperature * our_heatcap) + (sharer.temperature * share_heatcap)) / (our_heatcap + share_heatcap)
		temperature += (new_temperature - temperature)
		temperature = clamp( temperature, 0,  REACTOR_TEMPERATURE_CUTOFF)
		sharer.temperature += (new_temperature - sharer.temperature)
		sharer.temperature = clamp( sharer.temperature, 0,  REACTOR_TEMPERATURE_CUTOFF)

	env.merge(sharer)

/datum/multistructure/nuclear_reactor/proc/adjust_thermal_energy(var/thermal_energy)
	if(mass < 1)
		return 0

	var/heat_capacity = heat_capacity()
	if(thermal_energy < 0)
		if(temperature < TCMB)
			return 0
		var/thermal_energy_limit = -(temperature - TCMB)*heat_capacity	//ensure temperature does not go below TCMB
		thermal_energy = max(thermal_energy, thermal_energy_limit)	//thermal_energy and thermal_energy_limit are negative here.
	temperature += thermal_energy/heat_capacity
	return thermal_energy

/datum/multistructure/nuclear_reactor/proc/heat_capacity()
	. = specific_heat * (mass / molar_mass)

/datum/multistructure/nuclear_reactor/proc/get_integrity()
	var/integrity = round(health / max_health * 100)
	integrity = integrity < 0 ? 0 : integrity
	return integrity

/datum/multistructure/nuclear_reactor/proc/announce_warning(var/meltedrods, var/meltingrods, var/core_overheat)
	if(!exploded && (meltedrods > 0 || meltingrods > 0 || temperature >= max_temp))
		var/location = sanitize((get_area(wall_input)).name)
		if((world.timeofday - lastwarning) >= warning_delay * 10)
			lastwarning = world.timeofday
			if(core_overheat)
				radio.autosay("Danger! Fission core at [location] is overheating!", "Nuclear Monitor")
			else if(meltedrods > 0 && meltingrods > 0)
				radio.autosay("Warning! [meltedrods] rods have melted and [meltingrods] are overheating!", "Nuclear Monitor", "Engineering")
			else if(meltedrods > 0)
				if(meltedrods == 1)
					radio.autosay("Warning! A rod has melted!", "Nuclear Monitor", "Engineering")
				else
					radio.autosay("Warning! [meltedrods] rods have melted!", "Nuclear Monitor", "Engineering")
			else if(meltingrods > 0)
				if(meltingrods == 1)
					radio.autosay("Warning! A rod is overheating!", "Nuclear Monitor", "Engineering")
				else
					radio.autosay("Warning! [meltingrods] rods are overheating!", "Nuclear Monitor", "Engineering")

/*
/datum/multistructure/nuclear_reactor/proc/go_nuclear()
	if(health < 1 && !exploded)
		var/off_station = 0
		if(!(src.z in (LEGACY_MAP_DATUM).station_levels))
			off_station = 1
		var/turf/L = get_turf(wall_input)
		if(!istype(L))
			return
		message_admins("[name] exploding in 15 seconds at ([L.x],[L.y],[L.z] - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[L.x];Y=[L.y];Z=[L.z]'>JMP</a>)",0,1)
		log_game("[name] exploded at ([L.x],[L.y],[L.z])")
		exploded = 1
		if(!anchored)
			anchor()
		var/decaying_rods = 0
		var/decay_heat = 0
		for(var/obj/item/fuel_rod/rod in rods)
			if(rod.life > 0 && rod.decay_heat > 0)
				decay_heat += rod.tick_life()
				decaying_rods++
			rod.meltdown()
		var/rad_power = decay_heat / REACTOR_RADS_TO_MJ
		if(announce)
			var/sound = sound('sound/effects/nuclear_meltdown.ogg')
			if(!off_station)
				for(var/mob/M in GLOB.player_list)
					SEND_SOUND(M,sound)
			spawn(1 SECONDS)
				radio.autosay("DANGER! FISSION CORE HAS BREACHED!", "Nuclear Monitor")
				radio.autosay("FIND SHELTER IMMEDIATELY!", "Nuclear Monitor")
			spawn(5 SECONDS)
				radio.autosay("CORE BREACH! FIND SHELTER IMMEDIATELY!", "Nuclear Monitor")
			spawn(10 SECONDS)
				radio.autosay("CORE BREACH! FIND SHELTER IMMEDIATELY!", "Nuclear Monitor")

		// Give the alarm time to play. Then... FLASH! AH-AH!
		spawn(15 SECONDS)
			z_radiation(get_turf(src), null, rad_power * BREACH_RADIATION_MULTIPLIER / RAD_MOB_ACT_COEFFICIENT, RAD_FALLOFF_ZLEVEL_FISSION_MELTDOWN)

		// Some engines just want to see the world burn.
		spawn(17 SECONDS)
			for(var/obj/item/fuel_rod/rod in rods)
				rod.forceMove(L)
			rods.Cut()
			pipes.Cut()
			empulse(src, decaying_rods * 10, decaying_rods * 100)
			var/explosion_power = 4 * decaying_rods
			if(explosion_power < 1) // If you remove the rods but it's over heating, it's still gunna go bang, but without going nuclear.
				explosion_power = 1
			explosion(L, explosion_power, explosion_power * 2, explosion_power * 3, explosion_power * 4, 1)
*/
