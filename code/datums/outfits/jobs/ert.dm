/decl/hierarchy/outfit/job/ert

	hierarchy_type = /decl/hierarchy/outfit/job/ert

	uniform = /obj/item/clothing/under/rank/security/bdu
	gloves = /obj/item/clothing/gloves/security/tactical
	r_ear = /obj/item/device/radio/headset/military
	shoes = /obj/item/clothing/shoes/jackboots
	belt = /obj/item/storage/belt/tactical
	pda_type = /obj/item/modular_computer/pda
	suit = /obj/item/clothing/suit/armor/bulletproof
	gloves = /obj/item/clothing/gloves/fingerless

/decl/hierarchy/outfit/job/security/New()
	..()
	BACKPACK_OVERRIDE_SECURITY


//He gets a snazzy beret
/decl/hierarchy/outfit/job/ert/peacecommander
	name = "Peacekeeper Squad Lead"
	head = /obj/item/clothing/head/beret
	r_ear = /obj/item/device/radio/headset/military/commander
	glasses = /obj/item/clothing/glasses/hud/security/tac
	backpack_contents = list(/obj/item/handcuffs = 1,/obj/item/ammo_magazine/magnum/rubber = 1,/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/clothing/mask/balaclava = 1)

/decl/hierarchy/outfit/job/ert/peacetrooper
	name = "Peacekeeper"
	head = /obj/item/clothing/head/beret/slate
	glasses = /obj/item/clothing/glasses/hud/security/tacfat
	backpack_contents = list(/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/clothing/mask/balaclava = 1)

/decl/hierarchy/outfit/job/ert/peacemedic
	name = "Peacekeeper Medic"
	head = /obj/item/clothing/head/beret/white
	glasses = /obj/item/clothing/glasses/hud/health/tacfat
	belt = /obj/item/storage/belt/medical/emt
	backpack_contents = list(/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/storage/firstaid/adv = 1, /obj/item/clothing/accessory/armband/med = 1, /obj/item/clothing/head/deckcrew/white = 1, /obj/item/clothing/mask/balaclava = 1)

/decl/hierarchy/outfit/job/ert/peacelogi
	name = "Peacekeeper Logistics Specialist"
	head = /obj/item/clothing/head/soft/grey
	glasses = /obj/item/clothing/glasses/hud/security/tacfat
	backpack_contents = list()


//Ready to rock RIGHT NOW for admin spawns
//Should be able to fight within a minute of loadout

/decl/hierarchy/outfit/job/ert/peacetrooper/combat
	name = "Peacekeeper Trooper"
	head = /obj/item/clothing/head/armor/bulletproof
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/hud/security/tacfat
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	r_hand = /obj/item/gun/projectile/automatic/pulse
	belt = /obj/item/storage/belt/tactical
	backpack_contents = list(/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/ammo_magazine/ihclrifle/hv = 3, /obj/item/grenade/frag = 2, /obj/item/clothing/mask/gas/ihs = 1)

/decl/hierarchy/outfit/job/ert/peacemedic/combat
	name = "Peacekeeper Combat Medic"
	head = /obj/item/clothing/head/deckcrew/white
	glasses = /obj/item/clothing/glasses/hud/health/tacfat
	belt = /obj/item/storage/belt/medical/emt
	mask = /obj/item/clothing/mask/balaclava
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	r_hand = /obj/item/gun/projectile/automatic/pulse
	backpack_contents = list(/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/storage/firstaid/adv = 1, /obj/item/storage/firstaid/combat = 1, /obj/item/clothing/accessory/armband/med = 1, /obj/item/ammo_magazine/ihclrifle/hv = 2, /obj/item/grenade/smokebomb = 2, /obj/item/clothing/mask/gas/ihs = 1)

/decl/hierarchy/outfit/job/ert/peacecommander/combat
	name = "Peacekeeper Fire Team Lead"
	head = /obj/item/clothing/head/beret
	r_ear = /obj/item/device/radio/headset/military/commander
	glasses = /obj/item/clothing/glasses/hud/security/tac
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	r_hand = /obj/item/gun/projectile/automatic/pulse
	belt = /obj/item/storage/belt/tactical
	backpack_contents = list(/obj/item/handcuffs = 1, /obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/ammo_magazine/ihclrifle/hv = 2, /obj/item/grenade/smokebomb = 2, /obj/item/device/radio/alt2 = 1, /obj/item/clothing/mask/gas/ihs = 1)
