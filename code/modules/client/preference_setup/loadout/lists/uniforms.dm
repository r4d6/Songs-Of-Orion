// Uniform slot
/datum/gear/uniform
	display_name = "vatnik outfit"
	path = /obj/item/clothing/under/vatnik
	slot = slot_w_uniform
	sort_category = "Uniforms and Casual Dress"

//GENERIC
/datum/gear/uniform/jumpsuit/color_presets
	display_name = "jumpsuit color selection"
	path = /obj/item/clothing/under/color/blue
	cost = 1

/datum/gear/uniform/jumpsuit/color_presets/New()
	..()
	var/jumpsuit = list(
		"Blue"			=	/obj/item/clothing/under/color/blue,
		"Orange"		=	/obj/item/clothing/under/color/orange,
		"Green"			=	/obj/item/clothing/under/color/green,
		"Brown"			=	/obj/item/clothing/under/color/brown,
		"Slate"			=	/obj/item/clothing/under/color/slate,
		"White"			=	/obj/item/clothing/under/color/white,
		"Red"			=	/obj/item/clothing/under/color/red,
		"Black"			=	/obj/item/clothing/under/color/black,
		"Yellow"		=	/obj/item/clothing/under/color/yellow,
		"Violet"		=	/obj/item/clothing/under/color/violet,
		"Rose"			=	/obj/item/clothing/under/color/rose,
		"Aqua"			=	/obj/item/clothing/under/color/aqua,
	)
	gear_tweaks += new /datum/gear_tweak/path(jumpsuit)

//FLIGHTSUITS
/datum/gear/uniform/flightsuit/color_presets
	display_name = "flightsuit selection"
	path = /obj/item/clothing/under/flightsuit
	cost = 1

/datum/gear/uniform/flightsuit/color_presets/New()
	..()
	var/flightsuit = list(
		"Orange"			=	/obj/item/clothing/under/flightsuit,
		"Green"				=	/obj/item/clothing/under/flightsuit/green,
	)
	gear_tweaks += new /datum/gear_tweak/path(flightsuit)


//TEE-SHIRTS

/datum/gear/uniform/tee/color_presets
	display_name = "casual-tee color selection"
	path = /obj/item/clothing/under/color/tee_shirt/blue
	cost = 1

/datum/gear/uniform/tee/color_presets/New()
	..()
	var/tee = list(
		"Blue"			=	/obj/item/clothing/under/color/tee_shirt/blue,
		"Orange"		=	/obj/item/clothing/under/color/tee_shirt/orange,
		"Green"			=	/obj/item/clothing/under/color/tee_shirt/green,
		"Brown"			=	/obj/item/clothing/under/color/tee_shirt/brown,
		"Slate"			=	/obj/item/clothing/under/color/tee_shirt/slate,
		"White"			=	/obj/item/clothing/under/color/tee_shirt/white,
		"Red"			=	/obj/item/clothing/under/color/tee_shirt/red,
		"Black"			=	/obj/item/clothing/under/color/tee_shirt/black,
		"Yellow"		=	/obj/item/clothing/under/color/tee_shirt/yellow,
		"Violet"		=	/obj/item/clothing/under/color/tee_shirt/violet,
		"Rose"			=	/obj/item/clothing/under/color/tee_shirt/rose,
		"Aqua"			=	/obj/item/clothing/under/color/tee_shirt/aqua,
	)
	gear_tweaks += new /datum/gear_tweak/path(tee)

//JEANS

/datum/gear/uniform/jeans/color_presets
	display_name = "casual jeans color selection"
	path = /obj/item/clothing/under/color/jeans/blue
	cost = 1

