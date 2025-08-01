/*
 * Contains:
 *		Fire protection
 *		Bomb protection
 *		Radiation protection
 */

/*
 * Fire protection
 */
/obj/item/clothing/suit/fire
	name = "firesuit"
	desc = "A suit that protects against fire and heat."
	icon_state = "fire"
	item_state = "fire"
	w_class = ITEM_SIZE_BULKY
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	style_coverage = COVERS_WHOLE_TORSO_AND_LIMBS
	extra_allowed = list(/obj/item/extinguisher)
	armor = list(
		melee = 2,
		bullet = 0,
		energy = 0,
		bomb = 10,
		bio = 10,
		rad = 0
	)
	slowdown = 0.2
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL
	item_flags = STOPPRESSUREDAMAGE | COVER_PREVENT_MANIPULATION
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	price_tag = 50
	style = STYLE_NEG_LOW


/*
 * Radiation protection
 */
/obj/item/clothing/head/radiation
	name = "radiation hood"
	icon_state = "radiation"
	desc = "A hood with radiation protective properties."
	flags_inv = BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES
	style_coverage = COVERS_HAIR|COVERS_EARS
	armor = list(
		melee = 0,
		bullet = 0,
		energy = 10,
		bomb = 5,
		bio = 90,
		rad = 100
	)
	price_tag = 50
	style = STYLE_NEG_LOW


/obj/item/clothing/suit/radiation
	name = "radiation suit"
	desc = "A suit that protects against radiation."
	icon_state = "radiation"
	item_state = "radiation"
	w_class = ITEM_SIZE_BULKY
	spawn_tags = SPAWN_TAG_HAZMATSUIT
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	style_coverage = COVERS_WHOLE_TORSO_AND_LIMBS
	extra_allowed = list(/obj/item/clothing/head/radiation)
	slowdown = 0.2
	armor = list(
		melee = 0,
		bullet = 0,
		energy = 7,
		bomb = 5,
		bio = 90,
		rad = 100
	)
	flags_inv = HIDEJUMPSUIT|HIDETAIL
	price_tag = 500
	style = STYLE_NEG_LOW
