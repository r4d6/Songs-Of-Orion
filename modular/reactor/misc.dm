/obj/machinery/multistructure/nuclear_reactor_part
	icon = './placeholders.dmi'
	MS_type = /datum/multistructure/nuclear_reactor

/obj/machinery/multistructure/nuclear_reactor_part/wall
	icon_state = "wall"

/obj/machinery/multistructure/nuclear_reactor_part/wall_input
	icon_state = "wall_input"

/obj/machinery/multistructure/nuclear_reactor_part/wall_output
	icon_state = "wall_output"

/obj/machinery/multistructure/nuclear_reactor_part/console
	icon_state = "console"
	var/datum/multistructure/nuclear_reactor/Reactor

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

/obj/item/control_rod
	name = "control rod"
	desc = "A rod made of graphite, designed to moderate nuclear reactions by its presence."
	icon = './placeholders.dmi'
	icon_state = "control_rod"
	var/durability = 100

/obj/item/fuel_rod
	name = "aetherium fuel rod"
	desc = "A rod made of aetherium, acting as a suitable substitute for proper nuclear fuel. It is contained within a lead casing."
	icon = './placeholders.dmi'
	icon_state = "fuel_rod"
	var/durability = 100
	var/consumption_rate = 1
	var/heat_production = 100 // How much does the fuel rod increase the temperature of the reactor, in celcius
