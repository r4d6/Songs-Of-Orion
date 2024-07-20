// This machine turn aetherium crystals into liquid aetherium and put it in a bidon connected to it.
/obj/machinery/liquid_aetherium_processor
	name = "liquid aetherium processor"
	desc = "Convert Liquid Aetherium into multiple materials."
	icon = 'icons/obj/machines/grinder.dmi'
	icon_state = "aetherium_processor"
	density = TRUE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	use_power = IDLE_POWER_USE
	anchor_type = /obj/structure/reagent_dispensers/bidon
	anchor_direction = WEST
	circuit = /obj/item/electronics/circuitboard/liquid_aetherium_processor
	var/obj/structure/reagent_dispensers/bidon/Container
	var/outputs = list(
						list(name = "Steel", cost = 100, path = /obj/item/stack/material/steel),
						list(name = "Plastic", cost = 100, path = /obj/item/stack/material/plastic),
						list(name = "Glass", cost = 100, path = /obj/item/stack/material/glass),
						list(name = "Plasteel", cost = 350, path = /obj/item/stack/material/plasteel),
						list(name = "Silver", cost = 200, path = /obj/item/stack/material/silver),
						list(name = "Gold", cost = 200, path = /obj/item/stack/material/gold),
						list(name = "Platinum", cost = 250, path = /obj/item/stack/material/platinum),
						list(name = "Uranium", cost = 250, path = /obj/item/stack/material/uranium),
						list(name = "Crystal", cost = 250, path = /obj/item/stack/material/plasma),
						list(name = "Osmium", cost = 400, path = /obj/item/stack/material/osmium),
						list(name = "Diamonds", cost = 400, path = /obj/item/stack/material/diamond),
						list(name = "Metallic Hydrogen", cost = 400, path=/obj/item/stack/material/mhydrogen),
						list(name = "Tritium", cost = 400, path = /obj/item/stack/material/tritium),
						list(name = "Aetherium Core", cost = 3600, path=/obj/item/aetherium_gem)
						)
	var/cost_modifier = 1

/obj/machinery/liquid_aetherium_processor/New()
	..()

/obj/machinery/liquid_aetherium_processor/examine(mob/user)
	..()
	if(isghost(user))
		interact(user)

/obj/machinery/liquid_aetherium_processor/attackby(obj/item/I, mob/user)

	if(default_deconstruction(I, user))
		return

	if(default_part_replacement(I, user))
		return

	..()

	updateDialog()

/obj/machinery/liquid_aetherium_processor/RefreshParts()
	var/man_rating = 0
	var/man_amount = 0
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		man_rating += M.rating
		man_amount++
	man_rating /= man_amount

	cost_modifier = man_rating

	updateDialog()

/obj/machinery/liquid_aetherium_processor/attack_hand(mob/user as mob)
	interact(user)
	return

// Return the amount of aetherium the bidon has.
/obj/machinery/liquid_aetherium_processor/proc/get_bidon_aetherium()
	return Container?.reagents.get_reagent_amount(MATERIAL_AETHERIUM)

// Check if we have at least [amount] amount of liquid aetherium. It is different from get_bidon_aetherium() in that it only return TRUE or FALSE, and not the quantity of aetherium we have
/obj/machinery/liquid_aetherium_processor/proc/check_bidon_aetherium(var/amount)
	return Container?.reagents.has_reagent(MATERIAL_AETHERIUM, amount)

// Use [amount] of liquid aetherium
/obj/machinery/liquid_aetherium_processor/proc/use_bidon_aetherium(var/amount)
	return check_bidon_aetherium(amount) ? Container?.reagents.remove_reagent(MATERIAL_AETHERIUM, amount) : 0

// This proc search for nearby anchored BIDONS
/obj/machinery/liquid_aetherium_processor/proc/search_bidons()
	for(var/obj/structure/reagent_dispensers/bidon/B in range(1, src))
		if(B.anchored_machine == src)
			Container = B
			return
	Container = null // This should only happen if there was no anchored BIDONs nearby

