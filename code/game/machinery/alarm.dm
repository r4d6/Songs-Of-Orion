/obj/machinery/alarm
	name = "alarm"
	icon = 'icons/obj/monitors.dmi'
	icon_state = "alarm0"
	anchored = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 80
	active_power_usage = 3000 //For heating/cooling rooms. 1000 joules equates to about 1 degree every 2 seconds for a single tile of air.
	power_channel = STATIC_ENVIRON
	req_one_access = list(access_atmospherics, access_engine_equip)
	var/alarm_id = null
	var/breach_detection = 1 // Whether to use automatic breach detection or not
	var/frequency = 1439
	//var/skipprocess = 0 //Experimenting
	var/alarm_frequency = 1437
	var/remote_control = 0
	var/rcon_setting = 2
	var/rcon_time = 0
	var/locked = TRUE
	var/wiresexposed = FALSE // If it's been screwdrivered open.
	var/aidisabled = 0
	var/shorted = 0

	var/datum/wires/alarm/wires

	var/mode = AALARM_MODE_SCRUBBING
	var/screen = AALARM_SCREEN_MAIN
	var/area_uid
	var/area/alarm_area
	var/buildstage = 2 //2 is built, 1 is building, 0 is frame.

	var/target_temperature = T0C + 20
	var/regulating_temperature = 0

	var/datum/radio_frequency/radio_connection

	var/list/TLV = list()
	var/list/trace_gas = list("sleeping_agent") //list of other gases that this air alarm is able to detect

	var/danger_level = 0
	var/pressure_dangerlevel = 0
	var/oxygen_dangerlevel = 0
	var/co2_dangerlevel = 0
	var/plasma_dangerlevel = 0
	var/temperature_dangerlevel = 0
	var/other_dangerlevel = 0

	var/report_danger_level = 1

/obj/machinery/alarm/nobreach
	breach_detection = 0

/obj/machinery/alarm/monitor
	report_danger_level = 0
	breach_detection = 0

/obj/machinery/alarm/server/New()
	..()
	req_access = list(access_rd, access_atmospherics, access_engine_equip)
	TLV["oxygen"] =			list(-1.0, -1.0,-1.0,-1.0) // Partial pressure, kpa
	TLV["carbon dioxide"] = list(-1.0, -1.0,   5,  10) // Partial pressure, kpa
	TLV["plasma"] =			list(-1.0, -1.0, 0.2, 0.5) // Partial pressure, kpa
	TLV["other"] =			list(-1.0, -1.0, 0.5, 1.0) // Partial pressure, kpa
	TLV["pressure"] =		list(0, ONE_ATMOSPHERE * 0.10, ONE_ATMOSPHERE * 1.40, ONE_ATMOSPHERE * 1.60) /* kpa */
	TLV["temperature"] =	list(20, 40, 140, 160) // K
	target_temperature = 90

/obj/machinery/alarm/Destroy()
	GLOB.alarm_list -= src
	unregister_radio(src, frequency)
	qdel(wires)
	wires = null
	return ..()

/obj/machinery/alarm/New(loc, dir, building = 0)
	GLOB.alarm_list += src
	if(building)
		if(dir)
			src.set_dir(dir)

		buildstage = 0
		wiresexposed = 1
		pixel_x = (dir & 3)? 0 : (dir == 4 ? -24 : 24)
		pixel_y = (dir & 3)? (dir ==1 ? -24 : 24) : 0
		update_icon()

	..()

	if(!building)
		first_run()

/obj/machinery/alarm/proc/first_run()
	alarm_area = get_area(src)
	if(!alarm_area)
		error("Alarm cant find an area - [type] - [x]:[y]:[z]")
		return
	area_uid = alarm_area.uid
	if(name == "alarm")
		name = "[strip_improper(alarm_area.name)] Air Alarm"

	if(!wires)
		wires = new(src)

	// breathable air according to human/Life()
	TLV["oxygen"] =			list(16, 19, 135, 140) // Partial pressure, kpa
	TLV["carbon dioxide"] = list(-1.0, -1.0, 5, 10) // Partial pressure, kpa
	TLV["plasma"] =			list(-1.0, -1.0, 0.2, 0.5) // Partial pressure, kpa
	TLV["other"] =			list(-1.0, -1.0, 0.5, 1.0) // Partial pressure, kpa
	TLV["pressure"] =		list(ONE_ATMOSPHERE*0.80,ONE_ATMOSPHERE*0.90,ONE_ATMOSPHERE*1.10,ONE_ATMOSPHERE*1.20) /* kpa */
	TLV["temperature"] =	list(T0C-26, T0C, T0C+40, T0C+66) // K


/obj/machinery/alarm/Initialize()
	. = ..()
	set_frequency(frequency)
	if(buildstage == 2 && !master_is_operating())
		elect_master()

/obj/machinery/alarm/fire_act()
	return

/obj/machinery/alarm/Process()
	if((stat & (NOPOWER|BROKEN)) || shorted || buildstage != 2)
		return

	var/turf/location = loc
	if(!istype(location))
		return//returns if loc is not simulated

	var/datum/gas_mixture/environment = location.return_air()
	if(!environment)
		return
	//Handle temperature adjustment here.
	handle_heating_cooling(environment)

	var/old_level = danger_level
	var/old_pressurelevel = pressure_dangerlevel
	danger_level = overall_danger_level(environment)

	if(old_level != danger_level)
		apply_danger_level(danger_level)

	if(old_pressurelevel != pressure_dangerlevel)
		if(breach_detected())
			apply_mode(AALARM_MODE_OFF)

	if(mode==AALARM_MODE_CYCLE && environment.return_pressure()<ONE_ATMOSPHERE*0.05)
		apply_mode(AALARM_MODE_FILL)

	//atmos computer remote controll stuff
	switch(rcon_setting)
		if(RCON_NO)
			remote_control = 0
		if(RCON_AUTO)
			if(danger_level == 2)
				remote_control = 1
			else
				remote_control = 0
		if(RCON_YES)
			remote_control = 1

