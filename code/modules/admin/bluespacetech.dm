/*
// Bluespace Technician is a godmode avatar designed for debugging and admin actions
// Their primary benefit is the ability to spawn in wherever you are, making it quick to get a human for your needs
// They also have incorporeal flying movement if they choose, which is often the fastest way to get somewhere specific
// They are mostly invincible, although godmode is a bit imperfect.
// Most of their superhuman qualities can be toggled off if you need a normal human for testing biological functions
*/
/client/proc/cmd_dev_bst()
	set category = "Debug"
	set name = "Spawn Bluespace Tech"
	set desc = "Spawns a Bluespace Tech to debug stuff"


	if(!check_rights(R_ADMIN|R_DEBUG))
		return

	if(istype(usr, /mob/living/carbon/human/bst))
		to_chat(usr, SPAN_NOTICE("You need to despawn your BST first before spawning another.")) //so if we accidentally double-click the button it won't spawn us twice
		return

	var/T = get_turf(usr)
	var/mob/living/carbon/human/bst/bst = new(T)
	bst.anchored = TRUE
	bst.ckey = usr.ckey
	bst.name = "Stagehand"
	bst.real_name = "Stagehand"
	bst.voice_name = "Stagehand"
	bst.h_style = "Crewcut"
	var/list/stat_modifiers = list(
		STAT_ROB = 99,
		STAT_TGH = 99,
		STAT_BIO = 99,
		STAT_MEC = 99,
		STAT_VIG = 99,
		STAT_COG = 99
	)
	for(var/stat in stat_modifiers)
		bst.stats.changeStat(stat, stat_modifiers[stat])

	//Items
	bst.equip_to_slot_or_del(new /obj/item/clothing/under/bst(bst), slot_w_uniform)
	bst.equip_to_slot_or_del(new /obj/item/device/radio/headset/ert/bst(bst), slot_l_ear)
	bst.equip_to_slot_or_del(new /obj/item/storage/backpack/holding/bst(bst), slot_back)
	bst.equip_to_slot_or_del(new /obj/item/storage/box/survival(bst.back), slot_in_backpack)
	bst.equip_to_slot_or_del(new /obj/item/clothing/shoes/color/black/bst(bst), slot_shoes)
	bst.equip_to_slot_or_del(new /obj/item/clothing/head/soft/yellow/bst(bst), slot_head)
	bst.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/bst(bst), slot_glasses)
	bst.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full/bst(bst), slot_belt)
	bst.equip_to_slot_or_del(new /obj/item/clothing/gloves/bst(bst), slot_gloves)
	bst.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/harness(bst), slot_wear_suit)
	bst.equip_to_slot_or_del(new /obj/item/storage/box/ids(bst.back), slot_in_backpack)
	bst.equip_to_slot_or_del(new /obj/item/device/t_scanner(bst.back), slot_in_backpack)
	bst.equip_to_slot_or_del(new /obj/item/modular_computer/pda/captain(bst.back), slot_in_backpack)

	var/obj/item/storage/box/pills = new /obj/item/storage/box(null, TRUE)
	pills.name = "adminordrazine"
	for(var/i = 1, i < 12, i++)
		new /obj/item/reagent_containers/pill/adminordrazine(pills)
	bst.equip_to_slot_or_del(pills, slot_in_backpack)



	//Sort out ID
	var/obj/item/card/id/bst/id = new/obj/item/card/id/bst(bst)
	id.registered_name = bst.real_name
	id.assignment = "Stagehand"
	id.name = "[id.assignment]"
	bst.equip_to_slot_or_del(id, slot_wear_id)
	bst.update_inv_wear_id()
	bst.regenerate_icons()

	//Add the rest of the languages
	bst.add_language(LANGUAGE_COMMON)
	bst.add_language(LANGUAGE_CYRILLIC)
	bst.add_language(LANGUAGE_SERBIAN)
	bst.add_language(LANGUAGE_MONKEY)
	bst.add_language(LANGUAGE_JIVE)
	bst.add_language(LANGUAGE_GERMAN)
	bst.add_language(LANGUAGE_NEOHONGO)
	bst.add_language(LANGUAGE_LATIN)
	// Robot languages
	bst.add_language(LANGUAGE_ROBOT)
	bst.add_language(LANGUAGE_DRONE)
	// Antagonist languages
	bst.add_language(LANGUAGE_HIVEMIND)
	bst.add_language(LANGUAGE_CORTICAL)
	bst.add_language(LANGUAGE_CULT)
	bst.add_language(LANGUAGE_OCCULT)
	bst.add_language(LANGUAGE_BLITZ)

	spawn(10)
		bst_post_spawn(bst)

	log_admin("Bluespace Tech Spawned: X:[bst.x] Y:[bst.y] Z:[bst.z] User:[src]")
	init_verbs()
	return 1

