/decl/hierarchy/outfit/job/nt
	hierarchy_type = /decl/hierarchy/outfit/job/nt
	uniform = /obj/item/clothing/under/legacy/greytide
	shoes = /obj/item/clothing/shoes/color/grey
	id_type = /obj/item/card/id/ltgrey

/decl/hierarchy/outfit/job/nt/greytide
	name = OUTFIT_JOB_NAME("Assistant")
	suit = /obj/item/clothing/suit/storage/ass_jacket
	uniform = /obj/item/clothing/under/legacy/greytide
	shoes = /obj/item/clothing/shoes/color/grey
	r_pocket = /obj/item/spacecash/bundle/vagabond

/decl/hierarchy/outfit/job/nt/cargo
	name = OUTFIT_JOB_NAME("Cargo Technician")
	uniform = /obj/item/clothing/under/legacy/cargo
	l_hand = /obj/item/clipboard
	shoes = /obj/item/clothing/shoes/color/grey
	head = /obj/item/clothing/head/soft/yellow
	pda_type = /obj/item/modular_computer/pda/cargo
	gloves = /obj/item/clothing/gloves/fingerless

/decl/hierarchy/outfit/job/nt/janitor
	name = OUTFIT_JOB_NAME("Janitor")
	uniform = /obj/item/clothing/under/legacy/janitor
	shoes = /obj/item/clothing/shoes/color/purple
	pda_type = /obj/item/modular_computer/pda
	r_pocket = /obj/item/device/radio

/decl/hierarchy/outfit/job/nt/cook
	name = OUTFIT_JOB_NAME("Cook")
	uniform = /obj/item/clothing/under/waiter
	head = /obj/item/clothing/head/soft/grey
	id_type = /obj/item/card/id/ltgrey
	pda_type = /obj/item/modular_computer/pda

/decl/hierarchy/outfit/job/nt/botanist
	name = OUTFIT_JOB_NAME("Botanist")
	uniform = /obj/item/clothing/under/legacy/botany
	head = /obj/item/clothing/head/soft/blue
	suit = /obj/item/clothing/suit/apron
	gloves = /obj/item/clothing/gloves/botanic_leather
	r_pocket = /obj/item/device/scanner/plant
	id_type = /obj/item/card/id/ltgrey
	pda_type = /obj/item/modular_computer/pda
	l_pocket = /obj/item/device/radio

/decl/hierarchy/outfit/job/nt/medical
	hierarchy_type = /decl/hierarchy/outfit/job/nt/medical
	shoes = /obj/item/clothing/shoes/color/white
	id_type = /obj/item/card/id/med
	pda_type = /obj/item/modular_computer/pda/moebius/medical
	pda_slot = slot_l_store
	l_ear  = /obj/item/reagent_containers/syringe/large

/decl/hierarchy/outfit/job/nt/medical/New()
	..()
	BACKPACK_OVERRIDE_MEDICAL

/decl/hierarchy/outfit/job/nt/medical/doctor
	name = OUTFIT_JOB_NAME("Medical Doctor")
	uniform = /obj/item/clothing/under/legacy/medical
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/alt
	l_hand = /obj/item/storage/firstaid
	r_pocket = /obj/item/device/lighting/toggleable/flashlight/pen
	belt = /obj/item/storage/belt/medical
	r_pocket = /obj/item/device/radio

/decl/hierarchy/outfit/job/nt/security
	name = OUTFIT_JOB_NAME("Security")
	uniform =/obj/item/clothing/under/rank/security/red
	l_ear = /obj/item/device/radio/headset/headset_sec
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/patrol/sec/red
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	id_type = /obj/item/card/id/sec
	pda_type = /obj/item/modular_computer/pda/security
	backpack_contents = list(/obj/item/handcuffs = 1)

/decl/hierarchy/outfit/job/nt/security/New()
	..()
	BACKPACK_OVERRIDE_SECURITY

/decl/hierarchy/outfit/job/nt/detective
	name = OUTFIT_JOB_NAME("Detective")
	uniform = /obj/item/clothing/under/color/suit/brown
	shoes = /obj/item/clothing/shoes/reinforced
	head = /obj/item/clothing/head/soft/sec/corp
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	id_type = /obj/item/card/id/sec
	pda_type = /obj/item/modular_computer/pda/security
	backpack_contents = list(/obj/item/handcuffs = 1)
	r_pocket = /obj/item/device/radio

/decl/hierarchy/outfit/job/nt/detective/New()
	..()
	BACKPACK_OVERRIDE_SECURITY

