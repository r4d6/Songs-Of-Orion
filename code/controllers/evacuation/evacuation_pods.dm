#define EVAC_OPT_ABANDON_SHIP "abandon_ship"
#define EVAC_OPT_CANCEL_ABANDON_SHIP "cancel_abandon_ship"

// Apparently, emergency_evacuation --> "abandon ship" and !emergency_evacuation --> "bluespace jump"
// That stuff should be moved to the evacuation option datums but someone can do that later

/datum/evacuation_controller/starship
	name = "escape pod controller"

	evac_prep_delay    = 5 MINUTES
	evac_launch_delay  = 3 MINUTES
	evac_transit_delay = 2 MINUTES

	transfer_prep_additional_delay     = 15 MINUTES
	autotransfer_prep_additional_delay = 5 MINUTES
	emergency_prep_additional_delay    = 0 MINUTES

	evacuation_options = list(
		EVAC_OPT_ABANDON_SHIP = new /datum/evacuation_option/abandon_ship(),
		EVAC_OPT_CANCEL_ABANDON_SHIP = new /datum/evacuation_option/cancel_abandon_ship()
	)

/datum/evacuation_controller/starship/finish_preparing_evac()
	. = ..()
	// Arm the escape pods.
	if (emergency_evacuation)
		for (var/datum/shuttle/autodock/ferry/escape_pod/pod in escape_pods)
			if (pod.arming_controller)
				pod.arming_controller.arm()

/datum/evacuation_controller/starship/launch_evacuation()

	state = EVAC_IN_TRANSIT

	if (emergency_evacuation)
		// Abondon Ship
		for (var/datum/shuttle/autodock/ferry/escape_pod/pod in escape_pods) // Launch the pods
			if (!pod.arming_controller || pod.arming_controller.armed)
				pod.move_time = (evac_transit_delay/10)
				pod.launch(src)

		priority_announcement.Announce(replacetext(replacetext(SSmapping.emergency_shuttle_leaving_dock, "%dock_name%", "[dock_name]"),  "%ETA%", "[round(get_eta()/60,1)] minute\s"))
	else
		priority_announcement.Announce(replacetext(replacetext(SSmapping.shuttle_leaving_dock, "%dock_name%", "[dock_name]"),  "%ETA%", "[round(get_eta()/60,1)] minute\s"))

/datum/evacuation_controller/starship/finish_evacuation()
	..()
	if(!emergency_evacuation) //bluespace jump
		SetUniversalState(/datum/universal_state) //clear jump state

/datum/evacuation_controller/starship/available_evac_options()
	if (is_on_cooldown())
		return list()
	if (is_idle())
		return list(evacuation_options[EVAC_OPT_ABANDON_SHIP])
	if (is_evacuating())
		if (emergency_evacuation)
			return list(evacuation_options[EVAC_OPT_CANCEL_ABANDON_SHIP])

/datum/evacuation_option/abandon_ship
	option_text = "Abandon spacecraft"
	option_desc = "abandon the spacecraft"
	option_target = EVAC_OPT_ABANDON_SHIP
	needs_syscontrol = FALSE
	silicon_allowed = TRUE

/datum/evacuation_option/abandon_ship/execute(mob/user)
	if (!evacuation_controller)
		return
	if (evacuation_controller.deny)
		to_chat(user, "Unable to initiate escape procedures.")
		return
	if (evacuation_controller.is_on_cooldown())
		to_chat(user, evacuation_controller.get_cooldown_message())
		return
	if (evacuation_controller.is_evacuating())
		to_chat(user, "Escape procedures already in progress.")
		return
	if (isdrone(user))
		to_chat(user, "ACCES DENIED. CPU Quota does not meet basic consideration requirements to call evacuation.")
		return
	if (evacuation_controller.call_evacuation(user, 1))
		log_and_message_admins("[user? key_name(user) : "Autotransfer"] has initiated abandonment of the spacecraft.")

/datum/evacuation_option/cancel_abandon_ship
	option_text = "Cancel abandonment"
	option_desc = "cancel abandonment of the spacecraft"
	option_target = EVAC_OPT_CANCEL_ABANDON_SHIP
	needs_syscontrol = FALSE
	silicon_allowed = FALSE

/datum/evacuation_option/cancel_abandon_ship/execute(mob/user)
	if (evacuation_controller && evacuation_controller.cancel_evacuation())
		log_and_message_admins("[key_name(user)] has cancelled abandonment of the spacecraft.")

/obj/screen/fullscreen/bluespace_overlay
	icon = 'icons/effects/effects.dmi'
	icon_state = "mfoam"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	color = "#ff9900"
	blend_mode = BLEND_SUBTRACT

#undef EVAC_OPT_ABANDON_SHIP
#undef EVAC_OPT_CANCEL_ABANDON_SHIP
