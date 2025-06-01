/datum/gear/head
	display_name = "Hat"
	path = /obj/item/clothing/head/trucker/serious
	slot = slot_head
	sort_category = "Hats and Headwear"

// TIA-598 Sorting
//BLUE - ORANGE - GREEN - BROWN - SLATE - WHITE - RED - BLACK - YELLOW - VIOLET - ROSE - AQUA

//BERETES
/datum/gear/head/beret/color_presets
	display_name = "berets, color presets"
	path = /obj/item/clothing/head/beret

/datum/gear/head/beret/color_presets/New()
	..()
	var/beret = list(
		"Blue"			=	/obj/item/clothing/head/beret,
		"Orange"		=	/obj/item/clothing/head/beret/orange,
		"Green"			=	/obj/item/clothing/head/beret/green,
		"Brown"			=	/obj/item/clothing/head/beret/brown,
		"Slate"			=	/obj/item/clothing/head/beret/slate,
		"White"			=	/obj/item/clothing/head/beret/white,
		"Red"			=	/obj/item/clothing/head/beret/red,
		"Black"			=	/obj/item/clothing/head/beret/black,
		"Yellow"		=	/obj/item/clothing/head/beret/yellow,
		"Violet"		=	/obj/item/clothing/head/beret/purple,
		"Rose"			=	/obj/item/clothing/head/beret/rose,
		"Aqua"			=	/obj/item/clothing/head/beret/aqua,
	)
	gear_tweaks += new /datum/gear_tweak/path(beret)

//BASEBALL AND TRUCKER CAPS

/datum/gear/head/cap/color_presets
	display_name = "caps, color selection"
	path = /obj/item/clothing/head/soft/blue

/datum/gear/head/cap/color_presets/New()
	..()
	var/cap = list(
		"Blue"			=	/obj/item/clothing/head/soft/blue,
		"Orange"		=	/obj/item/clothing/head/soft/orange,
		"Green"			=	/obj/item/clothing/head/soft/green,
		"Brown"			=	/obj/item/clothing/head/soft/brown,
		"Slate"			=	/obj/item/clothing/head/soft/grey,
		"White"			=	/obj/item/clothing/head/soft/mime,
		"Red"			=	/obj/item/clothing/head/soft/red,
		"Black"			=	/obj/item/clothing/head/soft/black,
		"Yellow"		=	/obj/item/clothing/head/soft/yellow,
		"Violet"		=	/obj/item/clothing/head/soft/purple,
		"Rose"			=	/obj/item/clothing/head/soft/rose,
		"Aqua"			=	/obj/item/clothing/head/soft/aqua,
		"Rainbow"		=	/obj/item/clothing/head/soft/rainbow,
		"Military, Olive"=	/obj/item/clothing/head/soft/green2soft,
		"Military, Brown"=	/obj/item/clothing/head/soft/tan2soft,
	)
	gear_tweaks += new /datum/gear_tweak/path(cap)

/datum/gear/head/trucker/color_presets
	display_name = "trucker hat selection"
	path = /obj/item/clothing/head/trucker

/datum/gear/head/trucker/color_presets/New()
	..()
	var/trucker = list(
		"Blue"			=	/obj/item/clothing/head/trucker,
		"Orange"		=	/obj/item/clothing/head/trucker/orange,
		"Green"			=	/obj/item/clothing/head/trucker/green,
		"Brown"			=	/obj/item/clothing/head/trucker/brown,
		"Slate"			=	/obj/item/clothing/head/trucker/slate,
		"White"			=	/obj/item/clothing/head/trucker/white,
		"Red"			=	/obj/item/clothing/head/trucker/red,
		"Black"			=	/obj/item/clothing/head/trucker/black,
		"Yellow"		=	/obj/item/clothing/head/trucker/yellow,
		"Violet"		=	/obj/item/clothing/head/trucker/violet,
		"Rose"			=	/obj/item/clothing/head/trucker/rose,
		"Aqua"			=	/obj/item/clothing/head/trucker/aqua,
	)
	gear_tweaks += new /datum/gear_tweak/path(trucker)

/datum/gear/head/patrol/color_presets
	display_name = "patrol cap selection"
	path = /obj/item/clothing/head/patrol

