//Shuttle controller computer for shuttles going between sectors
/obj/machinery/computer/shuttle_control/explore
	name = "general shuttle control console"

/obj/machinery/computer/shuttle_control/explore/nano_ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = NANOUI_FOCUS)
	var/data[0]
	var/datum/shuttle/autodock/overmap/shuttle = SSshuttle.shuttles[shuttle_tag]
	if(!istype(shuttle))
		to_chat(usr, "<span class='warning'>Unable to establish link with the shuttle.</span>")
		return

	var/shuttle_state
	switch(shuttle.moving_status)
		if(SHUTTLE_IDLE) shuttle_state = "idle"
		if(SHUTTLE_WARMUP) shuttle_state = "warmup"
		if(SHUTTLE_INTRANSIT) shuttle_state = "in_transit"

	var/shuttle_status
	switch (shuttle.process_state)
		if(IDLE_STATE)
			if(shuttle.in_use)
				shuttle_status = "Busy."
			else
				shuttle_status = "Standing-by at [shuttle.get_location_name()]."
		if(WAIT_LAUNCH, FORCE_LAUNCH)
			shuttle_status = "Shuttle has received command and will depart shortly."
		if(WAIT_ARRIVE)
			shuttle_status = "Proceeding to [shuttle.get_destination_name()]."
		if(WAIT_FINISH)
			shuttle_status = "Arriving at destination now."

	var/datum/computer/file/embedded_program/docking/docking_controller = shuttle.active_docking_controller

	var/fuel_pressure = 0
	var/fuel_max_pressure = 0
	if(shuttle.fuel_ports)
		if(shuttle.fuel_ports.len)
			for(var/obj/structure/fuel_port/FP in shuttle.fuel_ports) //loop through fuel ports
				if(FP.contents.len)
					var/obj/item/tank/fuel_tank = FP.contents[1]
					if(istype(fuel_tank))
						fuel_pressure += fuel_tank.air_contents.return_pressure()
						fuel_max_pressure += 1013

	if(fuel_max_pressure == 0) fuel_max_pressure = 1

	data = list(
		"destination_name" = shuttle.get_destination_name(),
		"can_pick" = shuttle.moving_status == SHUTTLE_IDLE,
		"shuttle_status" = shuttle_status,
		"shuttle_state" = shuttle_state,
		"has_docking" = docking_controller? 1 : 0,
		"docking_status" = docking_controller? docking_controller.get_docking_status() : null,
		"docking_override" = docking_controller? docking_controller.override_enabled : null,
		"can_launch" = shuttle.can_launch(),
		"can_cancel" = shuttle.can_cancel(),
		"can_force" = shuttle.can_force(),
		"fuel_port_present" = shuttle.fuel_consumption? 1 : 0,
		"fuel_pressure" = fuel_pressure,
		"fuel_max_pressure" = fuel_max_pressure,
		"fuel_pressure_status" = (fuel_pressure/fuel_max_pressure > 0.2)? "good" : "bad"
	)

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)

	if(!ui)
		ui = new(user, src, ui_key, "shuttle_control_console_exploration.tmpl", "[shuttle_tag] Shuttle Control", 510, 340)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/computer/shuttle_control/explore/get_ui_data(var/datum/shuttle/autodock/overmap/shuttle)
	. = ..()
	if(istype(shuttle))
		. += list(
			"destination_name" = shuttle.get_destination_name(),
			"can_pick" = shuttle.moving_status == SHUTTLE_IDLE,
		)