/obj/machinery/alarm/proc/handle_heating_cooling(datum/gas_mixture/environment)
	if(!regulating_temperature)
		//check for when we should start adjusting temperature
		if(get_danger_level(environment.temperature, TLV["temperature"]) || abs(environment.temperature - target_temperature) > 2)
			set_power_use(ACTIVE_POWER_USE)
			regulating_temperature = 1
			visible_message("\The [src] clicks as it starts up.",\
			"You hear a click and a faint electronic hum.")
	else
		//check for when we should stop adjusting temperature
		if(!get_danger_level(environment.temperature, TLV["temperature"]) && abs(environment.temperature - target_temperature) <= 0.5)
			set_power_use(IDLE_POWER_USE)
			regulating_temperature = 0
			visible_message("\The [src] clicks quietly.",\
			"You hear a click as a faint electronic humming stops.")

	if(regulating_temperature)
		if(target_temperature > T0C + MAX_TEMPERATURE)
			target_temperature = T0C + MAX_TEMPERATURE
		else if(target_temperature < T0C + MIN_TEMPERATURE)
			target_temperature = T0C + MIN_TEMPERATURE

		if(environment.total_moles)
			var/thermalChange = environment.get_thermal_energy_change(target_temperature)
			if(environment.temperature <= target_temperature)
				//gas heating
				var/energy_used = min(thermalChange, active_power_usage)
				environment.add_thermal_energy(energy_used)
			else
				//gas cooling
				var/heat_transfer = min(abs(thermalChange), active_power_usage)
				//Assume the heat is being pumped into the hull which is fixed at 20 C
				//none of this is really proper thermodynamics but whatever

				var/cop = environment.temperature/T20C	//coefficient of performance -> power used = heat_transfer/cop
				heat_transfer = min(heat_transfer, cop * active_power_usage)	//this ensures that we don't use more than active_power_usage amount of power
				heat_transfer = -environment.add_thermal_energy(-heat_transfer)	//get the actual heat transfer
				//use_power(heat_transfer / cop, ENVIRON)	//handle by update_use_power instead

/obj/machinery/alarm/proc/overall_danger_level(datum/gas_mixture/environment)
	var/partial_pressure = R_IDEAL_GAS_EQUATION*environment.temperature/environment.volume
	var/environment_pressure = environment.return_pressure()

	var/other_moles = 0
	for(var/g in trace_gas)
		other_moles += environment.gas[g] //this is only going to be used in a partial pressure calc, so we don't need to worry about group_multiplier here.

	pressure_dangerlevel = get_danger_level(environment_pressure, TLV["pressure"])
	oxygen_dangerlevel = get_danger_level(environment.gas["oxygen"]*partial_pressure, TLV["oxygen"])
	co2_dangerlevel = get_danger_level(environment.gas["carbon_dioxide"]*partial_pressure, TLV["carbon dioxide"])
	plasma_dangerlevel = get_danger_level(environment.gas["plasma"]*partial_pressure, TLV["plasma"])
	temperature_dangerlevel = get_danger_level(environment.temperature, TLV["temperature"])
	other_dangerlevel = get_danger_level(other_moles*partial_pressure, TLV["other"])
	return max(
		pressure_dangerlevel,
		oxygen_dangerlevel,
		co2_dangerlevel,
		plasma_dangerlevel,
		other_dangerlevel,
		temperature_dangerlevel)

// Returns whether this air alarm thinks there is a breach, given the sensors that are available to it.
/obj/machinery/alarm/proc/breach_detected()
	var/turf/location = loc
	if(!istype(location))
		return 0

	if(breach_detection	== 0)
		return 0

	var/datum/gas_mixture/environment = location.return_air()
	var/environment_pressure = environment.return_pressure()
	var/pressure_levels = TLV["pressure"]

	if(environment_pressure <= pressure_levels[1])		//low pressures
		if(!(mode == AALARM_MODE_PANIC || mode == AALARM_MODE_CYCLE))
			return 1
	return 0

/obj/machinery/alarm/proc/master_is_operating()
	return alarm_area.master_air_alarm && !(alarm_area.master_air_alarm.stat & (NOPOWER|BROKEN))

/obj/machinery/alarm/proc/elect_master()
	for(var/obj/machinery/alarm/AA in alarm_area)
		if(!(AA.stat & (NOPOWER|BROKEN)))
			alarm_area.master_air_alarm = AA
			return 1
	return 0

/obj/machinery/alarm/proc/get_danger_level(current_value, list/danger_levels)
	if((current_value >= danger_levels[4] && danger_levels[4] > 0) || current_value <= danger_levels[1])
		return 2
	if((current_value >= danger_levels[3] && danger_levels[3] > 0) || current_value <= danger_levels[2])
		return 1
	return 0

/obj/machinery/alarm/update_icon()
	if(wiresexposed)
		switch(buildstage)
			if(2)
				icon_state = "alarm_build2"
			if(1)
				icon_state = "alarm_build1"
			if(0)
				icon_state = "alarm_build0"
		set_light(0)
		return

	if(stat & (BROKEN))
		icon_state = "alarm_broken"
		set_light(0)
		return

	if((stat & (NOPOWER)) || shorted)
		icon_state = "alarm_unpowered"
		set_light(0)
		return

	if(!alarm_area)
		error("Alarm cant find an area - [type] - [x]:[y]:[z]")
		return

	var/icon_level = danger_level
	if(alarm_area.atmosalm)
		icon_level = max(icon_level, 1)	//if there's an atmos alarm but everything is okay locally, no need to go past yellow

	var/new_color = null
	switch(icon_level)
		if(0)
			icon_state = "alarm0"
			new_color = COLOR_LIGHTING_GREEN_BRIGHT
		if(1)
			icon_state = "alarm1"
			new_color = COLOR_LIGHTING_ORANGE_MACHINERY
		if(2)
			icon_state = "alarm2"
			new_color = COLOR_LIGHTING_RED_MACHINERY

	set_light(l_range = 1.5, l_power = 0.2, l_color = new_color)

/obj/machinery/alarm/receive_signal(datum/signal/signal)
	if(stat & (NOPOWER|BROKEN))
		return
	if(alarm_area.master_air_alarm != src)
		if(master_is_operating())
			return
		elect_master()
		if(alarm_area.master_air_alarm != src)
			return
	if(!signal || signal.encryption)
		return
	var/id_tag = signal.data["tag"]
	if(!id_tag)
		return
	if(signal.data["area"] != area_uid)
		return
	if(signal.data["sigtype"] != "status")
		return

	var/dev_type = signal.data["device"]
	if(!(id_tag in alarm_area.air_scrub_names) && !(id_tag in alarm_area.air_vent_names))
		register_env_machine(id_tag, dev_type)
	if(dev_type == "AScr")
		alarm_area.air_scrub_info[id_tag] = signal.data
	else if(dev_type == "AVP")
		alarm_area.air_vent_info[id_tag] = signal.data

