/decl/hierarchy/outfit/job/cargo
	l_ear = /obj/item/device/radio/headset/headset_cargo
	hierarchy_type = /decl/hierarchy/outfit/job/cargo

/decl/hierarchy/outfit/job/cargo/merchant
	name = OUTFIT_JOB_NAME("Syndicate Logistics Officer")
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/reinforced
	glasses = /obj/item/clothing/glasses/sunglasses
	suit = /obj/item/clothing/suit/storage/syndicate/officer
	l_hand = /obj/item/clipboard
	id_type = /obj/item/card/id/car
	pda_type = /obj/item/modular_computer/pda/cargo
	l_ear = /obj/item/device/radio/headset/heads/merchant
	backpack_contents = list(/obj/item/gun/projectile/olivaw = 1, /obj/item/ammo_magazine/pistol/rubber = 2)

/decl/hierarchy/outfit/job/cargo/cargo_tech
	name = OUTFIT_JOB_NAME("Syndicate Technician")
	uniform = /obj/item/clothing/under/rank/cargotech
	l_hand = /obj/item/clipboard
	shoes = /obj/item/clothing/shoes/color/black
	head = /obj/item/clothing/head/soft/synd
	pda_type = /obj/item/modular_computer/pda/cargo
	gloves = /obj/item/clothing/gloves/fingerless

/decl/hierarchy/outfit/job/cargo/artist/clown
	name = OUTFIT_JOB_NAME("Clown")
	uniform = /obj/item/clothing/under/rank/clown
	shoes = /obj/item/clothing/shoes/clown_shoes
	mask = /obj/item/clothing/mask/gas/clown_hat
	l_pocket = /obj/item/bikehorn
	backpack_contents = list(/obj/item/bananapeel = 1, /obj/item/storage/fancy/crayons = 1, /obj/item/toy/waterflower = 1, /obj/item/stamp/clown = 1, /obj/item/handcuffs/fake = 1)

/decl/hierarchy/outfit/job/cargo/artist/clown/New()
	..()
	backpack_overrides[/decl/backpack_outfit/backpack] = /obj/item/storage/backpack/clown
	backpack_overrides[/decl/backpack_outfit/satchel] = /obj/item/storage/backpack/satchel/leather


///decl/hierarchy/outfit/job/cargo/artist/clown/post_equip(var/mob/living/carbon/human/H)
//	..()
//	H.mutations.Add(CLUMSY)

/decl/hierarchy/outfit/job/cargo/hacker
	name = OUTFIT_JOB_NAME("Syndicate Hacker")
	uniform = /obj/item/clothing/under/rank/hacker
	l_hand = /obj/item/clipboard
	shoes = /obj/item/clothing/shoes/color/black
	head = /obj/item/clothing/head/soft/synd
	pda_type = /obj/item/modular_computer/pda/cargo