/client/proc/bst_post_spawn(mob/living/carbon/human/bst/bst)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(5, 1, src)
	s.start()

	bst.anchored = FALSE

/mob/living/carbon/human/bst
	universal_understand = TRUE
	status_flags = GODMODE
	var/fall_override = TRUE
	var/mob/original_body

/mob/living/carbon/human/bst/can_inject(mob/user, error_msg, target_zone)
	to_chat(user, span("alert", "The [src] disarms you before you can inject them."))
	user.drop_item()
	return FALSE

/mob/living/carbon/human/bst/binarycheck()
	return TRUE

/mob/living/carbon/human/bst/proc/suicide()

	src.custom_emote(1,"gives a polite wave and steps backstage.")
	qdel(src)

/*
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(5, 1, src)
	s.start()
	spawn(10)
*/

	if(key)
		var/mob/observer/ghost/ghost = ghostize(TRUE)
		ghost.name = "[ghost.key] Stagehand"
		ghost.real_name = "[ghost.key] Stagehand"
		ghost.voice_name = "[ghost.key] Stagehand"
		ghost.admin_ghosted = TRUE

/mob/living/carbon/human/bst/verb/antigrav()
	set name = "Toggle Gravity"
	set desc = "Toggles on/off falling for you."
	set category = "BST"

	if (fall_override)
		fall_override = FALSE
		to_chat(src, SPAN_NOTICE("You will now fall normally."))
	else
		fall_override = TRUE
		to_chat(src, SPAN_NOTICE("You will no longer fall."))

/mob/living/carbon/human/bst/verb/bstwalk()
	set name = "Ruin Everything"
	set desc = "Uses bluespace technology to phase through solid matter and move quickly."
	set category = "BST"
	set popup_menu = 0

	if(!HasMovementHandler(/datum/movement_handler/mob/incorporeal))
		to_chat(src, SPAN_NOTICE("You will now phase through solid matter."))
		incorporeal_move = TRUE
		ReplaceMovementHandler(/datum/movement_handler/mob/incorporeal)
	else
		to_chat(src, SPAN_NOTICE("You will no-longer phase through solid matter."))
		incorporeal_move = FALSE
		RemoveMovementHandler(/datum/movement_handler/mob/incorporeal)

/mob/living/carbon/human/bst/verb/bstrecover()
	set name = "Rejuv"
	set desc = "Use the bluespace within you to restore your health"
	set category = "BST"
	set popup_menu = FALSE

	src.revive()

/mob/living/carbon/human/bst/verb/bstawake()
	set name = "Wake up"
	set desc = "This is a quick fix to the relogging sleep bug"
	set category = "BST"
	set popup_menu = FALSE

	src.sleeping = FALSE

/mob/living/carbon/human/bst/verb/bstquit()
	set name = "Teleport out"
	set desc = "Activate bluespace to leave and return to your original mob (if you have one)."
	set category = "BST"

	src.suicide()

/mob/living/carbon/human/bst/verb/tgm()
	set name = "Toggle Godmode"
	set desc = "Enable or disable god mode. For testing things that require you to be vulnerable."
	set category = "BST"

	status_flags ^= GODMODE
	to_chat(src, SPAN_NOTICE("God mode is now [status_flags & GODMODE ? "enabled" : "disabled"]"))

	to_chat(src, span("notice", "God mode is now [status_flags & GODMODE ? "enabled" : "disabled"]"))


///////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////I T E M S/////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

/obj/item/storage/backpack/holding/bst
	worn_access = TRUE
	spawn_frequency = 0
	icon_state = "satchel"

/obj/item/device/radio/headset/ert/bst
	name = "stagehand headset"
	desc = "A stagehand's headset. The word 'STAFF' is stamped on the side."
	translate_binary = TRUE
	translate_hive = TRUE
	keyslot1 = new /obj/item/device/encryptionkey/binary
	spawn_frequency = 0

/obj/item/device/radio/headset/ert/bst/attack_hand()
	if(!usr)
		return
	if(!isbst(usr))
		to_chat(usr, span("alert", "Your hand seems to go right through the [src]. It's like it doesn't exist."))
		return
	else
		..()

/obj/item/device/radio/headset/ert/bst/recalculateChannels(var/setDescription = FALSE)
	..(setDescription)
	translate_binary = TRUE
	translate_hive = TRUE


/obj/item/clothing/under/bst
	name = "Staff uniform"
	desc = "A stagehand uniform. Has writing on the sleeves reading 'STAFF'."
	icon_state = "tee_black"
	item_state = "tee_black"
	body_parts_covered = FULL_BODY
	cold_protection = FULL_BODY
	heat_protection = FULL_BODY
	min_cold_protection_temperature = T0C - 400
	max_heat_protection_temperature = 10000
	siemens_coefficient = 0.1
	permeability_coefficient = 0.50
	armor = list(
		melee = 20,
		bullet = 20,
		energy = 20,
		bomb = 100,
		bio = 100,
		rad = 100
	)
	spawn_frequency = 0
	sensor_mode = 0
	siemens_coefficient = 0
	has_sensor = FALSE

