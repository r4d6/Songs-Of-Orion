/decl/hierarchy/outfit/job/ert

	hierarchy_type = /decl/hierarchy/outfit/job/ert

	uniform = /obj/item/clothing/under/rank/security/bdu
	r_ear = /obj/item/device/radio/headset/military
	shoes = /obj/item/clothing/shoes/jackboots
	belt = /obj/item/storage/belt/tactical
	gloves = /obj/item/clothing/gloves/fingerless

/decl/hierarchy/outfit/job/ert/New()
	..()
	BACKPACK_OVERRIDE_SECURITY


//He gets a snazzy beret
/decl/hierarchy/outfit/job/ert/peacecommander
	name = "Peacekeeper Squad Lead"
	head = /obj/item/clothing/head/beret/red
	r_ear = /obj/item/device/radio/headset/military/commander
	glasses = /obj/item/clothing/glasses/hud/security/tac
	backpack_contents = list(/obj/item/ammo_magazine/magnum/rubber = 1,/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/clothing/mask/balaclava = 1, /obj/item/clothing/accessory/armband = 1)
	id = /obj/item/card/id/solcom/peace/sarge


/decl/hierarchy/outfit/job/ert/peacetrooper
	name = "Peacekeeper"
	head = /obj/item/clothing/head/beret
	glasses = /obj/item/clothing/glasses/hud/security/tacfat
	backpack_contents = list(/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/clothing/mask/balaclava = 1)
	id = /obj/item/card/id/solcom/peace

/decl/hierarchy/outfit/job/ert/peacemedic
	name = "Peacekeeper Medic"
	head = /obj/item/clothing/head/beret/white
	glasses = /obj/item/clothing/glasses/hud/health/tacfat
	belt = /obj/item/storage/belt/medical/emt
	backpack_contents = list(/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/storage/firstaid/adv = 1, /obj/item/clothing/accessory/armband/med = 1, /obj/item/clothing/head/deckcrew/white = 1, /obj/item/clothing/mask/balaclava = 1)
	id = /obj/item/card/id/solcom/peace/medic

/decl/hierarchy/outfit/job/ert/peacelogi
	name = "Peacekeeper Logistics Specialist"
	head = /obj/item/clothing/head/soft/grey
	glasses = /obj/item/clothing/glasses/hud/security/tacfat
	backpack_contents = list()


//Ready to rock RIGHT NOW for admin spawns
//Should be able to fight within a minute of loadout

/decl/hierarchy/outfit/job/ert/peacetrooper/combat
	name = "Combat - Peacekeeper Trooper"
	head = /obj/item/clothing/head/armor/bulletproof
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/hud/security/tacfat
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	r_hand = /obj/item/gun/projectile/automatic/pulse
	belt = /obj/item/storage/belt/tactical/ironhammer
	backpack_contents = list(/obj/item/storage/ration_pack = 1, /obj/item/clothing/mask/gas/ihs = 1, /obj/item/storage/briefcase/inflatable = 1, /obj/item/grenade/smokebomb = 2, /obj/item/grenade/frag = 4)
	id = /obj/item/card/id/solcom/peace
	r_pocket = /obj/item/storage/pouch/ammo/cl
	suit = /obj/item/clothing/suit/armor/bulletproof

/decl/hierarchy/outfit/job/ert/peacemedic/combat
	name = "Combat - Peacekeeper Medic"
	head = /obj/item/clothing/head/deckcrew/white
	glasses = /obj/item/clothing/glasses/hud/health/tacfat
	belt = /obj/item/storage/belt/medical/emt/combat
	mask = /obj/item/clothing/mask/balaclava
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	r_hand = /obj/item/gun/projectile/automatic/pulse
	gloves = /obj/item/clothing/gloves/thick
	backpack_contents = list(/obj/item/storage/firstaid/adv = 1, /obj/item/storage/firstaid/combat = 1, /obj/item/clothing/accessory/armband/med = 1, /obj/item/grenade/smokebomb = 2, /obj/item/clothing/mask/gas/ihs = 1, /obj/item/storage/ration_pack = 1)
	id = /obj/item/card/id/solcom/peace/medic
	r_pocket = /obj/item/storage/pouch/ammo/cl
	suit = /obj/item/clothing/suit/armor/bulletproof

