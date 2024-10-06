/obj/machinery/multistructure/nuclear_reactor_part/control_rod
	name = "control rod section"
	desc = "A section designed to hold and use control rods to moderate nuclear reactions."
	//icon_state = "control_spot"
	var/height = 0
	var/max_height = 100
	var/min_height = 0
	var/current_step = STEP_INTACT
	var/obj/item/control_rod/control

/obj/machinery/multistructure/nuclear_reactor_part/control_rod/Initialize(mapload, ...)
	..()
	if(mapload)
		control = new()
	update_icon()

/obj/machinery/multistructure/nuclear_reactor_part/control_rod/attackby(obj/item/I, mob/user)
	switch(current_step)
		if(STEP_INTACT)
			if(I.get_tool_type(user, list(QUALITY_BOLT_TURNING), src) == QUALITY_BOLT_TURNING)
				if(I.use_tool(user, src, WORKTIME_NORMAL, QUALITY_BOLT_TURNING, FAILCHANCE_EASY, required_stat = STAT_MEC))
					user.visible_message(SPAN_NOTICE("[user] loosen the bolts."), SPAN_NOTICE("You loosen the bolts."))
					current_step = STEP_UNWRENCHED
					return

		if(STEP_UNWRENCHED)
			if(I.get_tool_type(user, list(QUALITY_BOLT_TURNING), src) == QUALITY_BOLT_TURNING)
				if(I.use_tool(user, src, WORKTIME_NORMAL, QUALITY_BOLT_TURNING, FAILCHANCE_EASY, required_stat = STAT_MEC))
					user.visible_message(SPAN_NOTICE("[user] tighten the bolts."), SPAN_NOTICE("You tighten the bolts."))
					current_step = STEP_INTACT
					return

		if(STEP_PULLED)
			if(I.get_tool_type(user, list(QUALITY_SCREW_DRIVING), src) == QUALITY_SCREW_DRIVING)
				if(I.use_tool(user, src, WORKTIME_NORMAL, QUALITY_SCREW_DRIVING, FAILCHANCE_EASY, required_stat = STAT_MEC))
					user.visible_message(SPAN_NOTICE("[user] unsecures the control rod."), SPAN_NOTICE("You unsecures the control rod."))
					current_step = STEP_UNSECURED
					return

		if(STEP_UNSECURED)
			var/tool_type = I.get_tool_type(user, list(QUALITY_SCREW_DRIVING, QUALITY_PRYING), src)
			if(!tool_type)
				return

			if(tool_type == QUALITY_PRYING)
				if(I.use_tool(user, src, WORKTIME_NORMAL, QUALITY_PRYING, FAILCHANCE_EASY, required_stat = STAT_MEC))
					user.visible_message(SPAN_NOTICE("[user] pries the control rod out."), SPAN_NOTICE("You pry the control rod out."))
					control.loc = loc
					control = null
					current_step = STEP_NO_ROD
					return

			if(tool_type == QUALITY_SCREW_DRIVING)
				if(I.use_tool(user, src, WORKTIME_NORMAL, QUALITY_SCREW_DRIVING, FAILCHANCE_EASY, required_stat = STAT_MEC))
					user.visible_message(SPAN_NOTICE("[user] secures the control rod."), SPAN_NOTICE("You secures the control rod."))
					current_step = STEP_PULLED
					return

		if(STEP_NO_ROD)
			if(istype(I, /obj/item/control_rod) && insert_item(I, user))
				control = I
				current_step = STEP_UNSECURED
				return
	..()

/obj/machinery/multistructure/nuclear_reactor_part/control_rod/attack_hand(mob/user as mob)
	if(current_step == STEP_UNWRENCHED)
		user.visible_message(SPAN_NOTICE("[user] pulls the rod container up."), SPAN_NOTICE("You pulls the rod container up."))
		current_step = STEP_PULLED
		update_icon()
		return

	if(current_step == STEP_PULLED)
		user.visible_message(SPAN_NOTICE("[user] push the rod container down."), SPAN_NOTICE("You push the rod container down."))
		current_step = STEP_UNWRENCHED
		update_icon()
		return

	..()

/obj/machinery/multistructure/nuclear_reactor_part/control_rod/examine(mob/user)
	..()
	var/message

	switch(current_step)
		if(STEP_INTACT)
			message = "The bolts are tightly secured."

		if(STEP_UNWRENCHED)
			message = "The bolts are loose and the assembly is ready to be pulled up."

		if(STEP_PULLED)
			message = "The assembly is pulled up, but the control rod is secured by screws."

		if(STEP_UNSECURED)
			message = "The screws keeping the control rod in place are loose. Someone could just pry away the control rod!"

		if(STEP_NO_ROD)
			message = "There is no control rod!"

	if(message)
		to_chat(user, SPAN_NOTICE("[message]"))

// TODO for when proper sprites are done.
/obj/machinery/multistructure/nuclear_reactor_part/control_rod/update_icon()
	cut_overlays()
	switch(Get_Rod_Height())
		if(0 to 24)
			add_overlay("C0")
		if(25 to 49)
			add_overlay("C25")
		if(50 to 74)
			add_overlay("C50")
		if(75 to 99)
			add_overlay("C75")
		if(100)
			add_overlay("C100")

/obj/machinery/multistructure/nuclear_reactor_part/control_rod/proc/Get_Rod_Height()
	if(!control) // No control rod? Well it's not there.
		return max_height
	if(current_step >= STEP_PULLED) // The rod was pulled up? Might as well not be there.
		return max_height
	if(stat & (BROKEN)) // It's broken? The rod automatically falls down.
		return min_height
	return height