/obj/item/clothing/under/bst/attack_hand()
	if(!usr)
		return
	if(!isbst(usr))
		to_chat(usr, span("alert", "Your hand seems to go right through the [src]. It's like it doesn't exist."))
		return
	else
		..()

/obj/item/clothing/head/soft/yellow/bst
	name = "STAFF cap"
	initial_name = "STAFF cap"
	desc = "A baseball cap worn by stagehands and behind the scene staff."
	siemens_coefficient = 0
	permeability_coefficient = 0
	spawn_frequency = 0

/obj/item/clothing/head/soft/yellow/bst/attack_hand()
	if(!usr)
		return
	if(!isbst(usr))
		to_chat(usr, span("alert", "Your hand seems to go right through the [src]. It's like it doesn't exist."))
		return
	else
		..()

/obj/item/clothing/gloves/bst
	name = "stagehand's gloves"
	desc = "A pair of modified gloves. The word 'STAFF' is printed on the wrists."
	icon_state = "yellow"
	item_state = "yellow"
	siemens_coefficient = 0
	permeability_coefficient = 0
	spawn_frequency = 0

/obj/item/clothing/gloves/bst/attack_hand()
	if(!usr)
		return
	if(!isbst(usr))
		to_chat(usr, span("alert", "Your hand seems to go right through the [src]. It's like it doesn't exist."))
		return
	else
		..()

/obj/item/clothing/glasses/sunglasses/bst
	name = "stagehand's glasses"
	desc = "A pair of safety glasses, marked as studio property."
	vision_flags = (SEE_TURFS|SEE_OBJS|SEE_MOBS)
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	flash_protection = FLASH_PROTECTION_MAJOR
	spawn_frequency = 0

/obj/item/clothing/glasses/sunglasses/bst/verb/toggle_xray(mode in list("X-Ray without Lighting", "X-Ray with Lighting", "Normal"))
	set name = "Change Vision Mode"
	set desc = "Changes your glasses' vision mode."
	set category = "BST"
	set src in usr

	switch (mode)
		if ("X-Ray without Lighting")
			vision_flags = (SEE_TURFS|SEE_OBJS|SEE_MOBS)
			see_invisible = SEE_INVISIBLE_NOLIGHTING
		if ("X-Ray with Lighting")
			vision_flags = (SEE_TURFS|SEE_OBJS|SEE_MOBS)
			see_invisible = -1
		if ("Normal")
			vision_flags = FALSE
			see_invisible = -1

	to_chat(usr, "<span class='notice'>\The [src]'s vision mode is now <b>[mode]</b>.</span>")

/obj/item/clothing/glasses/sunglasses/bst/attack_hand()
	if(!usr)
		return
	if(!isbst(usr))
		to_chat(usr, span("alert", "Your hand seems to go right through the [src]. It's like it doesn't exist."))
		return
	else
		..()

/obj/item/clothing/shoes/color/black/bst
	name = "stagehand's shoes"
	desc = "A pair of black shoes with extra grip. The word 'STAFF' is stamped on the side."
	icon_state = "shoes_bk"
	item_flags = NOSLIP
	spawn_frequency = 0

/obj/item/clothing/shoes/color/black/bst/attack_hand()
	if(!usr)
		return
	if(!isbst(usr))
		to_chat(usr, span("alert", "Your hand seems to go right through the [src]. It's like it doesn't exist."))
		return
	else
		..()

	return TRUE //Because Bluespace

/obj/item/card/id/bst
	icon_state = "centcom"
	desc = "A stagehand ID, worn by the grips and staff behind the scenes."
	spawn_frequency = 0

/obj/item/card/id/bst/Initialize(mapload)
	. = ..()
	access = get_all_accesses()+get_all_centcom_access()+get_all_syndicate_access()

/obj/item/card/id/bst/attack_hand()
	if(!usr)
		return
	if(!isbst(usr))
		to_chat(usr, span("alert", "Your hand seems to go right through the [src]. It's like it doesn't exist."))
		return
	else
		..()

/obj/item/storage/belt/utility/full/bst
	storage_slots = 14
	spawn_frequency = 0

/obj/item/storage/belt/utility/full/bst/populate_contents()
	..()
	new /obj/item/tool/multitool(src)
	new /obj/item/device/t_scanner(src)

/mob/living/carbon/human/bst/restrained()
	return !(status_flags & GODMODE)


/mob/living/carbon/human/bst/can_fall()
	return fall_override ? FALSE : ..()


/mob/living/carbon/human/bst/verb/moveup()
	set name = "Phase Upwards"
	set category = "BST"
	zMove(UP)

/mob/living/carbon/human/bst/verb/movedown()
	set name = "Phase Downwards"
	set category = "BST"
	zMove(DOWN)
