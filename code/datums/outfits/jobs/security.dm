/decl/hierarchy/outfit/job/security
	hierarchy_type = /decl/hierarchy/outfit/job/security
	l_ear = /obj/item/device/radio/headset/headset_sec
	shoes = /obj/item/clothing/shoes/color/white
	id_type = /obj/item/card/id/sec
	pda_type = /obj/item/modular_computer/pda/security
	backpack_contents = list(/obj/item/handcuffs = 1)

/decl/hierarchy/outfit/job/security/New()
	..()
	BACKPACK_OVERRIDE_SECURITY

/decl/hierarchy/outfit/job/security/ihc
	name = OUTFIT_JOB_NAME("Director of Asset Denial")
	l_ear = /obj/item/device/radio/headset/heads/hos
	uniform = /obj/item/clothing/under/rank/hos
	suit = /obj/item/clothing/suit/storage/toggle/hos
	l_pocket = /obj/item/device/flash
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	belt = /obj/item/gun/projectile/lamia
	id_type = /obj/item/card/id/hos
	head = /obj/item/clothing/head/patrol/sec/hos
	pda_type = /obj/item/modular_computer/pda/heads/hos
	backpack_contents = list(/obj/item/handcuffs = 1,/obj/item/ammo_magazine/magnum/rubber = 1,/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/cell/small/high = 2, /obj/item/gun/energy/gun/martin = 1, /obj/item/flame/lighter/zippo/syndicate = 1, /obj/item/storage/fancy/cigarettes/lucky = 1, /obj/item/clothing/accessory/cross = 1)

/decl/hierarchy/outfit/job/security/gunserg
	name = OUTFIT_JOB_NAME("Defunct")
	uniform = /obj/item/clothing/under/rank/warden
	suit = /obj/item/clothing/suit/armor/vest/ironhammer
	head = /obj/item/clothing/head/beret/sec/navy/warden
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/tactical
	l_pocket = /obj/item/device/flash
	gloves = /obj/item/clothing/gloves/stungloves
	backpack_contents = list(/obj/item/handcuffs = 1, /obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/cell/small/high = 2, /obj/item/gun/energy/gun/martin = 1)

/decl/hierarchy/outfit/job/security/inspector
	name = OUTFIT_JOB_NAME("Solar Marshal Deputy")
	uniform = /obj/item/clothing/under/rank/inspector
	suit = /obj/item/clothing/suit/storage/detective
	head = /obj/item/clothing/head/soft/sec/sol
	l_pocket = /obj/item/device/flash
	shoes = /obj/item/clothing/shoes/reinforced
	belt = /obj/item/gun/energy/gun/martin
	r_hand = /obj/item/storage/briefcase/crimekit
	id_type = /obj/item/card/id/det
	pda_type = /obj/item/modular_computer/pda/forensics
	backpack_contents = list(/obj/item/handcuffs = 1, /obj/item/ammo_magazine/slmagnum/rubber = 2, /obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/cell/small/high = 2)

/decl/hierarchy/outfit/job/security/detective/New()
	..()
	backpack_overrides.Cut()

/decl/hierarchy/outfit/job/security/medspec
	name = OUTFIT_JOB_NAME("Search And Rescue Specialist")
	l_pocket = /obj/item/device/flash
	id_type = /obj/item/card/id/medcpec
	uniform = /obj/item/clothing/under/rank/medspec
	pda_type = /obj/item/modular_computer/pda/forensics
	shoes = /obj/item/clothing/shoes/reinforced
	l_hand = /obj/item/storage/firstaid
	head = /obj/item/clothing/head/soft/sar
	gloves = /obj/item/clothing/gloves/thick
	backpack_contents = list(/obj/item/gun/energy/gun/martin = 1, /obj/item/cell/small/high = 1)

/decl/hierarchy/outfit/job/security/ihoper
	name = OUTFIT_JOB_NAME("Ironhammer Operative")
	l_pocket = /obj/item/device/flash
	uniform = /obj/item/clothing/under/rank/security
	head = /obj/item/clothing/head/soft/sec
	backpack_contents = list(/obj/item/handcuffs = 1, /obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/cell/small/high = 2, /obj/item/gun/energy/gun/martin = 1)
