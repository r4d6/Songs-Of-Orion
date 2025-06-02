/datum/species/human
	name = SPECIES_HUMAN
	name_plural = "Humans"
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/punch, /datum/unarmed_attack/bite)
	blurb = "Humanity originated in the Sol system, and over the last five centuries has spread \
	colonies across a wide swathe of space. They hold a wide range of forms and creeds.<br/><br/> \
	While the central Sol government maintains control of its far-flung people, powerful corporate \
	interests, rampant cyber and bio-augmentation and secretive factions make life on most human \
	worlds tumultous at best."
	num_alternate_languages = 2
	name_language = null // Use the first-name last-name generator rather than a language scrambler
	min_age = 17
	max_age = 110
	remains_type = /obj/item/remains/human

	spawn_flags = CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_SKIN_TONE | HAS_LIPS | HAS_UNDERWEAR | HAS_EYE_COLOR

/datum/species/human/get_bodytype()
	return SPECIES_HUMAN

/datum/species/human/solar
	name = SPECIES_HUMAN_SOLAR
	name_plural = "Solar Humans"
	icobase = 'icons/mob/human_races/solar/r_human.dmi'
	deform = 'icons/mob/human_races/r_def_human.dmi'
	damage_overlays = 'icons/mob/human_races/solar/dam_human.dmi'
	damage_mask = 'icons/mob/human_races/solar/dam_mask_human.dmi'
	blood_mask = 'icons/mob/human_races/solar/blood_human.dmi'
	perks = list(PERK_SOLAR)

/datum/species/human/exile
	name = SPECIES_HUMAN_EXILE
	name_plural = "Human Exiles"
	icobase = 'icons/mob/human_races/exile/r_exile.dmi'
	deform = 'icons/mob/human_races/r_def_human.dmi'
	damage_overlays = 'icons/mob/human_races/exile/dam_exile.dmi'
	damage_mask = 'icons/mob/human_races/exile/dam_mask_exile.dmi'
	blood_mask = 'icons/mob/human_races/exile/blood_exile.dmi'
	perks = list(PERK_EXILE)
