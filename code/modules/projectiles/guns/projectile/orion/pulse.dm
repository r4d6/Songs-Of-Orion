/obj/item/gun/projectile/automatic/pulse
	name = "pulse rifle"
	desc = "A boxy caseless longarm used by security forces."
	description_antag = "A caseless air-cooled pulse action automatic rifle. \
						The \"G22\" is a boxy mass of glass reinforced plastics and plasteel common around the galaxy. Warranty void if action is opened."
	icon = 'modular/guns/icons/g22.dmi'
	icon_state = "g22"
	item_state = "g22"
	w_class = ITEM_SIZE_BULKY
	ammo_mag = "ih_sol"
	load_method = MAGAZINE
	mag_well = MAG_WELL_IH
	caliber = CAL_CLRIFLE
	magazine_type = /obj/item/ammo_magazine/ihclrifle
	auto_eject = 1
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	slot_flags = SLOT_BELT
	matter = list(MATERIAL_PLASTEEL = 16, MATERIAL_PLASTIC = 12)
	price_tag = 2300
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'
	init_recoil = CARBINE_RECOIL(1)
	penetration_multiplier = 0
	damage_multiplier = 1.1
	gun_parts = list(/obj/item/part/gun = 2 ,/obj/item/stack/material/plasteel = 6)
	zoom_factors = list(0.6)

	init_firemodes = list(
		FULL_AUTO_300,
		SEMI_AUTO_300,
		list(mode_name="pulse", mode_desc = "3-round pulse", burst=3,    burst_delay=0.3, move_delay=1,  icon="burst"),
		)

	spawn_tags = SPAWN_TAG_FS_PROJECTILE
	gun_parts = list(/obj/item/part/gun/frame/g22 = 1, /obj/item/part/gun/modular/grip/rubber = 1, /obj/item/part/gun/modular/mechanism/smg = 1, /obj/item/part/gun/modular/barrel/clrifle = 1)


/obj/item/gun/projectile/automatic/pulse/update_icon()
	..()

	icon_state = initial(icon_state) + (ammo_magazine ? "-full" : "")
	set_item_state(ammo_magazine ? "_mag" : "", hands = TRUE, back = TRUE, onsuit = TRUE)
	cut_overlays()
	update_wear_icon()


/obj/item/part/gun/frame/g22
	name = "G22 frame"
	desc = "A common pulse rifle frame."
	icon_state = "frame_ihbullpup"
	resultvars = list(/obj/item/gun/projectile/automatic/pulse)
	gripvars = list(/obj/item/part/gun/modular/grip/rubber)
	mechanismvar = /obj/item/part/gun/modular/mechanism/smg // guh?? ok you do you
	barrelvars = list(/obj/item/part/gun/modular/barrel/clrifle)