/datum/gear/uniform/jeans/color_presets/New()
	..()
	var/jeans = list(
		"Blue"			=	/obj/item/clothing/under/color/jeans/blue,
		"Orange"		=	/obj/item/clothing/under/color/jeans/orange,
		"Green"			=	/obj/item/clothing/under/color/jeans/green,
		"Brown"			=	/obj/item/clothing/under/color/jeans/brown,
		"Slate"			=	/obj/item/clothing/under/color/jeans/slate,
		"White"			=	/obj/item/clothing/under/color/jeans/white,
		"Red"			=	/obj/item/clothing/under/color/jeans/red,
		"Black"			=	/obj/item/clothing/under/color/jeans/black,
		"Yellow"		=	/obj/item/clothing/under/color/jeans/yellow,
		"Violet"		=	/obj/item/clothing/under/color/jeans/violet,
		"Rose"			=	/obj/item/clothing/under/color/jeans/rose,
		"Aqua"			=	/obj/item/clothing/under/color/jeans/aqua,
	)
	gear_tweaks += new /datum/gear_tweak/path(jeans)

//FLANNELS

/datum/gear/uniform/flannel/color_presets
	display_name = "flannel and jeans selection"
	path = /obj/item/clothing/under/color/jeans/flannel/blue
	cost = 1

/datum/gear/uniform/flannel/color_presets/New()
	..()
	var/flannel = list(
		"Blue"			=	/obj/item/clothing/under/color/jeans/flannel/blue,
		"Red"		=	/obj/item/clothing/under/color/jeans/flannel/red,
		"Green"			=	/obj/item/clothing/under/color/jeans/flannel/green,
		"Brown"			=	/obj/item/clothing/under/color/jeans/flannel/brown
	)
	gear_tweaks += new /datum/gear_tweak/path(flannel)


//SILK BUTTON-UPS

/datum/gear/uniform/silk/color_presets
	display_name = "silk outfit selection"
	path = /obj/item/clothing/under/color/silk/blue
	cost = 1

/datum/gear/uniform/silk/color_presets/New()
	..()
	var/silk = list(
		"Blue"			=	/obj/item/clothing/under/color/silk/blue,
		"Orange"		=	/obj/item/clothing/under/color/silk/orange,
		"Green"			=	/obj/item/clothing/under/color/silk/green,
		"Brown"			=	/obj/item/clothing/under/color/silk/brown,
		"Slate"			=	/obj/item/clothing/under/color/silk/slate,
		"White"			=	/obj/item/clothing/under/color/silk/white,
		"Red"			=	/obj/item/clothing/under/color/silk/red,
		"Black"			=	/obj/item/clothing/under/color/silk/black,
		"Yellow"		=	/obj/item/clothing/under/color/silk/yellow,
		"Violet"		=	/obj/item/clothing/under/color/silk/violet,
		"Rose"			=	/obj/item/clothing/under/color/silk/rose,
		"Aqua"			=	/obj/item/clothing/under/color/silk/aqua,
	)
	gear_tweaks += new /datum/gear_tweak/path(silk)

//SILK BUTTON-UPS WITH SKIRTS

/datum/gear/uniform/silkskirt/color_presets
	display_name = "silk skirt selection"
	path = /obj/item/clothing/under/color/skirt/blue
	cost = 1

/datum/gear/uniform/silkskirt/color_presets/New()
	..()
	var/silkskirt = list(
		"Blue"			=	/obj/item/clothing/under/color/skirt/blue,
		"Orange"		=	/obj/item/clothing/under/color/skirt/orange,
		"Green"			=	/obj/item/clothing/under/color/skirt/green,
		"Brown"			=	/obj/item/clothing/under/color/skirt/brown,
		"Slate"			=	/obj/item/clothing/under/color/skirt/slate,
		"White"			=	/obj/item/clothing/under/color/skirt/white,
		"Red"			=	/obj/item/clothing/under/color/skirt/red,
		"Black"			=	/obj/item/clothing/under/color/skirt/black,
		"Yellow"		=	/obj/item/clothing/under/color/skirt/yellow,
		"Violet"		=	/obj/item/clothing/under/color/skirt/violet,
		"Rose"			=	/obj/item/clothing/under/color/skirt/rose,
		"Aqua"			=	/obj/item/clothing/under/color/skirt/aqua,
	)
	gear_tweaks += new /datum/gear_tweak/path(silkskirt)

