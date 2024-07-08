/obj/machinery/multistructure/nuclear_reactor_part
	icon = './placeholders.dmi'
	MS_type = /datum/multistructure/nuclear_reactor
	anchored = TRUE

/obj/machinery/multistructure/nuclear_reactor_part/wall
	name = "containement wall"
	icon_state = "wall"

/obj/machinery/multistructure/nuclear_reactor_part/wall_input
	name = "reactor gas input"
	icon_state = "wall_input"

/obj/machinery/multistructure/nuclear_reactor_part/wall_output
	name = "reactor gas output"
	icon_state = "wall_output"

/obj/item/control_rod
	name = "control rod"
	desc = "A rod made of graphite, designed to moderate nuclear reactions by its presence."
	icon = 'placeholders.dmi'
	icon_state = "control_rod"
	var/durability = 100

/obj/item/fuel_rod
	name = "aetherium fuel rod"
	desc = "You shouldn't be seeing this."
	icon = 'placeholders.dmi'
	icon_state = "fuel_rod"

	var/gasefficiency = 0.05
	var/insertion = 0
	var/integrity = 100
	var/integrity_max = 100
	var/life = 100
	var/lifespan = 3600
	var/reflective = 1
	var/temperature = T20C
	var/specific_heat = 1	// J/(mol*K) - Caluclated by: (specific heat) [kJ/kg*K] * (molar mass) [g/mol] (g/mol = kg/mol * 1000, duh.)
	var/molar_mass = 1	// kg/mol
	var/mass = 1 // kg
	var/melting_point = 3000 // Entering the danger zone.
	var/decay_heat = 0 // MJ/mol (Yes, using MegaJoules per Mole. Techincally reduces power, but that reflects reduced lifespan.)

/obj/item/fuel_rod/aetherium
	name = "aetherium fuel rod"
	desc = "A rod made of aetherium, acting as a suitable substitute for proper nuclear fuel. It is contained within a lead casing."
	//heat_production = 50

/obj/item/fuel_rod/plutonium
	name = "plutonium fuel rod"
	desc = "A rod made of plutonium, acting as a suitable substitute for proper nuclear fuel. It is contained within a lead casing."
	specific_heat = 36	// J/(mol*K)
	molar_mass = 0.244	// kg/mol
	mass = 5 // kg
	melting_point = 914
	decay_heat = 20342002 // MJ/mol
	lifespan = 1800

/obj/item/fuel_rod/uranium
	name = "uranium fuel rod"
	desc = "A rod made of uranium, acting as a suitable substitute for proper nuclear fuel. It is contained within a lead casing."
	specific_heat = 28	// J/(mol*K)
	molar_mass = 0.235	// kg/mol
	mass = 20 // kg
	melting_point = 1405
	decay_heat = 19536350 // MJ/mol



/obj/item/fuel_rod/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/fuel_rod/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/fuel_rod/Process()
	if(isnull(loc))
		return PROCESS_KILL

	if(!istype(loc, /obj/machinery/multistructure/nuclear_reactor_part/fuel_rod))
		var/turf/T = get_turf(src)
		equalize(T.return_air(), gasefficiency)

		if(decay_heat > 0)
			var/insertion_multiplier = ROD_EXPOSED_POWER
			if(integrity == 0)
				insertion_multiplier = 1
			var/power = (tick_life(0, insertion_multiplier) / REACTOR_RADS_TO_MJ)
			adjust_thermal_energy(power)
			PulseRadiation(src, max(power * ROD_RADIATION_MULTIPLIER, 0), 10)

/obj/item/fuel_rod/proc/equalize(var/E, var/efficiency)
	var/our_heatcap = heat_capacity()
	// Ugly code ahead. Thanks for not allowing polymorphism, Byond.
	if(istype(E, /datum/multistructure/nuclear_reactor))
		var/datum/multistructure/nuclear_reactor/sharer = E
		var/share_heatcap = sharer.heat_capacity()

		if(our_heatcap + share_heatcap)
			var/new_temperature = ((temperature * our_heatcap) + (sharer.temperature * share_heatcap)) / (our_heatcap + share_heatcap)
			temperature += (new_temperature - temperature) * efficiency // Add efficiency here, since there's no gas.remove for non-gas objects.
			temperature = clamp(temperature, 0, ROD_TEMPERATURE_CUTOFF)
			sharer.temperature += (new_temperature - sharer.temperature) * efficiency
			sharer.temperature = clamp( sharer.temperature, 0,  ROD_TEMPERATURE_CUTOFF)
	else if(istype(E, /datum/gas_mixture))
		var/datum/gas_mixture/env = E
		var/datum/gas_mixture/sharer = env.remove(efficiency * env.total_moles)
		var/share_heatcap = sharer.heat_capacity()

		if(our_heatcap + share_heatcap)
			var/new_temperature = ((temperature * our_heatcap) + (sharer.temperature * share_heatcap)) / (our_heatcap + share_heatcap)
			temperature += (new_temperature - temperature) * efficiency
			temperature = clamp(temperature, 0, ROD_TEMPERATURE_CUTOFF)
			sharer.temperature += (new_temperature - sharer.temperature)
			sharer.temperature = clamp( sharer.temperature, 0,  ROD_TEMPERATURE_CUTOFF)
		env.merge(sharer)

	var/integrity_lost = integrity
	if(temperature > melting_point && melting_point > 0)
		integrity = max(0, integrity - (temperature / melting_point))
	else if(temperature > (melting_point * 0.9))
		integrity = max(0, integrity - ((1 / lifespan) * 100))
	if(integrity == 0 && integrity_lost > 0) // Meltdown time.
		meltdown()

/obj/item/fuel_rod/proc/adjust_thermal_energy(var/thermal_energy)
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

/obj/item/fuel_rod/proc/heat_capacity()
	. = specific_heat * (mass / molar_mass)

/obj/item/fuel_rod/proc/tick_life(var/apply_heat = 0, var/insertion_override = 0)
	var/applied_insertion = get_insertion()
	if(insertion_override)
		applied_insertion = insertion_override
	if(lifespan < 1 && life > 0)
		life = 0
	else if(life > 0)
		if(decay_heat > 0 || apply_heat)
			life = max(0, life - ((1 / lifespan) * applied_insertion * 100))
		if(life == 0 && integrity > 0)
			name = "depleted [name]"
		else if(decay_heat > 0)
			return ((decay_heat * (mass / molar_mass)) / lifespan) * (min(life, 100) / 100) * applied_insertion
	return 0

/obj/item/fuel_rod/proc/get_insertion()
	var/applied_insertion = 1
	if(istype(loc, /obj/machinery/multistructure/nuclear_reactor_part/fuel_rod) && icon_state != "rod_melt")
		applied_insertion = insertion
	return clamp( applied_insertion, 0,  1)

/obj/item/fuel_rod/proc/is_melted()
	return (icon_state == "rod_melt") ? 1 : 0

/obj/item/fuel_rod/proc/meltdown()
	if(!is_melted())
		if(decay_heat > 0)
			life = life * 10
			decay_heat = 0 // Original was decay_heat * 10. Setting to 0 to counter memes (Testing phase. Unsure HOW much this is going to destroy everything)
		else
			life = 0
		name = "melted [name]"
		//icon_state = "rod_melt" // TODO
		integrity = 0