/obj/machinery/alarm/proc/register_env_machine(m_id, device_type)
	var/new_name
	if(device_type=="AVP")
		new_name = "[alarm_area.name] Vent Pump #[alarm_area.air_vent_names.len+1]"
		alarm_area.air_vent_names[m_id] = new_name
	else if(device_type=="AScr")
		new_name = "[alarm_area.name] Air Scrubber #[alarm_area.air_scrub_names.len+1]"
		alarm_area.air_scrub_names[m_id] = new_name
	else
		return
	spawn (10)
		send_signal(m_id, list("init" = new_name) )

/obj/machinery/alarm/proc/refresh_all()
	for(var/id_tag in alarm_area.air_vent_names)
		var/list/I = alarm_area.air_vent_info[id_tag]
		if(I && I["timestamp"]+AALARM_REPORT_TIMEOUT/2 > world.time)
			continue
		send_signal(id_tag, list("status") )
	for(var/id_tag in alarm_area.air_scrub_names)
		var/list/I = alarm_area.air_scrub_info[id_tag]
		if(I && I["timestamp"]+AALARM_REPORT_TIMEOUT/2 > world.time)
			continue
		send_signal(id_tag, list("status") )

/obj/machinery/alarm/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = SSradio.add_object(src, frequency, RADIO_TO_AIRALARM)

/obj/machinery/alarm/proc/send_signal(target, list/command)//sends signal 'command' to 'target'. Returns 0 if no radio connection, 1 otherwise
	if(!radio_connection)
		return 0

	var/datum/signal/signal = new
	signal.transmission_method = 1 //radio signal
	signal.source = src

	signal.data = command
	signal.data["tag"] = target
	signal.data["sigtype"] = "command"

	radio_connection.post_signal(src, signal, RADIO_FROM_AIRALARM)
//			world << text("Signal [] Broadcasted to []", command, target)
	return 1

/obj/machinery/alarm/proc/apply_mode(new_mode)
	//propagate mode to other air alarms in the area
	//TODO: make it so that players can choose between applying the new mode to the room they are in (related area) vs the entire alarm area
	if(new_mode)
		mode = new_mode
	for(var/obj/machinery/alarm/AA in alarm_area)
		AA.mode = mode

	switch(mode)
		if(AALARM_MODE_SCRUBBING)
			to_chat(usr, "Air Alarm mode changed to Filtering.")
			for(var/device_id in alarm_area.air_scrub_names)
				send_signal(device_id, list("power"= 1, "co2_scrub"= 1, "scrubbing"= 1, "panic_siphon"= 0) )
			for(var/device_id in alarm_area.air_vent_names)
				send_signal(device_id, list("power"= 1, "checks"= "default", "set_external_pressure"= "default") )

		if(AALARM_MODE_PANIC, AALARM_MODE_CYCLE)
			if(mode == AALARM_MODE_PANIC)
				to_chat(usr, "Air Alarm mode changed to Panic.")
			else
				to_chat(usr, "Air Alarm mode changed to Cycle.")
			for(var/device_id in alarm_area.air_scrub_names)
				send_signal(device_id, list("power"= 1, "panic_siphon"= 1) )
			for(var/device_id in alarm_area.air_vent_names)
				send_signal(device_id, list("power"= 0) )

		if(AALARM_MODE_REPLACEMENT)
			to_chat(usr, "Air Alarm mode changed to Replace Air.")
			for(var/device_id in alarm_area.air_scrub_names)
				send_signal(device_id, list("power"= 1, "panic_siphon"= 1) )
			for(var/device_id in alarm_area.air_vent_names)
				send_signal(device_id, list("power"= 1, "checks"= "default", "set_external_pressure"= "default") )

		if(AALARM_MODE_FILL)
			to_chat(usr, "Air Alarm mode changed to Fill.")
			for(var/device_id in alarm_area.air_scrub_names)
				send_signal(device_id, list("power"= 0) )
			for(var/device_id in alarm_area.air_vent_names)
				send_signal(device_id, list("power"= 1, "checks"= "default", "set_external_pressure"= "default") )

		if(AALARM_MODE_OFF)
			to_chat(usr, "Air Alarm mode changed to Off.")
			for(var/device_id in alarm_area.air_scrub_names)
				send_signal(device_id, list("power"= 0) )
			for(var/device_id in alarm_area.air_vent_names)
				send_signal(device_id, list("power"= 0) )

/obj/machinery/alarm/proc/apply_danger_level(new_danger_level)
	if(report_danger_level && alarm_area.atmosalert(new_danger_level, src))
		post_alert(new_danger_level)
	alarm_area.updateicon()
	update_icon()

/obj/machinery/alarm/proc/post_alert(alert_level)
	var/datum/radio_frequency/frequency = SSradio.return_frequency(alarm_frequency)
	if(!frequency)
		return

	var/datum/signal/alert_signal = new
	alert_signal.source = src
	alert_signal.transmission_method = 1
	alert_signal.data["zone"] = alarm_area.name
	alert_signal.data["type"] = "Atmospheric"

	if(alert_level==2)
		alert_signal.data["alert"] = "severe"
	else if(alert_level==1)
		alert_signal.data["alert"] = "minor"
	else if(alert_level==0)
		alert_signal.data["alert"] = "clear"

	frequency.post_signal(src, alert_signal)

/obj/machinery/alarm/attack_ai(mob/user)
	nano_ui_interact(user)

/obj/machinery/alarm/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	return interact(user)

/obj/machinery/alarm/interact(mob/user)
	nano_ui_interact(user)
	wires.Interact(user)

