// Shoelocker
/datum/gear/shoes
	display_name = "sandals"
	path = /obj/item/clothing/shoes/sandal
	slot = slot_shoes
	sort_category = "Shoes and Footwear"

/datum/gear/shoes/boots
	display_name = "boot selection"
	path = /obj/item/clothing/shoes/jackboots

/datum/gear/shoes/boots/New()
	..()
	var/boots = list(
		"Jackboots"			=	/obj/item/clothing/shoes/jackboots,
		"Duty boots"				=	/obj/item/clothing/shoes/jackboots/duty,
		"Spurs"				=	/obj/item/clothing/shoes/spurs,
		"Workboots"			=	/obj/item/clothing/shoes/workboots,
	)
	gear_tweaks += new /datum/gear_tweak/path(boots)

/datum/gear/shoes/lacey
	display_name = "classy shoes, selection"
	path = /obj/item/clothing/shoes/reinforced

/datum/gear/shoes/lacey/New()
	..()
	var/lacey = list(
		"Reinforced"			=	/obj/item/clothing/shoes/reinforced,
		"Leather"			=	/obj/item/clothing/shoes/leather,
	)
	gear_tweaks += new /datum/gear_tweak/path(lacey)


/datum/gear/shoes/color_presets
	display_name = "shoes color selection"
	path = /obj/item/clothing/shoes/color/black

/datum/gear/shoes/color_presets/New()
	..()
	var/shoes = list(
		"Blue"			=	/obj/item/clothing/shoes/color/blue,
		"Orange"		=	/obj/item/clothing/shoes/color/orange,
		"Green"			=	/obj/item/clothing/shoes/color/green,
		"Brown"			=	/obj/item/clothing/shoes/color/brown,
		"Slate"			=	/obj/item/clothing/shoes/color/grey,
		"White"			=	/obj/item/clothing/shoes/color/white,
		"Red"			=	/obj/item/clothing/shoes/color/red,
		"Black"			=	/obj/item/clothing/shoes/color/black,
		"Yellow"		=	/obj/item/clothing/shoes/color/yellow,
		"Violet"		=	/obj/item/clothing/shoes/color/purple,
		"Rose"			=	/obj/item/clothing/shoes/color/rose,
		"Aqua"			=	/obj/item/clothing/shoes/color/aqua,
		"Rainbow"			=	/obj/item/clothing/shoes/color/rainbow,
	)
	gear_tweaks += new /datum/gear_tweak/path(shoes)

/datum/gear/shoes/sneaker_colors
	display_name = "sneaker color selection"
	path = /obj/item/clothing/shoes/sneakersred

/datum/gear/shoes/sneaker_colors/New()
	..()
	var/sneaker_colors = list(
		"Red" 		=	 /obj/item/clothing/shoes/sneakersred,
		"Blue" 		=	 /obj/item/clothing/shoes/sneakersblue,
		"Purple"	=	 /obj/item/clothing/shoes/sneakerspurple
	)
	gear_tweaks += new /datum/gear_tweak/path(sneaker_colors)

/datum/gear/shoes/slippers
	display_name = "slippers selection"
	path = /obj/item/clothing/shoes/slippers

/datum/gear/shoes/slippers/New()
	..()
	var/slippers = list(
		"Bunny" 		=	 /obj/item/clothing/shoes/slippers,
		"Bunny, worn" 		=	 /obj/item/clothing/shoes/slippers_worn
	)
	gear_tweaks += new /datum/gear_tweak/path(slippers)