/decl/hierarchy/outfit/job/ert/peacecommander/combat
	name = "Combat - Peacekeeper Sargeant"
	head = /obj/item/clothing/head/beret
	r_ear = /obj/item/device/radio/headset/military/commander
	glasses = /obj/item/clothing/glasses/hud/security/tac
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	r_hand = /obj/item/gun/projectile/automatic/pulse
	belt = /obj/item/storage/belt/tactical/ironhammer
	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/device/radio/alt2 = 1, /obj/item/clothing/mask/gas/ihs = 1, /obj/item/storage/ration_pack = 1, /obj/item/storage/pouch/ammo/cl = 1, /obj/item/clothing/accessory/armband = 1)
	id = /obj/item/card/id/solcom/peace/sarge
	r_pocket = /obj/item/storage/pouch/ammo/cl
	suit = /obj/item/clothing/suit/armor/bulletproof

//Funni halfe lymf
/decl/hierarchy/outfit/job/ert/hecu
	name = "HECU Trooper"
	head = /obj/item/clothing/head/beret
	mask = /obj/item/clothing/mask/gas/ihs
	glasses = /obj/item/clothing/glasses/hud/security/tacfat
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	r_hand = /obj/item/gun/projectile/automatic/pulse
	belt = /obj/item/storage/belt/tactical/ironhammer
	suit = /obj/item/clothing/suit/storage/vest/merc/black
	backpack_contents = list(/obj/item/grenade/frag = 4, /obj/item/grenade/smokebomb = 2, /obj/item/storage/ration_pack = 1, /obj/item/storage/briefcase/inflatable = 1)
	id = /obj/item/card/id/solcom/peace
	r_pocket = /obj/item/storage/pouch/ammo/cl

/decl/hierarchy/outfit/job/ert/hecu/medic
	name = "HECU Combat Medic"
	head = /obj/item/clothing/head/beret/white
	glasses = /obj/item/clothing/glasses/hud/health/tacfat
	belt = /obj/item/storage/belt/medical/emt/combat
	mask = /obj/item/clothing/mask/gas/ihs
	suit = /obj/item/clothing/suit/storage/vest/merc/black
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	gloves = /obj/item/clothing/gloves/thick
	r_hand = /obj/item/gun/projectile/automatic/pulse
	r_pocket = /obj/item/storage/pouch/ammo/cl
	backpack_contents = list(/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/storage/firstaid/adv = 1, /obj/item/storage/firstaid/combat = 1, /obj/item/clothing/accessory/armband/med = 1, /obj/item/grenade/smokebomb = 2, /obj/item/storage/ration_pack = 1)
	id = /obj/item/card/id/solcom/peace/medic

/decl/hierarchy/outfit/job/ert/hecu/sarge
	name = "HECU Fire Team Lead"
	head = /obj/item/clothing/head/beret/red
	r_ear = /obj/item/device/radio/headset/military/commander
	glasses = /obj/item/clothing/glasses/hud/security/tac
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	r_hand = /obj/item/gun/projectile/automatic/pulse
	suit = /obj/item/clothing/suit/storage/vest/merc/black
	belt = /obj/item/storage/belt/tactical/ironhammer
	r_pocket = /obj/item/storage/pouch/ammo/cl
	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/device/radio/alt2 = 1, /obj/item/storage/briefcase/inflatable = 1, /obj/item/storage/ration_pack = 1, /obj/item/clothing/accessory/armband = 1, /obj/item/storage/pouch/ammo/cl = 1)
	id = /obj/item/card/id/solcom/peace/sarge


/decl/hierarchy/outfit/job/marine

	hierarchy_type = /decl/hierarchy/outfit/job/marine

	uniform = /obj/item/clothing/under/flightsuit/green
	r_ear = /obj/item/device/radio/headset/military
	shoes = /obj/item/clothing/shoes/jackboots/duty
	id = /obj/item/card/id/solcom/marine

/decl/hierarchy/outfit/job/marine/New()
	..()
	BACKPACK_OVERRIDE_SECURITY

