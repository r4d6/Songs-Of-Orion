//Gas nozzle engine
/datum/ship_engine/gas_thruster
	name = "gas thruster"
	var/obj/machinery/atmospherics/unary/engine/nozzle

/datum/ship_engine/gas_thruster/New(obj/machinery/_holder)
	..()
	nozzle = _holder

/datum/ship_engine/gas_thruster/Destroy()
	nozzle = null
	. = ..()

/datum/ship_engine/gas_thruster/get_status()
	return nozzle.get_status()

/datum/ship_engine/gas_thruster/get_thrust()
	return nozzle.get_thrust()

/datum/ship_engine/gas_thruster/burn()
	return nozzle.burn()

/datum/ship_engine/gas_thruster/set_thrust_limit(new_limit)
	nozzle.thrust_limit = new_limit

/datum/ship_engine/gas_thruster/get_thrust_limit()
	return nozzle.thrust_limit

/datum/ship_engine/gas_thruster/is_on()
	return nozzle.is_on()

/datum/ship_engine/gas_thruster/toggle()
	nozzle.on = !nozzle.on

/datum/ship_engine/gas_thruster/can_burn()
	return nozzle.is_on() && nozzle.check_fuel()

//Actual thermal nozzle engine object

/obj/machinery/atmospherics/unary/engine
	name = "rocket nozzle"
	desc = "Simple rocket nozzle, expelling gas at hypersonic velocities to propel the ship."
	icon = 'icons/obj/ship_engine.dmi'
	icon_state = "nozzle"
	use_power = NO_POWER_USE
	idle_power_usage = 150		//internal circuitry, friction losses and stuff
	power_rating = 7500			//7500 W ~ 10 HP
	opacity = 0
	density = TRUE
	var/on = TRUE
	var/datum/ship_engine/gas_thruster/controller
	var/thrust_limit = 1	//Value between 1 and 0 to limit the resulting thrust
	var/moles_per_burn = 5
	atmos_canpass = CANPASS_NEVER

/obj/machinery/atmospherics/unary/engine/Initialize()
	. = ..()
	controller = new(src)

/obj/machinery/atmospherics/unary/engine/Destroy()
	if(controller)
		qdel(controller)
	. = ..()

/obj/machinery/atmospherics/unary/engine/proc/get_status()
	. = list()
	.+= "Location: [get_area(src)]."
	if(!powered())
		.+= "Insufficient power to operate."
	if(!check_fuel())
		.+= "Insufficient fuel for a burn."

	.+= "Propellant total mass: [round(air_contents.get_mass(),0.01)] kg."
	.+= "Propellant used per burn: [round(air_contents.specific_mass() * moles_per_burn * thrust_limit,0.01)] kg."
	.+= "Propellant pressure: [round(air_contents.return_pressure()/1000,0.1)] MPa."
	. = jointext(.,"<br>")

/obj/machinery/atmospherics/unary/engine/proc/is_on()
	return on && powered()

/obj/machinery/atmospherics/unary/engine/proc/check_fuel()
	return air_contents.total_moles > moles_per_burn * thrust_limit

/obj/machinery/atmospherics/unary/engine/proc/get_thrust()
	if(!is_on() || !check_fuel())
		return 0
	var/used_part = moles_per_burn/air_contents.get_total_moles() * thrust_limit
	. = calculate_thrust(air_contents, used_part)
	return

/obj/machinery/atmospherics/unary/engine/proc/burn()
	if(!is_on())
		return 0
	if(!check_fuel())
		audible_message(src,"<span class='warning'>[src] coughs once and goes silent!</span>")
		on = !on
		return 0
	var/datum/gas_mixture/removed = air_contents.remove(moles_per_burn * thrust_limit)
	if(!removed)
		return 0
	. = calculate_thrust(removed)
	playsound(get_turf(src), 'sound/machines/thruster.ogg', 100 * thrust_limit, 0, world.view * 4, 0.1)
	var/exhaust_dir = reverse_direction(dir)
	var/turf/T = get_step(src,exhaust_dir)
	var/range = clamp(round(.), 1, 8)
	if(T)
		T.assume_air(removed)
		// if its 1000k hot
		new/obj/effect/engine_exhaust(T, exhaust_dir, air_contents.temperature >= 1000, (range > 1))
		for(var/i=1,i < range,i++)
			T = get_step(T,exhaust_dir)
			if(!T)
				break
			addtimer(CALLBACK(src, PROC_REF(extend_plume), T, exhaust_dir, air_contents.temperature >= 1000, i != range - 1), i * 0.5, TIMER_UNIQUE)
	if(network)
		// Makes it so thruster keeps getting gas from connected pipes
		network.update = 1


/obj/machinery/atmospherics/unary/engine/proc/extend_plume(turf/T, exhaust_dir, is_flame, is_midsection)
	new/obj/effect/engine_exhaust(T, exhaust_dir, is_flame, is_midsection)

/obj/machinery/atmospherics/unary/engine/proc/calculate_thrust(datum/gas_mixture/propellant, used_part = 1)
	return round(sqrt(propellant.get_mass() * used_part * air_contents.return_pressure()/100),0.1)

//Exhaust effect
/obj/effect/engine_exhaust
	name = "engine exhaust"
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	light_color = COLOR_LIGHTING_ORANGE_BRIGHT
	anchored = TRUE

/obj/effect/engine_exhaust/New(turf/nloc, ndir, flame, midsect)
	..(nloc)
	if(flame)
		if(midsect)
			icon_state = "exhaust_mid"
		else
			icon_state = "exhaust"
		nloc.hotspot_expose(1000,125)
		set_light(5, 2)
	set_dir(ndir)
	spawn(20)
		qdel(src)

/obj/item/electronics/circuitboard/unary_atmos/engine
	name = T_BOARD("gas thruster")
	icon_state = "mcontroller"
	build_path = /obj/machinery/atmospherics/unary/engine/
	origin_tech = list(TECH_POWER = 1, TECH_ENGINEERING = 2)
	req_components = list(
							/obj/item/stack/cable_coil = 2,
							/obj/item/stock_parts/matter_bin = 1,
							/obj/item/stock_parts/capacitor = 1,
							/obj/item/pipe = 2)