/datum/gear/head/patrol/color_presets/New()
	..()
	var/patrol = list(
		"Green"			=	/obj/item/clothing/head/patrol,
		"Tan"			=	/obj/item/clothing/head/patrol/brown,
		"Black"			=	/obj/item/clothing/head/patrol/black,
		"NanoTrassen"	=	/obj/item/clothing/head/patrol/nt,
		"NT Sec"		=	/obj/item/clothing/head/patrol/sec/red,
		"PCRC"			=	/obj/item/clothing/head/patrol/pcrc,
	)
	gear_tweaks += new /datum/gear_tweak/path(patrol)

/datum/gear/head/cap/corp
	display_name = "cap, corporate security"
	path = /obj/item/clothing/head/soft/sec/corp

/datum/gear/head/cap/sec
	display_name = "cap, NT security"
	path = /obj/item/clothing/head/soft/sec2soft
	allowed_roles = list(ASSISTANT_TITLE)

/datum/gear/head/cap/synd
	display_name = "cap, syndicate"
	path = /obj/item/clothing/head/soft/synd

//HELMETS
/datum/gear/head/hardhat/color_presets
	display_name = "hardhat, color presets"
	path = /obj/item/clothing/head/hardhat/blue
	cost = 2

/datum/gear/head/hardhat/color_presets/New()
	..()
	var/hardhat = list(
		"Red"		=	/obj/item/clothing/head/hardhat/red,
		"Orange"	=	/obj/item/clothing/head/hardhat/orange,
		"Yellow"	=	/obj/item/clothing/head/hardhat,
		"Blue"		=	/obj/item/clothing/head/hardhat/blue,
	)
	gear_tweaks += new /datum/gear_tweak/path(hardhat)

/datum/gear/head/deckcrew/color_presets
	display_name = "deck crew helmet selection"
	path = /obj/item/clothing/head/deckcrew
	cost = 2

/datum/gear/head/deckcrew/color_presets/New()
	..()
	var/deckcrew = list(
		"Blue"		=	/obj/item/clothing/head/deckcrew,
		"Green"		=	/obj/item/clothing/head/deckcrew/green,
		"Brown"		=	/obj/item/clothing/head/deckcrew/brown,
		"White"		=	/obj/item/clothing/head/deckcrew/white,
		"Red"		=	/obj/item/clothing/head/deckcrew/red,
		"Yellow"	=	/obj/item/clothing/head/deckcrew/yellow,
		"Violet"		=	/obj/item/clothing/head/deckcrew/violet,
	)
	gear_tweaks += new /datum/gear_tweak/path(deckcrew)

/datum/gear/head/cyberpunkgoggle
	display_name = "Type-34C Semi-Enclosed Headwear"
	path = /obj/item/clothing/head/armor/helmet/visor/cyberpunkgoggle
	cost = 2

/datum/gear/head/tanker_helmet/color_presets
	display_name = "tanker helmet, color presets"
	path = /obj/item/clothing/head/armor/helmet/tanker
	allowed_roles = list("Moebius Roboticist", "Guild Technician", "Technomancer", "Technomancer Exultant", ASSISTANT_TITLE)
	cost = 2

/datum/gear/head/tanker_helmet/color_presets/New()
	..()
	var/tanker_helmet = list(
		"Black"		=	/obj/item/clothing/head/armor/helmet/tanker,
		"Green"		=	/obj/item/clothing/head/armor/helmet/tanker/green,
		"Brown"		=	/obj/item/clothing/head/armor/helmet/tanker/brown,
		"Gray"		=	/obj/item/clothing/head/armor/helmet/tanker/gray,
	)
	gear_tweaks += new /datum/gear_tweak/path(tanker_helmet)

//MISC

/datum/gear/head/cap/ushanka
	display_name = "cap, ushanka"
	path = /obj/item/clothing/head/ushanka

/datum/gear/head/cap/ushanka/New()
    ..()
    var/ushanka = list(
        "Tan"	= /obj/item/clothing/head/ushanka,
        "Black" = /obj/item/clothing/head/ushanka/black
    )
    gear_tweaks += new /datum/gear_tweak/path(ushanka)

/datum/gear/head/hairflower
	display_name = "hair flower pin, red"
	path = /obj/item/clothing/head/hairflower