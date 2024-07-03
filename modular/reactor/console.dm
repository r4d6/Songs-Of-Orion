/obj/machinery/multistructure/nuclear_reactor_part/console
	icon_state = "console"
	density = TRUE
	var/datum/multistructure/nuclear_reactor/Reactor

/obj/machinery/multistructure/nuclear_reactor_part/console/New()
	..()
	update_icon()

/obj/machinery/multistructure/nuclear_reactor_part/console/update_icon()
	add_overlay("power_key")
	add_overlay("smmon_2")

/obj/machinery/multistructure/nuclear_reactor_part/console/attack_hand(mob/user as mob)
	interact(user)

/obj/machinery/multistructure/nuclear_reactor_part/console/interact(mob/user as mob)
	var/dat = Reactor?.Get_HTML()
	if(dat)
		if((get_dist(src, user) > 1) || (stat & (BROKEN)))
			if(!isAI(user))
				user.unset_machine()
				user << browse(null, "window=NRcontrol")
				return
		user.set_machine(src)

		user << browse(dat, "window=NRcontrol;size=420x500")
		onclose(user, "AMcontrol")
		return

/obj/machinery/multistructure/nuclear_reactor_part/console/Topic(href, href_list)
	..()
	//Ignore input if we are broken or guy is not touching us, AI can control from a ways away
	if(stat & (BROKEN) || (get_dist(src, usr) > 1 && !isAI(usr)))
		usr.unset_machine()
		usr << browse(null, "window=NRcontrol")
		return

	if(href_list["close"])
		usr << browse(null, "window=NRcontrol")
		usr.unset_machine()
		return

	Reactor.Topic(href, href_list)

	updateDialog()
	return