/decl/hierarchy/outfit/job/nt/engineer
	name = OUTFIT_JOB_NAME("Engineer")
	uniform = /obj/item/clothing/under/legacy/engineer
	id_type = /obj/item/card/id/engie
	pda_type = /obj/item/modular_computer/pda/engineering
	belt = /obj/item/storage/belt/utility/technomancer
	l_ear = /obj/item/device/radio/headset/headset_eng
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/thick
	pda_slot = slot_l_store
	r_pocket = /obj/item/device/t_scanner
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_EXTENDED_SURVIVAL

/decl/hierarchy/outfit/job/nt/engineering/New()
	..()
	BACKPACK_OVERRIDE_ENGINEERING

/decl/hierarchy/outfit/job/nt/scientist
	name = OUTFIT_JOB_NAME("Scientist")
	uniform = /obj/item/clothing/under/legacy/science
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/alt
	pda_type = /obj/item/modular_computer/pda/moebius/science
	id_type = /obj/item/card/id/sci
	pda_slot = slot_l_store

/decl/hierarchy/outfit/job/nt/science/New()
	..()
	BACKPACK_OVERRIDE_RESEARCH

/decl/hierarchy/outfit/job/nt/clown
	name = OUTFIT_JOB_NAME("Clown")
	uniform = /obj/item/clothing/under/rank/clown
	shoes = /obj/item/clothing/shoes/clown_shoes
	mask = /obj/item/clothing/mask/gas/clown_hat
	suit = /obj/item/clothing/suit/storage/clown
	l_pocket = /obj/item/bikehorn
	backpack_contents = list(/obj/item/bananapeel = 1, /obj/item/storage/fancy/crayons = 1, /obj/item/toy/waterflower = 1, /obj/item/stamp/clown = 1, /obj/item/handcuffs/fake = 1)

/decl/hierarchy/outfit/job/cargo/artist/clown/New()
	..()
	backpack_overrides[/decl/backpack_outfit/backpack] = /obj/item/storage/backpack/clown
	backpack_overrides[/decl/backpack_outfit/satchel] = /obj/item/storage/backpack/satchel/leather

/decl/hierarchy/outfit/job/nt/captain
	name = OUTFIT_JOB_NAME("Captain")
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	uniform = /obj/item/clothing/under/color/suit/blue
	suit = /obj/item/clothing/suit/storage/toggle/bomber
	r_ear = /obj/item/device/radio/headset/heads/captain
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	shoes = /obj/item/clothing/shoes/leather
	id_type = /obj/item/card/id/gold
	pda_type = /obj/item/modular_computer/pda/captain
	backpack_contents = list(/obj/item/storage/box/ids = 1, /obj/item/tool/knife/dagger/ceremonial = 1, /obj/item/clothing/accessory/cross = 1, /obj/item/gun/projectile/avasarala = 1, /obj/item/ammo_magazine/magnum/rubber = 1)

/decl/hierarchy/outfit/job/captain/New()
	..()
	backpack_overrides[/decl/backpack_outfit/backpack]      = /obj/item/storage/backpack/captain
	backpack_overrides[/decl/backpack_outfit/satchel]       = /obj/item/storage/backpack/satchel/captain

/decl/hierarchy/outfit/job/captain/post_equip(var/mob/living/carbon/human/H)
	..()
	if(H.age>49)
		// Since we can have something other than the default uniform at this
		// point, check if we can actually attach the medal
		var/obj/item/clothing/uniform = H.get_equipped_item(slot_w_uniform)
		if(uniform)
			var/obj/item/clothing/accessory/medal/gold/captain/medal = new()
			if(uniform.can_attach_accessory(medal))
				uniform.attach_accessory(null, medal)
			else
				qdel(medal)

/decl/hierarchy/outfit/job/nt/hop
	name = OUTFIT_JOB_NAME("Head of Personnel")
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	uniform = /obj/item/clothing/under/color/suit/red
	l_ear = /obj/item/device/radio/headset/heads/hop
	shoes = /obj/item/clothing/shoes/reinforced
	suit = /obj/item/clothing/suit/storage/toggle/leather
	gloves = /obj/item/clothing/gloves/thick
	head = /obj/item/clothing/head/patrol/black
	id_type = /obj/item/card/id/hop
	pda_type = /obj/item/modular_computer/pda/heads/hop
	backpack_contents = list(/obj/item/storage/box/ids = 1, /obj/item/tool/knife/dagger/ceremonial = 1, /obj/item/clothing/accessory/cross = 1, /obj/item/gun/projectile/avasarala, /obj/item/ammo_magazine/magnum/rubber = 1)
