/decl/hierarchy/outfit/job/engineering
	hierarchy_type = /decl/hierarchy/outfit/job/engineering
	l_ear = /obj/item/device/radio/headset/headset_eng
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/thick
	pda_slot = slot_l_store
	r_pocket = /obj/item/device/t_scanner
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_EXTENDED_SURVIVAL

/decl/hierarchy/outfit/job/engineering/New()
	..()
	BACKPACK_OVERRIDE_ENGINEERING

/decl/hierarchy/outfit/job/engineering/exultant
	name = OUTFIT_JOB_NAME("Chief Engineer")
	uniform = /obj/item/clothing/under/rank/exultant
	suit = /obj/item/clothing/suit/storage/te_coat
	l_ear = /obj/item/device/radio/headset/heads/ce
	shoes = /obj/item/clothing/shoes/reinforced
	head = /obj/item/clothing/head/beret/yellow
	id_type = /obj/item/card/id/ce
	suit = /obj/item/clothing/suit/storage/winter/hivis
	pda_type = /obj/item/modular_computer/pda/heads/ce
	backpack_contents = list(/obj/item/gun/projectile/selfload/makarov = 1, /obj/item/ammo_magazine/pistol/rubber = 2) //TE got the excel gun as a war trophy same as the hatton

/decl/hierarchy/outfit/job/engineering/engineer
	name = OUTFIT_JOB_NAME("Space Engineer")
	uniform = /obj/item/clothing/under/rank/engineer
	suit = /obj/item/clothing/suit/storage/vest/insulated
	id_type = /obj/item/card/id/engie
	l_ear = /obj/item/device/radio/headset/headset_eng
	pda_type = /obj/item/modular_computer/pda/engineering
	belt = /obj/item/storage/belt/utility/technomancer

/decl/hierarchy/outfit/job/engineering/engineer/void
	name = OUTFIT_JOB_NAME("Technomancer - Voidsuit")
	mask = /obj/item/clothing/mask/breath
	suit = /obj/item/clothing/suit/space/void/engineering

/decl/hierarchy/outfit/job/cargo/mining
	name = OUTFIT_JOB_NAME("EVA Reclaimation Personnel")
	uniform = /obj/item/clothing/under/rank/miner
	shoes = /obj/item/clothing/shoes/color/black
	pda_type = /obj/item/modular_computer/pda/moebius/science
	belt = /obj/item/storage/belt/utility
	l_ear = /obj/item/device/radio/headset/headset_eng/erp
	head = /obj/item/clothing/head/soft/grey
	gloves = /obj/item/clothing/gloves/fingerless
	backpack_contents = list(/obj/item/tool/crowbar = 1, /obj/item/storage/bag/ore = 1)
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_EXTENDED_SURVIVAL

/decl/hierarchy/outfit/job/cargo/mining/New()
	..()
	BACKPACK_OVERRIDE_ENGINEERING

/decl/hierarchy/outfit/job/cargo/mining/void
	name = OUTFIT_JOB_NAME("Guild Miner - Voidsuit")
	mask = /obj/item/clothing/mask/breath
	suit = /obj/item/clothing/suit/space/void/mining

/decl/hierarchy/outfit/job/engineering/foreman
	name = OUTFIT_JOB_NAME("EVA Foremxn")
	uniform = /obj/item/clothing/under/rank/diveboss
	shoes = /obj/item/clothing/shoes/reinforced
	l_ear = /obj/item/device/radio/headset/heads/ce/foreman
	pda_type = /obj/item/modular_computer/pda/moebius/science
	suit = /obj/item/clothing/suit/storage/harness
	head = /obj/item/clothing/head/patrol
	backpack_contents = list(/obj/item/tool/crowbar = 1, /obj/item/storage/bag/ore = 1)
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_EXTENDED_SURVIVAL