/obj/machinery/alarm/nano_ui_interact(mob/user, ui_key = "main", datum/nanoui/ui, force_open = NANOUI_FOCUS, master_ui, datum/nano_topic_state/state = GLOB.default_state)
	var/data[0]
	var/remote_connection = 0
	var/remote_access = 0
	if(state)
		var/list/href = state.href_list(user)
		remote_connection = href["remote_connection"]	// Remote connection means we're non-adjacent/connecting from another computer
		remote_access = href["remote_access"]			// Remote access means we also have the privilege to alter the air alarm.

	data["locked"] = locked && !issilicon(user)
	data["remote_connection"] = remote_connection
	data["remote_access"] = remote_access
	data["rcon"] = rcon_setting
	data["screen"] = screen

	populate_status(data)

	if(!(locked && !remote_connection) || remote_access || issilicon(user))
		populate_controls(data)

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "air_alarm.tmpl", src.name, 400, 625, master_ui = master_ui, state = state)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/alarm/proc/populate_status(data)
	var/turf/location = get_turf(src)
	var/datum/gas_mixture/environment = location.return_air()
	var/total = environment.total_moles
	var/list/environment_data = new
	data["has_environment"] = total
	if(total)
		var/pressure = environment.return_pressure()
		environment_data[++environment_data.len] = list("name" = "Pressure", "value" = pressure, "unit" = "kPa", "danger_level" = pressure_dangerlevel)
		environment_data[++environment_data.len] = list("name" = "Oxygen", "value" = environment.gas["oxygen"] / total * 100, "unit" = "%", "danger_level" = oxygen_dangerlevel)
		environment_data[++environment_data.len] = list("name" = "Carbon dioxide", "value" = environment.gas["carbon_dioxide"] / total * 100, "unit" = "%", "danger_level" = co2_dangerlevel)
		environment_data[++environment_data.len] = list("name" = "Toxins", "value" = environment.gas["plasma"] / total * 100, "unit" = "%", "danger_level" = plasma_dangerlevel)
		environment_data[++environment_data.len] = list("name" = "Temperature", "value" = environment.temperature, "unit" = "K ([round(environment.temperature - T0C, 0.1)]C)", "danger_level" = temperature_dangerlevel)
	data["total_danger"] = danger_level
	data["environment"] = environment_data
	data["atmos_alarm"] = alarm_area.atmosalm
	data["fire_alarm"] = alarm_area.fire != null
	data["target_temperature"] = "[target_temperature - T0C]C"

/obj/machinery/alarm/proc/populate_controls(list/data)
	switch(screen)
		if(AALARM_SCREEN_MAIN)
			data["mode"] = mode
		if(AALARM_SCREEN_VENT)
			var/vents[0]
			for(var/id_tag in alarm_area.air_vent_names)
				var/long_name = alarm_area.air_vent_names[id_tag]
				var/list/info = alarm_area.air_vent_info[id_tag]
				if(!info)
					continue
				vents[++vents.len] = list(
						"id_tag"			= id_tag,
						"long_name"			= sanitize(long_name),
						"power"				= info["power"],
						"expanded_range"	= info["expanded_range"],
						"checks"			= info["checks"],
						"direction"			= info["direction"],
						"external"			= info["external"]
					)
			data["vents"] = vents
		if(AALARM_SCREEN_SCRUB)
			var/scrubbers[0]
			for(var/id_tag in alarm_area.air_scrub_names)
				var/long_name = alarm_area.air_scrub_names[id_tag]
				var/list/info = alarm_area.air_scrub_info[id_tag]
				if(!info)
					continue
				scrubbers[++scrubbers.len] = list(
						"id_tag"			= id_tag,
						"long_name"			= sanitize(long_name),
						"power"				= info["power"],
						"expanded_range"	= info["expanded_range"],
						"scrubbing"			= info["scrubbing"],
						"panic"				= info["panic"],
						"filters"			= list()
					)
				scrubbers[scrubbers.len]["filters"] += list(list("name" = "Oxygen",			"command" = "o2_scrub",	"val" = info["filter_o2"]))
				scrubbers[scrubbers.len]["filters"] += list(list("name" = "Nitrogen",		"command" = "n2_scrub",	"val" = info["filter_n2"]))
				scrubbers[scrubbers.len]["filters"] += list(list("name" = "Carbon Dioxide", "command" = "co2_scrub","val" = info["filter_co2"]))
				scrubbers[scrubbers.len]["filters"] += list(list("name" = "Toxin"	, 		"command" = "tox_scrub","val" = info["filter_plasma"]))
				scrubbers[scrubbers.len]["filters"] += list(list("name" = "Nitrous Oxide",	"command" = "n2o_scrub","val" = info["filter_n2o"]))
			data["scrubbers"] = scrubbers
		if(AALARM_SCREEN_MODE)
			var/modes[0]
			modes[++modes.len] = list("name" = "Filtering - Scrubs out contaminants", 			"mode" = AALARM_MODE_SCRUBBING,		"selected" = mode == AALARM_MODE_SCRUBBING, 	"danger" = 0)
			modes[++modes.len] = list("name" = "Replace Air - Siphons out air while replacing", "mode" = AALARM_MODE_REPLACEMENT,	"selected" = mode == AALARM_MODE_REPLACEMENT,	"danger" = 0)
			modes[++modes.len] = list("name" = "Panic - Siphons air out of the room", 			"mode" = AALARM_MODE_PANIC,			"selected" = mode == AALARM_MODE_PANIC, 		"danger" = 1)
			modes[++modes.len] = list("name" = "Cycle - Siphons air before replacing", 			"mode" = AALARM_MODE_CYCLE,			"selected" = mode == AALARM_MODE_CYCLE, 		"danger" = 1)
			modes[++modes.len] = list("name" = "Fill - Shuts off scrubbers and opens vents", 	"mode" = AALARM_MODE_FILL,			"selected" = mode == AALARM_MODE_FILL, 			"danger" = 0)
			modes[++modes.len] = list("name" = "Off - Shuts off vents and scrubbers", 			"mode" = AALARM_MODE_OFF,			"selected" = mode == AALARM_MODE_OFF, 			"danger" = 0)
			data["modes"] = modes
			data["mode"] = mode
		if(AALARM_SCREEN_SENSORS)
			var/list/selected
			var/thresholds[0]

			var/list/gas_names = list(
				"oxygen"         = "O<sub>2</sub>",
				"carbon dioxide" = "CO<sub>2</sub>",
				"plasma"         = "Toxin",
				"other"          = "Other")
			for(var/g in gas_names)
				thresholds[++thresholds.len] = list("name" = gas_names[g], "settings" = list())
				selected = TLV[g]
				for(var/i = 1, i <= 4, i++)
					thresholds[thresholds.len]["settings"] += list(list("env" = g, "val" = i, "selected" = selected[i]))

			selected = TLV["pressure"]
			thresholds[++thresholds.len] = list("name" = "Pressure", "settings" = list())
			for(var/i = 1, i <= 4, i++)
				thresholds[thresholds.len]["settings"] += list(list("env" = "pressure", "val" = i, "selected" = selected[i]))

			selected = TLV["temperature"]
			thresholds[++thresholds.len] = list("name" = "Temperature", "settings" = list())
			for(var/i = 1, i <= 4, i++)
				thresholds[thresholds.len]["settings"] += list(list("env" = "temperature", "val" = i, "selected" = selected[i]))
			data["thresholds"] = thresholds

