// Suit slot
/datum/gear/suit
	display_name = "apron"
	path = /obj/item/clothing/suit/apron
	slot = slot_wear_suit
	sort_category = "Suits and Overwear"

/datum/gear/suit/jacket
	display_name = "leather coat selection"
	path = /obj/item/clothing/suit/storage/toggle/bomber
	cost = 1

/datum/gear/suit/jacket/New()
	..()
	var/jacket = list(
		"Bomber" 			= 	/obj/item/clothing/suit/storage/toggle/bomber,
		"Leather" 			= 	/obj/item/clothing/suit/storage/toggle/leather,
		"Red leather" 		= 	/obj/item/clothing/suit/storage/toggle/leather/red,
		"Duster" 			= 	/obj/item/clothing/suit/storage/duster,
		"Kaydee trenchcoat" = 	/obj/item/clothing/suit/storage/toggle/kaydee,
		"Batty trenchcoat" 	= 	/obj/item/clothing/suit/storage/toggle/batty,
	)
	gear_tweaks += new /datum/gear_tweak/path(jacket)

/datum/gear/suit/cloak
	display_name = "Celtic cloak"
	path = /obj/item/clothing/suit/cloak

/datum/gear/suit/patient
	display_name = "patient gown"
	path = /obj/item/clothing/suit/patient
	cost = 0

/datum/gear/suit/labcoat
	display_name = "old labcoat"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/old

/datum/gear/suit/harness/color_presets
	display_name = "equipment harness selection"
	path = /obj/item/clothing/suit/storage/harness
	cost = 2

/datum/gear/suit/harness/color_presets/New()
	..()
	var/harness = list(
		"Black"		=	/obj/item/clothing/suit/storage/harness,
		"Brown"		=	/obj/item/clothing/suit/storage/harness/brown,
	)
	gear_tweaks += new /datum/gear_tweak/path(harness)

/datum/gear/suit/hazard_vest
	display_name = "hazard vest"
	path = /obj/item/clothing/suit/storage/hazardvest

/datum/gear/suit/hivisjacket
	display_name = "high visibility jacket"
	path = /obj/item/clothing/suit/storage/winter/hivis

/datum/gear/suit/deckvest/color_presets
	display_name = "deck crew vest selection"
	path = /obj/item/clothing/suit/storage/vest/deckcrew
	cost = 2

/datum/gear/suit/deckvest/color_presets/New()
	..()
	var/deckvest = list(
		"Blue"		=	/obj/item/clothing/suit/storage/vest/deckcrew,
		"Green"		=	/obj/item/clothing/suit/storage/vest/deckcrew/green,
		"Brown"		=	/obj/item/clothing/suit/storage/vest/deckcrew/brown,
		"White"		=	/obj/item/clothing/suit/storage/vest/deckcrew/white,
		"Red"		=	/obj/item/clothing/suit/storage/vest/deckcrew/red,
		"Yellow"	=	/obj/item/clothing/suit/storage/vest/deckcrew/yellow,
		"Violet"		=	/obj/item/clothing/suit/storage/vest/deckcrew/violet,
	)
	gear_tweaks += new /datum/gear_tweak/path(deckvest)

/datum/gear/suit/winter
	display_name = "winter coat selection"
	path = /obj/item/clothing/suit/storage/winter
	cost = 1

/datum/gear/suit/winter/New()
	..()
	var/winter = list(
		"Grey" 				= 	/obj/item/clothing/suit/storage/winter,
		"Cargo" 			= 	/obj/item/clothing/suit/storage/winter/cargo,
		"Old Sec" 			= 	/obj/item/clothing/suit/storage/winter/sec,
		"Medical" 			= 	/obj/item/clothing/suit/storage/winter/med,
		"NanoTrassen" 		= 	/obj/item/clothing/suit/storage/winter/nt,
	)
	gear_tweaks += new /datum/gear_tweak/path(winter)