/decl/hierarchy/outfit/job/ert/marinecommander
	name = "Solar Marine Sergeant"
	head = /obj/item/clothing/head/beret/red
	r_ear = /obj/item/device/radio/headset/military/commander
	mask = /obj/item/clothing/mask/smokable/cigarette/cigar
	l_hand = /obj/item/flame/lighter/zippo
	r_hand = /obj/item/clipboard
	belt = /obj/item/storage/belt/tactical
	backpack_contents = list(/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/storage/ration_pack = 1, /obj/item/clothing/accessory/armband = 1)
	id = /obj/item/card/id/solcom/marine/sarge

/decl/hierarchy/outfit/job/ert/marine
	name = "Solar Marine"
	r_ear = /obj/item/device/radio/headset/military
	belt = /obj/item/storage/belt/tactical
	head = /obj/item/clothing/head/patrol/marine

/decl/hierarchy/outfit/job/ert/corpsman
	name = "Corpsman"
	head = /obj/item/clothing/head/beret/white
	r_ear = /obj/item/device/radio/headset/military
	glasses = /obj/item/clothing/glasses/hud/health/tacfat
	belt = /obj/item/storage/belt/medical/emt/combat
	backpack_contents = list(/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/storage/firstaid/adv = 1, /obj/item/clothing/accessory/armband/med = 1, /obj/item/storage/ration_pack = 1)
	id = /obj/item/card/id/solcom/marine/corpsman


//Marine QRF
/decl/hierarchy/outfit/job/ert/marinevbss
	name = "Combat - Marine"
	suit = /obj/item/clothing/suit/space/void/SCAF/VBSS/equipped
	uniform = /obj/item/clothing/under/undersuit/trauma
	mask = /obj/item/clothing/mask/breath
	glasses = /obj/item/clothing/glasses/hud/security/tacfat
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	r_hand = /obj/item/gun/projectile/automatic/pulse
	belt = /obj/item/storage/belt/tactical/ironhammer
	r_pocket = /obj/item/storage/pouch/ammo/cl
	backpack_contents = list(/obj/item/storage/briefcase/inflatable = 1, /obj/item/storage/ration_pack = 1, /obj/item/grenade/frag = 4, /obj/item/grenade/smokebomb = 2)
	mask = /obj/item/clothing/mask/balaclava
	id = /obj/item/card/id/solcom/marine

/decl/hierarchy/outfit/job/ert/corpsmanvbss
	name = "Combat - Marine Corpsman"
	suit = /obj/item/clothing/suit/space/void/SCAF/VBSS/equipped
	uniform = /obj/item/clothing/under/undersuit/trauma
	glasses = /obj/item/clothing/glasses/hud/health/tacfat
	belt = /obj/item/storage/belt/medical/emt/combat
	mask = /obj/item/clothing/mask/breath
	r_pocket = /obj/item/storage/pouch/ammo/cl
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	r_hand = /obj/item/gun/projectile/automatic/pulse
	backpack_contents = list(/obj/item/device/lighting/toggleable/flashlight/seclite = 1, /obj/item/storage/firstaid/adv = 1, /obj/item/storage/firstaid/combat = 1, /obj/item/clothing/accessory/armband/med = 1, /obj/item/grenade/smokebomb = 2, /obj/item/storage/ration_pack = 1)
	mask = /obj/item/clothing/mask/balaclava
	id = /obj/item/card/id/solcom/marine/corpsman

/decl/hierarchy/outfit/job/ert/sargevbss
	name = "Combat - Marine Sarge"
	suit = /obj/item/clothing/suit/space/void/SCAF/VBSS/equipped
	r_ear = /obj/item/device/radio/headset/military/commander
	uniform = /obj/item/clothing/under/undersuit/trauma
	glasses = /obj/item/clothing/glasses/hud/security/tac
	l_hand = /obj/item/ammo_magazine/ihclrifle/hv
	r_hand = /obj/item/gun/projectile/automatic/pulse
	belt = /obj/item/storage/belt/tactical/ironhammer
	r_pocket = /obj/item/storage/pouch/ammo/cl
	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/device/radio/alt2 = 1, /obj/item/storage/briefcase/inflatable = 1, /obj/item/storage/ration_pack = 1, /obj/item/clothing/accessory/armband = 1)
	mask = /obj/item/clothing/mask/balaclava
	id = /obj/item/card/id/solcom/marine/sarge
