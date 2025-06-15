// Eyes
/datum/gear/eyes
	display_name = "Glasses, prescription"
	path = /obj/item/clothing/glasses/regular
	slot = slot_glasses
	sort_category = "Glasses and Eyewear"

/datum/gear/eyes/eyepatch
	display_name = "eyepatch"
	path = /obj/item/clothing/glasses/eyepatch
	cost = 2

/datum/gear/eyes/clear_goggles
	display_name = "goggles"
	path = /obj/item/clothing/glasses/regular/goggles/clear


//SECURITY
/datum/gear/eyes/sec/color_presets
	display_name = "Security HUD selection"
	path = /obj/item/clothing/glasses/hud/security
	allowed_roles = list(JOBS_SECURITY)

/datum/gear/eyes/sec/color_presets/New()
	..()
	var/sec = list(
		"Slim"			=	/obj/item/clothing/glasses/hud/security/slim,
		"Standard"		=	/obj/item/clothing/glasses/hud/security,
		"Advanced"		=	/obj/item/clothing/glasses/hud/security/big,
		"Tactical"		=	/obj/item/clothing/glasses/hud/security/tacfat,
		"Tactical, slim"=	/obj/item/clothing/glasses/hud/security/tac,
		"Sunglasses"	=	/obj/item/clothing/glasses/sunglasses/sechud
	)
	gear_tweaks += new /datum/gear_tweak/path(sec)

//MEDICAL
/datum/gear/eyes/med/color_presets
	display_name = "Medical HUD selection"
	path = /obj/item/clothing/glasses/hud/health
	allowed_roles = list(JOBS_MEDICAL)

/datum/gear/eyes/med/color_presets/New()
	..()
	var/med = list(
		"Slim"			=	/obj/item/clothing/glasses/hud/health/slim,
		"Standard"		=	/obj/item/clothing/glasses/hud/health,
		"Advanced"		=	/obj/item/clothing/glasses/hud/health/big,
		"Tactical"		=	/obj/item/clothing/glasses/hud/health/tacfat,
		"Tactical, slim"=	/obj/item/clothing/glasses/hud/health/tac,
		"Prescription"	=	/obj/item/clothing/glasses/hud/health/prescription,
		"Sunglasses"	=	/obj/item/clothing/glasses/sunglasses/medhud
	)
	gear_tweaks += new /datum/gear_tweak/path(med)

/datum/gear/eyes/shades
	display_name = "Sunglasses"
	path = /obj/item/clothing/glasses/sunglasses
	cost = 2

/datum/gear/eyes/shades/prescriptionsun
	display_name = "Sunglasses, prescription"
	path = /obj/item/clothing/glasses/sunglasses/prescription
