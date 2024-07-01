// This is the actual reactor.

/datum/multistructure/nuclear_reactor
	structure = list(
		list(/obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall),
		list(/obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/control_rod, /obj/machinery/multistructure/nuclear_reactor_part/fuel_rod, /obj/machinery/multistructure/nuclear_reactor_part/control_rod, /obj/machinery/multistructure/nuclear_reactor_part/wall),
		list(/obj/machinery/multistructure/nuclear_reactor_part/wall_input, /obj/machinery/multistructure/nuclear_reactor_part/fuel_rod, /obj/machinery/multistructure/nuclear_reactor_part/control_rod, /obj/machinery/multistructure/nuclear_reactor_part/fuel_rod, /obj/machinery/multistructure/nuclear_reactor_part/wall_output),
		list(/obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/control_rod, /obj/machinery/multistructure/nuclear_reactor_part/fuel_rod, /obj/machinery/multistructure/nuclear_reactor_part/control_rod, /obj/machinery/multistructure/nuclear_reactor_part/wall),
		list(/obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall, /obj/machinery/multistructure/nuclear_reactor_part/wall)
					)

	var/core_temperature = T20C
	var/target_temperature = 5000 //At what temperature do we try to keep the core at?
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

	Console = locate() in get_area(wall_input)
	Console?.Reactor = src

/datum/multistructure/nuclear_reactor/Process()
	control_average = Get_Average_Control_Height()
	if(!Console)
		Console = locate() in get_area(wall_input)
		Console?.Reactor = src

	gas_input = Get_Pipe_Input()
	gas_output = Get_Pipe_Output()

	if(gas_input)
		pump_gas_passive(src, gas_input, gas_storage)

	var/temp_to_add = 0
	var/fuel_amount = length(Get_Fuel_Rods())
	for(var/obj/item/fuel_rod/FR in Get_Fuel_Rods())
		temp_to_add += FR.heat_production * (control_average/100)
		FR.durability -= FR.consumption_rate * (control_average/100) * fuel_amount
	temp_to_add *= (1 << fuel_amount - 1)

	core_temperature += temp_to_add

	// This is where the reactor dumps its excess heat into the gas
	if(core_temperature > target_temperature)
		var/temp_difference = core_temperature - target_temperature
		gas_storage.add_thermal_energy(gas_storage.get_thermal_energy_change(gas_storage.temperature + temp_difference))
		core_temperature -= temp_difference

	if(gas_output)
		pump_gas_passive(src, gas_storage, gas_output)

	Console?.updateDialog()


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

/datum/multistructure/nuclear_reactor/proc/Get_Fuel_Rods()
	. = list()
	for(var/obj/machinery/multistructure/nuclear_reactor_part/fuel_rod/FR in fuel_spots)
		if(FR.fuel && FR.fuel.durability > 0)
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

	dat += "Control Rods Height: [control_average]% | <A href='?src=\ref[src];set_target_height=1'>Set</A><BR>"
	dat += "Reactor Temperature: [core_temperature]<BR>"

	if(!gas_input)
		dat += "WARNING! NO INPUT DETECTED!<BR>"

	if(!gas_output)
		dat += "WARNING! NO OUTPUT DETECTED!<BR>"

	dat += "Fuel Rods Status: <BR>"
	var/counter = 0
	for(var/obj/item/fuel_rod/FR in Get_Fuel_Rods())
		counter++
		dat += "Fuel Rod [counter] - [FR.durability]%<BR>"

	return dat