/obj/machinery/alarm/CanUseTopic(mob/user, datum/nano_topic_state/state, href_list = list())
	if(buildstage != 2)
		return STATUS_CLOSE

	if(aidisabled && isAI(user))
		to_chat(user, SPAN_WARNING("AI control for \the [src] interface has been disabled."))
		return STATUS_CLOSE

	. = shorted ? STATUS_DISABLED : STATUS_INTERACTIVE

	if(. == STATUS_INTERACTIVE)
		var/extra_href = state.href_list(usr)
		// Prevent remote users from altering RCON settings unless they already have access
		if(href_list["rcon"] && extra_href["remote_connection"] && !extra_href["remote_access"])
			. = STATUS_UPDATE

	return min(..(), .)

/obj/machinery/alarm/proc/forceClearAlarm()
	if(alarm_area.atmosalert(0, src))
		for(var/obj/machinery/alarm/AA in alarm_area) // also force all alarms in area to clear
			AA.apply_danger_level(0)
	update_icon()

/obj/machinery/alarm/Topic(href, href_list, datum/nano_topic_state/state)
	if(..(href, href_list, state))
		return 1

	// hrefs that can always be called -walter0o
	if(href_list["rcon"])
		playsound(loc, 'sound/machines/button.ogg', 100, 1)
		var/attempted_rcon_setting = text2num(href_list["rcon"])

		switch(attempted_rcon_setting)
			if(RCON_NO)
				rcon_setting = RCON_NO
			if(RCON_AUTO)
				rcon_setting = RCON_AUTO
			if(RCON_YES)
				rcon_setting = RCON_YES
		return 1

	if(href_list["temperature"])
		var/list/selected = TLV["temperature"]
		var/max_temperature = min(selected[3] - T0C, MAX_TEMPERATURE)
		var/min_temperature = max(selected[2] - T0C, MIN_TEMPERATURE)
		var/input_temperature = input("What temperature would you like the system to mantain? (Capped between [min_temperature] and [max_temperature]C)", "Thermostat Controls", target_temperature - T0C) as num|null
		if(isnum(input_temperature))
			if(input_temperature > max_temperature || input_temperature < min_temperature)
				to_chat(usr, "Temperature must be between [min_temperature]C and [max_temperature]C")
			else
				target_temperature = input_temperature + T0C
			investigate_log("had it's target temperature changed by [key_name(usr)]", "atmos")

		playsound(loc, 'sound/machines/button.ogg', 100, 1)
		return 1

	// hrefs that need the AA unlocked -walter0o

	var/extra_href
	if(state)
		extra_href = state.href_list(usr)
	if(!(locked && (extra_href && !extra_href["remote_connection"])) || (extra_href && extra_href["remote_access"]) || issilicon(usr))
		if(href_list["command"])
			var/device_id = href_list["id_tag"]
			switch(href_list["command"])
				if("set_external_pressure")
					playsound(loc, 'sound/machines/machine_switch.ogg', 100, 1)
					var/input_pressure = input("What pressure you like the system to mantain?", "Pressure Controls") as num|null
					if(isnum(input_pressure))
						send_signal(device_id, list(href_list["command"] = input_pressure))
					return 1

				if("reset_external_pressure")
					playsound(loc, 'sound/machines/machine_switch.ogg', 100, 1)
					send_signal(device_id, list(href_list["command"] = ONE_ATMOSPHERE))
					return 1

				if( "power",
					"adjust_external_pressure",
					"checks",
					"expanded_range",
					"toggle_expanded_range",
					"o2_scrub",
					"n2_scrub",
					"co2_scrub",
					"tox_scrub",
					"n2o_scrub",
					"panic_siphon",
					"scrubbing")
					playsound(loc, 'sound/machines/machine_switch.ogg', 100, 1)
					send_signal(device_id, list(href_list["command"] = text2num(href_list["val"]) ) )
					investigate_log("had it's settings changed by [key_name(usr)]", "atmos")
					return 1

				if("set_threshold")
					playsound(loc, 'sound/machines/machine_switch.ogg', 100, 1)
					var/env = href_list["env"]
					var/threshold = text2num(href_list["var"])
					var/list/selected = TLV[env]
					var/list/thresholds = list("lower bound", "low warning", "high warning", "upper bound")
					var/newval = input("Enter [thresholds[threshold]] for [env]", "Alarm triggers", selected[threshold]) as null|num
					if(isnull(newval))
						return 1
					if(newval<0)
						selected[threshold] = -1
					else if(env=="temperature" && newval>5000)
						selected[threshold] = 5000
					else if(env=="pressure" && newval>50*ONE_ATMOSPHERE)
						selected[threshold] = 50*ONE_ATMOSPHERE
					else if(env!="temperature" && env!="pressure" && newval>200)
						selected[threshold] = 200
					else
						newval = round(newval,0.01)
						selected[threshold] = newval
					if(threshold == 1)
						if(selected[1] > selected[2])
							selected[2] = selected[1]
						if(selected[1] > selected[3])
							selected[3] = selected[1]
						if(selected[1] > selected[4])
							selected[4] = selected[1]
					if(threshold == 2)
						if(selected[1] > selected[2])
							selected[1] = selected[2]
						if(selected[2] > selected[3])
							selected[3] = selected[2]
						if(selected[2] > selected[4])
							selected[4] = selected[2]
					if(threshold == 3)
						if(selected[1] > selected[3])
							selected[1] = selected[3]
						if(selected[2] > selected[3])
							selected[2] = selected[3]
						if(selected[3] > selected[4])
							selected[4] = selected[3]
					if(threshold == 4)
						if(selected[1] > selected[4])
							selected[1] = selected[4]
						if(selected[2] > selected[4])
							selected[2] = selected[4]
						if(selected[3] > selected[4])
							selected[3] = selected[4]

					investigate_log("had it's tresholds changed by [key_name(usr)]", "atmos")
					apply_mode()
					return 1

		if(href_list["screen"])
			playsound(loc, 'sound/machines/machine_switch.ogg', 100, 1)
			screen = text2num(href_list["screen"])
			return 1

		if(href_list["atmos_unlock"])
			playsound(loc, 'sound/machines/machine_switch.ogg', 100, 1)
			switch(href_list["atmos_unlock"])
				if("0")
					alarm_area.air_doors_close()
				if("1")
					alarm_area.air_doors_open()
			return 1

		if(href_list["atmos_alarm"])
			playsound(loc, 'sound/machines/machine_switch.ogg', 100, 1)
			if(alarm_area.atmosalert(2, src))
				apply_danger_level(2)
			update_icon()
			return 1

		if(href_list["atmos_reset"])
			playsound(loc, 'sound/machines/machine_switch.ogg', 100, 1)
			forceClearAlarm()
			investigate_log("had it's alarms cleared by [key_name(usr)]", "atmos")
			return 1

		if(href_list["mode"])
			playsound(loc, 'sound/machines/machine_switch.ogg', 100, 1)
			apply_mode(text2num(href_list["mode"]))
			return 1

