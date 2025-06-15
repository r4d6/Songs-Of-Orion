/obj/item/clothing/glasses/hud
	name = "HUD"
	desc = "A heads-up display that provides important info in (almost) real time."
	flags = 0 //doesn't protect eyes because it's a monocle, duh
	prescription = TRUE
	origin_tech = list(TECH_MAGNET = 3, TECH_BIO = 2)
	matter = list(MATERIAL_PLASTIC = 1, MATERIAL_GLASS = 1, MATERIAL_SILVER = 0.5)
	price_tag = 200
	bad_type = /obj/item/clothing/glasses/hud
	var/list/icon/current = list() //the current hud icons
	var/malfunctioning = FALSE

/obj/item/clothing/glasses/hud/proc/repair_self()
	malfunctioning = FALSE

/obj/item/clothing/glasses/hud/process_hud(mob/M)
	if(malfunctioning)
		process_broken_hud(M, 1)
		return TRUE

/obj/item/clothing/glasses/hud/emp_act(severity)
	. = ..()
	malfunctioning = TRUE
	var/timer
	switch(severity)
		if(1)
			timer = 1 MINUTES
		if(2)
			timer = 3 MINUTES
	addtimer(CALLBACK(src, PROC_REF(repair_self)), timer)

/obj/item/clothing/glasses/hud/health
	name = "Health Scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status."
	icon_state = "medhud_med"
	body_parts_covered = 0


/obj/item/clothing/glasses/hud/health/process_hud(mob/M)
	if(..())
		return
	process_med_hud(M, 1)

/obj/item/clothing/glasses/sunglasses/medhud
	name = "polarized medical HUD"
	desc = "Goggles with inbuilt medical information. They provide minor flash resistance."
	icon_state = "sunhud"
	prescription = TRUE

	New()
		..()
		src.hud = new/obj/item/clothing/glasses/hud/health(src)
		return

/obj/item/clothing/glasses/hud/health/prescription
	name = "perscription medical HUD"
	desc = "Perscription glasses with smartglass displaying medical information."
	icon_state = "glasses"
	prescription = TRUE


/obj/item/clothing/glasses/hud/security
	name = "Security HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status and security records."
	icon_state = "medhud_sec"
	item_state = "medhud_sec"
	body_parts_covered = 0
	var/global/list/jobs[0]

/obj/item/clothing/glasses/hud/security/jensenshades
	name = "Augmented shades"
	desc = "Polarized bioneural eyewear, designed to augment your vision."
	icon_state = "jensenshades"
	item_state = "jensenshades"
	vision_flags = SEE_MOBS
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	spawn_blacklisted = TRUE

/obj/item/clothing/glasses/hud/security/process_hud(mob/M)
	if(..())
		return
	process_sec_hud(M, 1)

/obj/item/clothing/glasses/sunglasses/sechud
	name = "HUDSunglasses"
	desc = "Sunglasses with a HUD."
	icon_state = "sunhud"
	prescription = TRUE

	New()
		..()
		src.hud = new/obj/item/clothing/glasses/hud/security(src)
		return

/obj/item/clothing/glasses/sunglasses/sechud/tactical
	name = "tactical HUD"
	desc = "Goggles with inbuilt combat and security information. They provide minor flash resistance."
	icon_state = "goggles"

/obj/item/clothing/glasses/hud/broken
	spawn_blacklisted = TRUE //To stop the broken huds form spawning i.g - Messes with loot spawns for a broken item

/obj/item/clothing/glasses/hud/broken/process_hud(mob/M)
	process_broken_hud(M, 1)


/obj/item/clothing/glasses/hud/excelsior
	name = "Excelsior HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their opinion on communism."
	icon_state = "medhud_red"
	item_state = "medhud_red"
	body_parts_covered = 0
	spawn_blacklisted = TRUE

/obj/item/clothing/glasses/hud/excelsior/process_hud(mob/M)
	if(..())
		return
	if(is_excelsior(M))
		process_excel_hud(M)

/obj/item/clothing/glasses/hud/excelsior/equipped(mob/M)
	. = ..()

	var/mob/living/carbon/human/H = M
	if(!istype(H) || H.glasses != src)
		return

	if(!is_excelsior(H))
		to_chat(H, SPAN_WARNING("The hud fails to activate, a built-in speaker says, \"Failed to locate implant, please contact your nearest Excelsior representative immediately for assistance\"."))

/obj/item/clothing/glasses/hud/excelsior/stealth
	name = "Prescription Glasses"
	desc = "Made by Nerd. Co."
	description_antag = "Advanced smart glasses can detect Marx-Kampf liberated fellow travelers."
	icon_state = "glasses"
	prescription = TRUE

//////
//HUD flavors
//////

///////////
///SLIM///
/////////
/obj/item/clothing/glasses/hud/health/slim
	name = "slim medical HUD"
	desc = "A sleek HUD displaying medical information."
	icon_state = "hud_med"
	item_state = "hud_med"

/obj/item/clothing/glasses/hud/security/slim
	name = "slim security HUD"
	desc = "A sleek HUD displaying security information."
	icon_state = "hud_sec"
	item_state = "hud_sec"

/obj/item/clothing/glasses/hud/excelsior/slim
	name = "slim commie HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their opinion on communism."
	icon_state = "hud_red"
	item_state = "hud_red"

///////////
///FAT////
/////////
/obj/item/clothing/glasses/hud/health/big
	name = "advanced medical HUD"
	desc = "A sleek HUD displaying medical information. Corrects for vision impairments."
	icon_state = "bighud_med"
	item_state = "bighud_med"
	prescription = TRUE

/obj/item/clothing/glasses/hud/security/big
	name = "advanced security HUD"
	desc = "A sleek HUD displaying security information. Corrects for vision impairments."
	icon_state = "bighud_sec"
	item_state = "bighud_sec"
	prescription = TRUE

/obj/item/clothing/glasses/hud/excelsior/big
	name = "advanced commie HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their opinion on communism."
	icon_state = "bighud_red"
	item_state = "bighud_red"
	prescription = TRUE

///////////
///TAC////
/////////

/obj/item/clothing/glasses/hud/health/tac
	name = "tactical medical HUD"
	desc = "A robust HUD displaying medical information."
	icon_state = "slim_med"
	item_state = "slim_med"

/obj/item/clothing/glasses/hud/security/tac
	name = "tactical security HUD"
	desc = "A robust HUD displaying security information."
	icon_state = "slim_sec"
	item_state = "slim_sec"

/obj/item/clothing/glasses/hud/excelsior/tac
	name = "tactical commie HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their opinion on communism."
	icon_state = "slim_red"
	item_state = "slim_red"

///////////
///FAT-TAC
/////////

/obj/item/clothing/glasses/hud/health/tacfat
	name = "battlefield medical HUD"
	desc = "A robust HUD displaying medical information."
	icon_state = "tachud_med"
	item_state = "tachud_med"

/obj/item/clothing/glasses/hud/security/tacfat
	name = "battlefield security HUD"
	desc = "A robust HUD displaying security information."
	icon_state = "tachud_sec"
	item_state = "tachud_sec"

/obj/item/clothing/glasses/hud/excelsior/tacfat
	name = "battlefield commie HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their opinion on communism."
	icon_state = "tachud_red"
	item_state = "tachud_red"

