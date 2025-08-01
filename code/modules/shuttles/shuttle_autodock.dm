#define DOCK_ATTEMPT_TIMEOUT 200	//how long in ticks we wait before assuming the docking controller is broken or blown up.

/datum/shuttle/autodock
	var/process_state = IDLE_STATE
	var/in_use = null	//tells the controller whether this shuttle needs processing, also attempts to prevent double-use
	var/last_dock_attempt_time = 0
	var/current_dock_target
	//ID of the controller on the shuttle
	var/dock_target = null

	var/obj/effect/shuttle_landmark/next_location

	//For single airlock ships, this is the controller for that airlock. Otherwise it's only one of them if relevant
	var/default_docking_controller

	var/datum/computer/file/embedded_program/docking/active_docking_controller

	var/obj/effect/shuttle_landmark/landmark_transition
	var/move_time = 360		//the time spent in the transition area

	var/list/destinations_cache = list()
	var/last_cache_rebuild_time = 0

	// If this shuttle is allowed to visit discovered overmap locations
	var/can_do_exploration = FALSE

	category = /datum/shuttle/autodock

/datum/shuttle/autodock/New(var/_name, var/obj/effect/shuttle_landmark/start_waypoint)
	..(_name, start_waypoint)

	//Initial dock
	if(default_docking_controller)
		active_docking_controller = locate(default_docking_controller)

	if(current_location && current_location.docking_controller)
		active_docking_controller = current_location.docking_controller
	current_dock_target = get_docking_target(current_location)

	if(active_docking_controller)
		dock()

	//Optional transition area
	if(landmark_transition)
		var/transition_tag = landmark_transition
		landmark_transition = locate(transition_tag)
		if(!istype(landmark_transition)) // Failed to locate the transition area
			landmark_transition = transition_tag

/datum/shuttle/autodock/Destroy()
	next_location = null
	active_docking_controller = null
	landmark_transition = null

	return ..()

/datum/shuttle/autodock/shuttle_moved()
	force_undock() //bye!
	..()

/datum/shuttle/autodock/proc/get_docking_target(obj/effect/shuttle_landmark/location)
	if(location.dock_target)
		return location.dock_target

/*
	Docking stuff
*/
/datum/shuttle/autodock/proc/dock()
	if(active_docking_controller)
		active_docking_controller.initiate_docking(current_dock_target)
		last_dock_attempt_time = world.time
		build_destinations_cache()

/datum/shuttle/autodock/proc/undock()
	if(active_docking_controller)
		active_docking_controller.initiate_undocking()

/datum/shuttle/autodock/proc/force_undock()
	if(active_docking_controller)
		active_docking_controller.force_undock()

/datum/shuttle/autodock/proc/check_docked()
	if(active_docking_controller)
		return active_docking_controller.docked()
	return TRUE

/datum/shuttle/autodock/proc/check_undocked()
	if(active_docking_controller)
		return active_docking_controller.can_launch()
	return TRUE

/*
	Please ensure that long_jump() and short_jump() are only called from here. This applies to subtypes as well.
	Doing so will ensure that multiple jumps cannot be initiated in parallel.
*/
/datum/shuttle/autodock/Process()
	switch(process_state)
		if(WAIT_LAUNCH)
			if(check_undocked())
				//*** ready to go
				process_launch()

		if(FORCE_LAUNCH)
			process_launch()

		if(WAIT_ARRIVE)
			if(moving_status == SHUTTLE_IDLE)
				//*** we made it to the destination, update stuff
				process_arrived()
				process_state = WAIT_FINISH

		if(WAIT_FINISH)
			if(world.time > last_dock_attempt_time + DOCK_ATTEMPT_TIMEOUT || check_docked())
				//*** all done here
				process_state = IDLE_STATE
				arrived()

//not to be confused with the arrived() proc
/datum/shuttle/autodock/proc/process_arrived()
	if(next_location.docking_controller)
		active_docking_controller = next_location.docking_controller
	current_dock_target = get_docking_target(next_location)
	dock()

	next_location = null
	in_use = null	//release lock


/datum/shuttle/autodock/proc/process_launch()
	if(!next_location.is_valid(src))
		process_state = IDLE_STATE
		in_use = null
		return

	// Transit location wasn't found on initialization, try again
	if(istext(landmark_transition))
		var/transition_tag = landmark_transition
		landmark_transition = locate(transition_tag)
		if(!istype(landmark_transition))
			landmark_transition = transition_tag

	if(move_time && landmark_transition && istype(landmark_transition))
		. = long_jump(next_location, landmark_transition, move_time)
	else
		. = short_jump(next_location)
	process_state = WAIT_ARRIVE

/*
	Guards
*/
/datum/shuttle/autodock/proc/can_launch()
	return (next_location && moving_status == SHUTTLE_IDLE && !in_use)

/datum/shuttle/autodock/proc/can_force()
	return (next_location && moving_status == SHUTTLE_IDLE && process_state == WAIT_LAUNCH)

/datum/shuttle/autodock/proc/can_cancel()
	return (moving_status == SHUTTLE_WARMUP || process_state == WAIT_LAUNCH || process_state == FORCE_LAUNCH)

/*
	"Public" procs
*/
/datum/shuttle/autodock/proc/launch(var/user)
	if(!can_launch()) return

	in_use = user	//obtain an exclusive lock on the shuttle

	process_state = WAIT_LAUNCH
	undock()

/datum/shuttle/autodock/proc/force_launch(var/user)
	if(!can_force()) return

	in_use = user	//obtain an exclusive lock on the shuttle

	process_state = FORCE_LAUNCH

/datum/shuttle/autodock/proc/cancel_launch(var/user)
	if(!can_cancel()) return

	moving_status = SHUTTLE_IDLE
	process_state = WAIT_FINISH
	in_use = null

	//whatever we were doing with docking: stop it, then redock
	force_undock()
	spawn(1 SECONDS)
		dock()

//returns 1 if the shuttle is getting ready to move, but is not in transit yet
/datum/shuttle/autodock/proc/is_launching()
	return (moving_status == SHUTTLE_WARMUP || process_state == WAIT_LAUNCH || process_state == FORCE_LAUNCH)

//This gets called when the shuttle finishes arriving at it's destination
//This can be used by subtypes to do things when the shuttle arrives.
//Note that this is called when the shuttle leaves the WAIT_FINISHED state, the proc name is a little misleading
/datum/shuttle/autodock/proc/arrived()
	build_destinations_cache()


/datum/shuttle/autodock/proc/get_possible_destinations()
	if(last_cache_rebuild_time < SSshuttle.last_landmark_registration_time)
		build_destinations_cache()
	return destinations_cache


/datum/shuttle/autodock/proc/build_destinations_cache()
	last_cache_rebuild_time = world.time
	destinations_cache.Cut()

	for(var/obj/effect/shuttle_landmark/landmark in SSshuttle.registered_shuttle_landmarks)
		if(!landmark.is_valid_destination)
			continue // Shouldn't manually target this landmark under any circumstances
		if(landmark.shuttle_restricted && (landmark.shuttle_restricted != name))
			continue // It belongs to a different shuttle, can't use
		if(landmark.exploration_landmark && !can_do_exploration)
			continue // Not all shuttles are meant to do exploration content
		if(landmark == current_location)
			continue // We're already on this landmark

		destinations_cache["[landmark.name]"] = landmark


/datum/shuttle/autodock/proc/set_destination(destination_key, mob/user)
	if(moving_status == SHUTTLE_IDLE)
		next_location = destinations_cache[destination_key]