//SUITS, BUSY

/datum/gear/uniform/bsuit/color_presets
	display_name = "business suit selection"
	path = /obj/item/clothing/under/color/suit/blue
	cost = 1

/datum/gear/uniform/bsuit/color_presets/New()
	..()
	var/bsuit = list(
		"Blue"			=	/obj/item/clothing/under/color/suit/blue,
		"Brown"			=	/obj/item/clothing/under/color/suit/brown,
		"Red"			=	/obj/item/clothing/under/color/suit/red,
		"Black"			=	/obj/item/clothing/under/color/suit/black,
		"Violet"		=	/obj/item/clothing/under/color/suit/violet,
	)
	gear_tweaks += new /datum/gear_tweak/path(bsuit)

//SKIRTS, BUSY

/datum/gear/uniform/bskirt/color_presets
	display_name = "business skirt selection"
	path = /obj/item/clothing/under/color/bskirt/blue
	cost = 1

/datum/gear/uniform/bskirt/color_presets/New()
	..()
	var/bskirt = list(
		"Blue"			=	/obj/item/clothing/under/color/bskirt/blue,
		"Brown"			=	/obj/item/clothing/under/color/bskirt/brown,
		"Red"			=	/obj/item/clothing/under/color/bskirt/red,
		"Black"			=	/obj/item/clothing/under/color/bskirt/black,
		"Violet"		=	/obj/item/clothing/under/color/bskirt/violet,
	)
	gear_tweaks += new /datum/gear_tweak/path(bskirt)

//NON-STATION OUTFITS

/datum/gear/uniform/citizen/color_presets
	display_name = "Citizen outfit selection"
	path = /obj/item/clothing/under/citizen
	cost = 1

/datum/gear/uniform/citizen/color_presets/New()
	..()
	var/citizen = list(
		"Citizen"		=	/obj/item/clothing/under/citizen,
		"Beta Class"	=	/obj/item/clothing/under/citizen/beta,
		"Gamma Class"	=	/obj/item/clothing/under/citizen/gamma,
		"Delta Class"	=	/obj/item/clothing/under/citizen/delta,
		"Waiter"		=	/obj/item/clothing/under/waiter,
		"Waiter, skirt"	= 	/obj/item/clothing/under/waiter/skirt,
		"Maid"			=	/obj/item/clothing/under/maid,
		"Kimono"		=	/obj/item/clothing/under/kimono
	)
	gear_tweaks += new /datum/gear_tweak/path(citizen)


/datum/gear/uniform/legacy/color_presets
	display_name = "legacy jumpsuit selection"
	path = /obj/item/clothing/under/legacy/greytide
	cost = 1

/datum/gear/uniform/legacy/color_presets/New()
	..()
	var/legacy = list(
		"Assistant"			=	/obj/item/clothing/under/legacy/greytide,
		"Janitor"			=	/obj/item/clothing/under/legacy/janitor,
		"Botanist"			=	/obj/item/clothing/under/legacy/botany,
		"Cargo"				=	/obj/item/clothing/under/legacy/cargo,
		"Engineer"			=	/obj/item/clothing/under/legacy/engineer,
		"Medical"			= 	/obj/item/clothing/under/legacy/medical,
		"Science"			=	/obj/item/clothing/under/legacy/science,
		"Chemist"			=	/obj/item/clothing/under/legacy/chemist,
		"Security"			= 	/obj/item/clothing/under/legacy/security
	)
	gear_tweaks += new /datum/gear_tweak/path(legacy)

/datum/gear/uniform/kilt/color_presets
	display_name = "kilt selection"
	path = /obj/item/clothing/under/kilt
	cost = 1