/obj/machinery/alarm/attackby(obj/item/I, mob/user)
	add_fingerprint(user)

	var/list/usable_qualities = list()
	if(buildstage == 2)
		usable_qualities.Add(QUALITY_SCREW_DRIVING)
	if(wiresexposed)
		usable_qualities.Add(QUALITY_WIRE_CUTTING)
	if(buildstage == 1)
		usable_qualities.Add(QUALITY_PRYING)
	if(buildstage == 0)
		usable_qualities.Add(QUALITY_BOLT_TURNING)


	var/tool_type = I.get_tool_type(user, usable_qualities, src)
	switch(tool_type)

		if(QUALITY_SCREW_DRIVING)
			if(buildstage == 2)
				var/used_sound = panel_open ? 'sound/machines/Custom_screwdriveropen.ogg' :  'sound/machines/Custom_screwdriverclose.ogg'
				if(I.use_tool(user, src, WORKTIME_NEAR_INSTANT, tool_type, FAILCHANCE_VERY_EASY, instant_finish_tier = 30, forced_sound = used_sound))
					wiresexposed = !wiresexposed
					to_chat(user, "The wires have been [wiresexposed ? "exposed" : "unexposed"]")
					update_icon()
					return
			return

		if(QUALITY_WIRE_CUTTING)
			if(wiresexposed && buildstage == 2)
				if(I.use_tool(user, src, WORKTIME_NEAR_INSTANT, tool_type, FAILCHANCE_VERY_EASY, required_stat = STAT_MEC))
					user.visible_message(SPAN_WARNING("[user] removed the wires from \the [src]!"), "You have removed the wires from \the [src].")
					new/obj/item/stack/cable_coil(get_turf(user), 5)
					buildstage = 1
					update_icon()
					return
			return

		if(QUALITY_PRYING)
			if(buildstage == 1)
				if(I.use_tool(user, src, WORKTIME_NORMAL, tool_type, FAILCHANCE_VERY_EASY, required_stat = STAT_MEC))
					to_chat(user, "You pry out the circuit!")
					var/obj/item/electronics/airalarm/circuit = new /obj/item/electronics/airalarm()
					circuit.loc = user.loc
					buildstage = 0
					update_icon()
					return
			return

		if(QUALITY_BOLT_TURNING)
			if(buildstage == 0)
				if(I.use_tool(user, src, WORKTIME_NEAR_INSTANT, tool_type, FAILCHANCE_VERY_EASY, required_stat = STAT_MEC))
					to_chat(user, "You remove the fire alarm assembly from the wall!")
					new /obj/item/frame/air_alarm(get_turf(user))
					qdel(src)
			return

		if(ABORT_CHECK)
			return

	switch(buildstage)
		if(2)
			if(istype(I, /obj/item/card/id) || istype(I, /obj/item/modular_computer))// trying to unlock the interface with an ID card
				toggle_lock(user)
			return

		if(1)
			if(istype(I, /obj/item/stack/cable_coil))
				var/obj/item/stack/cable_coil/C = I
				if(C.use(5))
					to_chat(user, SPAN_NOTICE("You wire \the [src]."))
					buildstage = 2
					update_icon()
					first_run()
					return
				else
					to_chat(user, SPAN_WARNING("You need 5 pieces of cable to do wire \the [src]."))
					return

		if(0)
			if(istype(I, /obj/item/electronics/airalarm))
				to_chat(user, "You insert the circuit!")
				qdel(I)
				buildstage = 1
				update_icon()
				return

	return ..()

/obj/machinery/alarm/power_change()
	..()
	spawn(rand(0,15))
		update_icon()

/obj/machinery/alarm/examine(mob/user, extra_description = "")
	if(buildstage < 2)
		extra_description += "It is not wired."
	if(buildstage < 1)
		extra_description += "The circuit is missing."
	..(user, extra_description)

/obj/machinery/alarm/proc/toggle_lock(mob/user)
	if(stat & (NOPOWER|BROKEN))
		to_chat(user, "It does nothing")
		return
	else
		if(allowed(user) && !wires.IsIndexCut(AALARM_WIRE_IDSCAN))
			locked = !locked
			to_chat(user, SPAN_NOTICE("You [ locked ? "lock" : "unlock"] the Air Alarm interface."))
		else
			to_chat(user, SPAN_WARNING("Access denied."))

/obj/machinery/alarm/AltClick(mob/user)
	..()
	if(issilicon(user) || !Adjacent(user))
		return
	toggle_lock(user)


/*
AIR ALARM CIRCUIT
Just a object used in constructing air alarms
*/
/obj/item/electronics/airalarm
	name = "air alarm electronics"
	icon = 'icons/obj/doors/door_assembly.dmi'
	icon_state = "door_electronics"
	desc = "Looks like a circuit. Probably is."
	w_class = ITEM_SIZE_SMALL
	matter = list(MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 3)

/*
FIRE ALARM
*/
/obj/machinery/firealarm
	name = "fire alarm"
	desc = "<i>\"Pull this in case of emergency\"</i>. Thus, keep pulling it forever."
	icon = 'icons/obj/monitors.dmi'
	icon_state = "fire0"
	var/detecting = 1
	var/working = 1
	var/time = 10
	var/timing = 0
	anchored = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 6
	power_channel = STATIC_ENVIRON
	var/last_process = 0
	var/wiresexposed = 0
	var/buildstage = 2 // 2 = complete, 1 = no wires,  0 = circuit gone

