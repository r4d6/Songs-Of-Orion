
/obj/machinery/artillerycontrol
	var/reload = 180
	name = "bluespace artillery control"
	icon_state = "control_boxp1"
	icon = 'icons/obj/machines/particle_accelerator2.dmi'
	density = TRUE
	anchored = TRUE

/obj/machinery/artillerycontrol/Process()
	if(src.reload<180)
		src.reload++

/obj/structure/artilleryplaceholder
	name = "artillery"
	icon = 'icons/obj/machines/artillery.dmi'
	anchored = TRUE
	density = TRUE

/obj/structure/artilleryplaceholder/decorative
	density = FALSE

/obj/machinery/artillerycontrol/attack_hand(mob/user)
	user.set_machine(src)
	var/dat = "<B>Bluespace Artillery Control:</B><BR>"
	dat += "Locked on<BR>"
	dat += "<B>Charge progress: [reload]/180:</B><BR>"
	dat += "<A href='byond://?src=\ref[src];fire=1'>Open Fire</A><BR>"
	dat += "Deployment of weapon authorized by <br>[company_name] Naval Command<br><br>Remember, friendly fire is grounds for termination of your contract and life.<HR>"
	user << browse(dat, "window=scroll")
	onclose(user, "scroll")
	return

/obj/machinery/artillerycontrol/Topic(href, href_list)
	..()
	if(usr.stat || usr.restrained())
		return
	if((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || (issilicon(usr)))
		var/A
		A = input("Area to jump bombard", "Open Fire", A) in SSmapping.main_ship_areas_by_name
		var/area/thearea = SSmapping.main_ship_areas_by_name[A]
		if(usr.stat || usr.restrained()) return
		if(src.reload < 180) return
		if((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || (issilicon(usr)))
			command_announcement.Announce("Bluespace artillery fire detected. Brace for impact.")
			message_admins("[key_name_admin(usr)] has launched an artillery strike.", 1)
			var/list/L = list()
			for(var/turf/T in get_area_turfs(thearea.type))
				L+=T
			var/loc = pick(L)
			explosion(get_turf(loc), 1000, 75)
			reload = 0