/datum/gear/uniform/kilt/color_presets/New()
	..()
	var/kilt = list(
		"Standard"		=	/obj/item/clothing/under/kilt,
		"Formal"	=	/obj/item/clothing/under/kilt/formal,
		"Casual"	=	/obj/item/clothing/under/kilt/casual
	)
	gear_tweaks += new /datum/gear_tweak/path(kilt)

/datum/gear/uniform/leisure

/datum/gear/uniform/leisure
	display_name = "leisure suits"
	path = /obj/item/clothing/under/leisure

/datum/gear/uniform/leisure/New()
	..()
	var/leisure = list(
		"Brown Jacket" 			=	 /obj/item/clothing/under/leisure,
		"White Blazer" 			=	 /obj/item/clothing/under/leisure/white,
		"Patterned Pullover" 	=	 /obj/item/clothing/under/leisure/pullover,
		"Business Casual, blue"	=	 /obj/item/clothing/under/leisure/casual/blue,
		"Business Casual, red"	=	 /obj/item/clothing/under/leisure/joe
	)
	gear_tweaks += new /datum/gear_tweak/path(leisure)

//TODO: Corpo PCRC uniform
/datum/gear/uniform/sec/color_presets
	display_name = "Security alt selection"
	path = /obj/item/clothing/under/rank/security/red
	cost = 1
	allowed_roles = list(JOBS_SECURITY)

/datum/gear/uniform/sec/color_presets/New()
	..()
	var/sec = list(
		"Old NT"		=	/obj/item/clothing/under/rank/security/red,
		"Old NT skirt"	=	/obj/item/clothing/under/rank/security/red/skirt
	)
	gear_tweaks += new /datum/gear_tweak/path(sec)

/datum/gear/uniform/sar/color_presets
	display_name = "SAR alt selection"
	path = /obj/item/clothing/under/rank/medspec/skirt
	cost = 1
	allowed_roles = list(JOBS_SECURITY)

/datum/gear/uniform/sar/color_presets/New()
	..()
	var/sar = list(
		"Skirt"		=	/obj/item/clothing/under/rank/medspec/skirt,
		"FROG"		=	/obj/item/clothing/under/frog/sar,
		"FROG skirt"=	/obj/item/clothing/under/frog/sar/skirt,
	)
	gear_tweaks += new /datum/gear_tweak/path(sar)

/datum/gear/uniform/engineering/color_presets
	display_name = "Engineer alt selection"
	path = /obj/item/clothing/under/flightsuit/engineer
	cost = 1
	allowed_roles = list(JOBS_ENGINEERING)

/datum/gear/uniform/engineering/color_presets/New()
	..()
	var/engineering = list(
		"Engineer Flightsuit"	=	/obj/item/clothing/under/flightsuit/engineer,
		"Engineer FROG"			=	/obj/item/clothing/under/frog/engineer,
		"ERP jumpsuit"			=	/obj/item/clothing/under/rank/diver,
		"ERP FROG"				=	/obj/item/clothing/under/frog/erp,
		"Legacy"			=	/obj/item/clothing/under/legacy/engineer
	)
	gear_tweaks += new /datum/gear_tweak/path(engineering)

/datum/gear/uniform/syndicate/color_presets
	display_name = "Syndicate alt selection"
	path = /obj/item/clothing/under/flightsuit/cargo
	cost = 1
	allowed_roles = list(JOBS_CARGO)

/datum/gear/uniform/syndicate/color_presets/New()
	..()
	var/syndicate = list(
		"Flightsuit"	=	/obj/item/clothing/under/flightsuit/cargo,
		"FROG"			=	/obj/item/clothing/under/frog/cargo,
		"Legacy"				=	/obj/item/clothing/under/legacy/cargo
	)
	gear_tweaks += new /datum/gear_tweak/path(syndicate)

/datum/gear/uniform/brotherhood
	display_name = "Brotherhood turtleneck"
	path = /obj/item/clothing/under/rank/volunteer/turtle
	allowed_roles = list(JOBS_MEDICAL)