/obj/machinery/firealarm/update_icon()
	overlays.Cut()

	if(wiresexposed)
		switch(buildstage)
			if(2)
				icon_state="fire_build2"
			if(1)
				icon_state="fire_build1"
			if(0)
				icon_state="fire_build0"
		set_light(0)
		return

	if(stat & BROKEN)
		icon_state = "fire_broken"
		set_light(0)
	else if(stat & NOPOWER)
		icon_state = "fire_unpowered"
		set_light(0)
	else
		var/area/area = get_area(src)
		if(area.fire)
			icon_state = "fire1"
			set_light(l_range = 1.5, l_power = 0.5, l_color = COLOR_LIGHTING_RED_MACHINERY)
		else
			icon_state = "fire0"
			var/decl/security_state/security_state = decls_repository.get_decl(SSmapping.security_state)
			var/decl/security_level/sl = security_state.current_security_level

			set_light(sl.light_max_bright, sl.light_inner_range, sl.light_outer_range, 2, sl.light_color_alarm)
			src.overlays += image('icons/obj/monitors.dmi', sl.overlay_firealarm)

/obj/machinery/firealarm/fire_act(datum/gas_mixture/air, temperature, volume)
	if(detecting)
		if(temperature > T0C + 200)
			alarm()			// added check of detector status here

/obj/machinery/firealarm/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	return nano_ui_interact(user)

/obj/machinery/firealarm/bullet_act()
	return alarm()

/obj/machinery/firealarm/emp_act(severity)
	if(prob(50/severity))
		alarm(rand(30/severity, 60/severity))
	..()

/obj/machinery/firealarm/attackby(obj/item/I, mob/user)
	add_fingerprint(user)
	var/list/usable_qualities = list()
	if(buildstage == 2)
		usable_qualities.Add(QUALITY_SCREW_DRIVING)
	if(wiresexposed)
		usable_qualities.Add(QUALITY_WIRE_CUTTING, QUALITY_PULSING)
	if(buildstage == 1)
		usable_qualities.Add(QUALITY_PRYING)
	if(buildstage == 0)
		usable_qualities.Add(QUALITY_BOLT_TURNING)

	var/tool_type = I.get_tool_type(user, usable_qualities, src)
	switch(tool_type)
		if(QUALITY_SCREW_DRIVING)
			if(buildstage == 2)
				var/used_sound = panel_open ? 'sound/machines/Custom_screwdriveropen.ogg' :  'sound/machines/Custom_screwdriverclose.ogg'
				if(I.use_tool(user, src, WORKTIME_NEAR_INSTANT, tool_type, FAILCHANCE_VERY_EASY, instant_finish_tier = 30, forced_sound = used_sound))
					wiresexposed = !wiresexposed
					to_chat(user, "The wires have been [wiresexposed ? "exposed" : "unexposed"]")
					update_icon()
					return
			return

		if(QUALITY_WIRE_CUTTING)
			if(wiresexposed && buildstage == 2)
				if(I.use_tool(user, src, WORKTIME_NEAR_INSTANT, tool_type, FAILCHANCE_VERY_EASY, required_stat = STAT_MEC))
					user.visible_message(SPAN_WARNING("[user] has removed the wires from \the [src]!"), "You have removed the wires from \the [src].")
					new/obj/item/stack/cable_coil(get_turf(user), 5)
					buildstage = 1
					update_icon()
					return
			return

		if(QUALITY_PULSING)
			if(wiresexposed)
				if(I.use_tool(user, src, WORKTIME_NEAR_INSTANT, tool_type, FAILCHANCE_VERY_EASY, required_stat = STAT_MEC))
					detecting = !detecting
					user.visible_message(
					SPAN_NOTICE("\The [user] has [detecting ? "disconnected" : "reconnected"] [src]'s detecting unit!"),
					SPAN_NOTICE("You have [detecting ? "disconnected" : "reconnected"] [src]'s detecting unit."))
					return
			return

		if(QUALITY_PRYING)
			if(buildstage == 1)
				if(I.use_tool(user, src, WORKTIME_NORMAL, tool_type, FAILCHANCE_VERY_EASY, required_stat = STAT_MEC))
					to_chat(user, "You pry out the circuit!")
					var/obj/item/electronics/airalarm/circuit = new /obj/item/electronics/airalarm()
					circuit.loc = user.loc
					buildstage = 0
					update_icon()
					return
			return

		if(QUALITY_BOLT_TURNING)
			if(buildstage == 0)
				if(I.use_tool(user, src, WORKTIME_NEAR_INSTANT, tool_type, FAILCHANCE_VERY_EASY, , required_stat = STAT_MEC))
					to_chat(user, "You remove the fire alarm assembly from the wall!")
					new /obj/item/frame/fire_alarm(get_turf(user))
					qdel(src)
			return

		if(ABORT_CHECK)
			return

	switch(buildstage)
		if(1)
			if(istype(I, /obj/item/stack/cable_coil))
				var/obj/item/stack/cable_coil/C = I
				if(C.use(5))
					to_chat(user, SPAN_NOTICE("You wire \the [src]."))
					buildstage = 2
					update_icon()
					return
				else
					to_chat(user, SPAN_WARNING("You need 5 pieces of cable to do wire \the [src]."))
					return

		if(0)
			if(istype(I, /obj/item/electronics/firealarm))
				to_chat(user, "You insert the circuit!")
				qdel(I)
				buildstage = 1
				update_icon()
				return

	alarm()

/obj/machinery/firealarm/Process()//Note: this processing was mostly phased out due to other code, and only runs when needed
	if(stat & (NOPOWER|BROKEN))
		return

	if(timing)
		if(time > 0)
			time -= (world.timeofday - last_process)/10
		else
			alarm()
			time = 0
			timing = 0
			STOP_PROCESSING(SSmachines, src)
		updateDialog()
	last_process = world.timeofday

	if(locate(/obj/fire) in loc)
		alarm()

/obj/machinery/firealarm/power_change()
	..()
	spawn(rand(0,15))
		update_icon()

/obj/machinery/firealarm/nano_ui_interact(mob/user, ui_key = "main", datum/nanoui/ui, force_open = NANOUI_FOCUS, datum/nano_topic_state/state = GLOB.outside_state)
	var/data[0]
	var/decl/security_state/security_state = decls_repository.get_decl(SSmapping.security_state)

	data["seclevel"] = security_state.current_security_level.name
	data["time"] = round(src.time)
	data["timing"] = timing
	var/area/A = get_area(src)
	data["active"] = A.fire

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "fire_alarm.tmpl", "Fire Alarm", 240, 330, state = state)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/firealarm/CanUseTopic(user)
	if(wiresexposed)
		return STATUS_CLOSE

	if(buildstage != 2)
		return STATUS_CLOSE
	return ..()