/obj/machinery/liquid_aetherium_processor/interact(mob/user as mob)
	if((get_dist(src, user) > 1) || (stat & (BROKEN|NOPOWER)))
		if(!isAI(user) && !isghost(user))
			user.unset_machine()
			user << browse(null, "window=LiquidAetheriumProcessor")
			return

	search_bidons()

	user.set_machine(src)

	var/dat = ""
	dat += "<head><title>Liquid Aetherium Processor</title></head>"
	dat += "Liquid Aetherium Processor<BR>"
	dat += "<A href='?src=\ref[src];close=1'>Close</A><BR>"
	dat += "<A href='?src=\ref[src];refresh=1'>Refresh</A><BR><BR>"
	if(Container)
		dat += "Current quantity of liquid aetherium : [get_bidon_aetherium()].<BR><BR>"
		dat += mats_list_html()
	else
		dat += "No bidon detected. Please connect a bidon."

	user << browse(dat, "window=LiquidAetheriumProcessor")
	onclose(user, "LiquidAetheriumProcessor")
	return

/obj/machinery/liquid_aetherium_processor/Topic(href, href_list)
	if(isghost(usr)) // Ghosts can't do shit
		return

	//Ignore input if we are broken or guy is not touching us, AI can control from a ways away
	if(stat & (BROKEN|NOPOWER) || (get_dist(src, usr) > 1 && !isAI(usr)))
		usr.unset_machine()
		usr << browse(null, "window=LiquidAetheriumProcessor")
		return

	..()

	if(href_list["close"])
		usr << browse(null, "window=LiquidAetheriumProcessor")
		usr.unset_machine()
		return

	if(href_list["material"])
		var/list/L = list(path=text2path(href_list["material"]), cost=text2num(href_list["cost"]), amount=text2num(href_list["amount"]))
		var/L_path = L["path"]

		if(use_bidon_aetherium((L["cost"]) * L["amount"])) // Check if we have enough liquid aetherium
			if(ispath(L["path"], /obj/item/stack/material)) // Material sheets are handled differently
				new L_path(get_turf(src), L["amount"])
			else
				for(var/i = 0, L["amount"] > i, i++) // Create 1 item at a time
					new L_path(get_turf(src))
		else
			ping("Not enough liquid aetherium.")

	updateDialog()
	return



// Output list format : list(name=[text], cost=[num], path=[path])
// name is the visible name of what we're trying to make.
// cost is how much liquid aetherium is used to make 1 object.
// path is the actual path of the object

/obj/machinery/liquid_aetherium_processor/proc/mats_list_html()
	var/dat = ""
	dat += "List of materials : <BR>"
	for(var/list/L in outputs)
		dat += "[L["name"]], cost : [L["cost"] / cost_modifier] Liquid Aetherium.<BR>"
		dat += "- Print : "
		dat += "[check_bidon_aetherium((L["cost"]/cost_modifier)*1) ? "<A href='?src=\ref[src];material=[L["path"]];cost=[L["cost"]/cost_modifier];amount=1'>x1</A>" : "Not enough liquid aetherium"]"
		dat += "[check_bidon_aetherium((L["cost"]/cost_modifier)*5) ? ", <A href='?src=\ref[src];material=[L["path"]];cost=[L["cost"]/cost_modifier];amount=5'>x5</A>" : ""]"
		dat += "[check_bidon_aetherium((L["cost"]/cost_modifier)*10) ? ", <A href='?src=\ref[src];material=[L["path"]];cost=[L["cost"]/cost_modifier];amount=10'>x10</A>" : ""]"
		dat += "[check_bidon_aetherium((L["cost"]/cost_modifier)*20) ? ", <A href='?src=\ref[src];material=[L["path"]];cost=[L["cost"]/cost_modifier];amount=20'>x20</A>" : ""]"
		dat += "[check_bidon_aetherium((L["cost"]/cost_modifier)*60) ? ", <A href='?src=\ref[src];material=[L["path"]];cost=[L["cost"]/cost_modifier];amount=60'>x60</A>" : ""]"
		dat += "[check_bidon_aetherium((L["cost"]/cost_modifier)*120) ? ", <A href='?src=\ref[src];material=[L["path"]];cost=[L["cost"]/cost_modifier];amount=120'>x120</A>" : ""]"
		dat += ".<BR><BR>"
	return dat
