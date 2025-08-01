/obj/machinery/computer/prisoner
	name = "prisoner management console"
	icon = 'icons/obj/computer.dmi'
	icon_keyboard = "security_key"
	icon_screen = "explosive"
	light_color = COLOR_LIGHTING_SCI_BRIGHT
	req_access = list(access_armory)
	circuit = /obj/item/electronics/circuitboard/prisoner
	var/locked = TRUE

/obj/machinery/computer/prisoner/attack_hand(mob/user)
	if(..())
		return
	user.set_machine(src)
	var/dat
	dat += "<B>Prisoner Implant Manager System</B><BR>"
	if(locked)
		dat += "<HR><a href='byond://?src=\ref[src];lock=1'>Unlock Console</A>"
	else
		dat += "<HR>Chemical Implants<BR>"
		var/turf/Tr = null
		for(var/obj/item/implant/chem/C in world)
			Tr = get_turf(C)
			if((Tr) && !IS_SHIP_LEVEL(Tr.z)) continue //Out of range
			if(!C.implanted) continue
			dat += "[C.wearer.name] | Remaining Units: [C.reagents.total_volume] | Inject: "
			dat += "<a href='byond://?src=\ref[src];inject=\ref[C];amount=1'>(<font color=red>(1)</font>)</A>"
			dat += "<a href='byond://?src=\ref[src];inject=\ref[C];amount=5'>(<font color=red>(5)</font>)</A>"
			dat += "<a href='byond://?src=\ref[src];inject=\ref[C];amount=10'>(<font color=red>(10)</font>)</A><BR>"
			dat += "********************************<BR>"
		dat += "<HR>Tracking Implants<BR>"
		for(var/obj/item/implant/tracking/T in world)
			Tr = get_turf(T)
			if((Tr) && !IS_SHIP_LEVEL(Tr.z)) continue //Out of range
			if(!T.implanted) continue
			var/loc_display = "Unknown"
			var/mob/living/carbon/M = T.wearer
			if(IS_SHIP_LEVEL(M.z) && !istype(M.loc, /turf/space))
				var/turf/mob_loc = get_turf(M)
				loc_display = mob_loc.loc
			if(T.malfunction)
				loc_display = pick(SSmapping.main_ship_areas_by_name)
			dat += "ID: [T.gps.serial_number] | Location: [loc_display]<BR>"
			dat += "<A href='?src=\ref[src];warn=\ref[T]'>(<font color=red><i>Message Holder</i></font>)</A> |<BR>"
			dat += "********************************<BR>"
		dat += "<HR><A href='?src=\ref[src];lock=1'>Lock Console</A>"

	user << browse(dat, "window=computer;size=400x500")
	onclose(user, "computer")

/obj/machinery/computer/prisoner/Process()
	if(!..())
		updateDialog()

/obj/machinery/computer/prisoner/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)

	if(href_list["inject"])
		var/obj/item/implant/I = locate(href_list["inject"])
		var/amount = text2num(href_list["amount"])
		if(I && amount)
			I.activate(amount)

	else if(href_list["lock"])
		if(allowed(usr))
			locked = !locked
		else
			to_chat(usr, "Unauthorized Access.")

	else if(href_list["warn"])
		var/warning = sanitize(input(usr,"Message:","Enter your message here!",""))
		if(!warning) return
		var/obj/item/implant/I = locate(href_list["warn"])
		if(I && I.wearer)
			var/mob/living/carbon/R = I.wearer
			to_chat(R, SPAN_NOTICE("You hear a voice in your head saying: '[warning]'"))

	add_fingerprint(usr)
	updateUsrDialog()