/obj/machinery/firealarm/Topic(href, href_list)
	if(..())
		return 1

	playsound(loc, 'sound/machines/machine_switch.ogg', 100, 1)
	if(href_list["status"] == "reset")
		src.reset()
		return TOPIC_REFRESH
	else if(href_list["status"] == "alarm")
		src.alarm()
		return TOPIC_REFRESH
	if(href_list["timer"] == "set")
		time = max(0, input(usr, "Enter time delay", "Fire Alarm Timer", time) as num)
	else if(href_list["timer"] == "start")
		src.timing = 1
		return TOPIC_REFRESH
	else if(href_list["timer"] == "stop")
		src.timing = 0
		return TOPIC_REFRESH

/obj/machinery/firealarm/proc/reset()
	if(!( src.working ))
		return
	var/area/area = get_area(src)
	for(var/obj/machinery/firealarm/FA in area)
		fire_alarm.clearAlarm(loc, FA)
	if(iscarbon(usr))
		visible_message("[usr] resets \the [src].", "You have reset \the [src].")
	else
		to_chat(usr, "Fire Alarm is reset.")
	update_icon()

/obj/machinery/firealarm/proc/alarm(duration = 0)
	if(!( src.working))
		return
	var/area/area = get_area(src)
	for(var/obj/machinery/firealarm/FA in area)
		fire_alarm.triggerAlarm(loc, FA, duration)
	if(iscarbon(usr))
		visible_message(SPAN_WARNING("[usr] pulled \the [src]'s pull station!"), SPAN_WARNING("You have pulled \the [src]'s pull station!"))
	else
		to_chat(usr, "Fire Alarm activated.")
	update_icon()


/obj/machinery/firealarm/New(loc, dir, building)
	..()
	if(loc)
		src.loc = loc

	if(dir)
		src.set_dir(dir)

	if(building)
		buildstage = 0
		wiresexposed = 1
		pixel_x = (dir & 3)? 0 : (dir == 4 ? -24 : 24)
		pixel_y = (dir & 3)? (dir ==1 ? -24 : 24) : 0

	GLOB.firealarm_list += src

/obj/machinery/firealarm/Destroy()
	GLOB.firealarm_list -= src
	..()

/*
FIRE ALARM CIRCUIT
Just a object used in constructing fire alarms
*/
/obj/item/electronics/firealarm
	name = "fire alarm electronics"
	icon = 'icons/obj/doors/door_assembly.dmi'
	icon_state = "door_electronics"
	desc = "A circuit. It has a label on it, it says \"Can handle heat levels up to 40 degrees celsius!\""
	w_class = ITEM_SIZE_SMALL
	matter = list(MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 3)

/obj/machinery/partyalarm
	name = "\improper PARTY BUTTON"
	desc = "Cuban Pete is in the house!"
	icon = 'icons/obj/monitors.dmi'
	icon_state = "fire0"
	var/detecting = 1
	var/working = 1
	var/time = 10
	var/timing = 0
	anchored = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 6

/obj/machinery/partyalarm/attack_hand(mob/user)
	if(user.stat || stat & (NOPOWER|BROKEN))
		return

	user.machine = src
	var/area/A = get_area(src)
	ASSERT(isarea(A))
	var/d1
	var/d2
	if(ishuman(user) || istype(user, /mob/living/silicon/ai))

		if(A.party)
			d1 = text("<a href='byond://?src=\ref[];reset=1'>No Party :(</A>", src)
		else
			d1 = text("<a href='byond://?src=\ref[];alarm=1'>PARTY!!!</A>", src)
		if(timing)
			d2 = text("<a href='byond://?src=\ref[];time=0'>Stop Time Lock</A>", src)
		else
			d2 = text("<a href='byond://?src=\ref[];time=1'>Initiate Time Lock</A>", src)
		var/second = time % 60
		var/minute = (time - second) / 60
		var/dat = text("<HTML><HEAD></HEAD><BODY><TT><B>Party Button</B> []\n<HR>\nTimer System: []<BR>\nTime Left: [][] <A href='?src=\ref[];tp=-30'>-</A> <A href='?src=\ref[];tp=-1'>-</A> <A href='?src=\ref[];tp=1'>+</A> <A href='?src=\ref[];tp=30'>+</A>\n</TT></BODY></HTML>", d1, d2, (minute ? text("[]:", minute) : null), second, src, src, src, src)
		user << browse(dat, "window=partyalarm")
		onclose(user, "partyalarm")
	else
		if(A.fire)
			d1 = text("<a href='byond://?src=\ref[];reset=1'>[]</A>", src, stars("No Party :("))
		else
			d1 = text("<a href='byond://?src=\ref[];alarm=1'>[]</A>", src, stars("PARTY!!!"))
		if(timing)
			d2 = text("<a href='byond://?src=\ref[];time=0'>[]</A>", src, stars("Stop Time Lock"))
		else
			d2 = text("<a href='byond://?src=\ref[];time=1'>[]</A>", src, stars("Initiate Time Lock"))
		var/second = time % 60
		var/minute = (time - second) / 60
		var/time_string = "[second]"
		if(minute)
			time_string = "[minute]:[second]"
		var/dat = {"
			<HTML><BODY><TT>
			<B>[stars("Party Button")]</B> [d1]<HR>
			Timer System: [d2]<BR>
			Time Left: [time_string]
			<a href='byond://?src=\ref[src];tp=-30'>-</A> <a href='byond://?src=\ref[src];tp=-1'>-</A>
			<a href='byond://?src=\ref[src];tp=1'>+</A> <a href='byond://?src=\ref[src];tp=30'>+</A>
			</TT></BODY></HTML>
		"}
		user << browse(dat, "window=partyalarm")
		onclose(user, "partyalarm")
	return

/obj/machinery/partyalarm/proc/reset()
	if(!working)
		return
	var/area/A = get_area(src)
	ASSERT(isarea(A))
	A.partyreset()

/obj/machinery/partyalarm/proc/alarm()
	if(!working)
		return
	var/area/A = get_area(src)
	ASSERT(isarea(A))
	A.partyalert()

/obj/machinery/partyalarm/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["reset"])
		reset()
	else if(href_list["alarm"])
		alarm()
	else if(href_list["time"])
		timing = text2num(href_list["time"])
	else if(href_list["tp"])
		var/tp = text2num(href_list["tp"])
		time += tp
		time = min(max(round(time), 0), 120)
