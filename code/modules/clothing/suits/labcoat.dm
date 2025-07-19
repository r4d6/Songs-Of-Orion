/obj/item/clothing/suit/storage/toggle/labcoat
	name = "labcoat"
	desc = "A suit that protects against minor chemical spills."
	icon_state = "labcoat_open"
	item_state = "labcoat" //Is this even used for anything?
	icon_open = "labcoat_open"
	icon_closed = "labcoat"
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|ARMS
	armor = list(
		melee = 2,
		bullet = 2,
		energy = 2,
		bio = 50,
		bomb = 0,
		bio = 0,
		rad = 0
	)

/obj/item/clothing/suit/storage/toggle/labcoat/cmo
	name = "moebius biolab officer's labcoat"
	desc = "Bluer than the standard model."
	icon_state = "labcoat_cmo_open"
	item_state = "labcoat_cmo"
	icon_open = "labcoat_cmo_open"
	icon_closed = "labcoat_cmo"

/obj/item/clothing/suit/storage/toggle/labcoat/chemist
	name = "moebius chemist labcoat"
	desc = "A suit that protects against minor chemical spills. Has an orange stripe on the shoulder."
	icon_state = "labcoat_chem_open"
	icon_open = "labcoat_chem_open"
	icon_closed = "labcoat_chem"

/obj/item/clothing/suit/storage/toggle/labcoat/bioengineer
	name = "moebius bio-engineer labcoat"
	desc = "A suit that protects against minor chemical spills. Has a red stripe on the shoulder."
	icon_state = "labcoat_vir_open"
	icon_open = "labcoat_vir_open"
	icon_closed = "labcoat_vir"

/obj/item/clothing/suit/storage/toggle/labcoat/virologist
	name = "moebius virologist labcoat"
	desc = "A suit that protects against minor chemical spills. Offers slightly more protection against biohazards than the standard model. Has a green stripe on the shoulder."
	icon_state = "labcoat_vir_open"
	icon_open = "labcoat_vir_open"
	icon_closed = "labcoat_vir"
	armor = list(
		melee = 2,
		bullet = 2,
		energy = 2,
		bomb = 0,
		bio = 75,
		rad = 0
	)

/obj/item/clothing/suit/storage/toggle/labcoat/science
	name = "moebius scientist labcoat"
	desc = "A suit that protects against minor chemical spills. This one is used by scientists."
	icon_state = "labcoat_tox_open"
	icon_open = "labcoat_tox_open"
	icon_closed = "labcoat_tox"

/obj/item/clothing/suit/storage/toggle/labcoat/medspec
	name = "medical specialist's labcoat"
	desc = "A suit that protects against minor chemical spills. This one has marks of Ironhammer Security."
	icon_state = "labcoat_medspec_open"
	item_state = "labcoat_medspec"
	icon_open = "labcoat_medspec_open"
	icon_closed = "labcoat_medspec"

/obj/item/clothing/suit/storage/toggle/labcoat/old
	name = "old labcoat"
	desc = "They don't make them like they used to."
	icon_state = "labcoat_old_open"
	item_state = "labcoat_old"
	icon_open = "labcoat_old_open"
	icon_closed = "labcoat_old"

/obj/item/clothing/suit/storage/toggle/labcoat/alt
	name = "labcoat"
	desc = "They don't make them like they used to."
	icon_state = "labcoat_alt_open"
	item_state = "labcoat_alt"
	icon_open = "labcoat_alt_open"
	icon_closed = "labcoat_alt"

/obj/item/clothing/suit/storage/toggle/labcoat/syndicate
	name = "Syndicate labcoat"
	desc = "Dark and edgy labcoat to hide those oil stains."
	icon_state = "labcoat_syndicate_open"
	item_state = "labcoat_syndicate"
	icon_open = "labcoat_syndicate_open"
	icon_closed = "labcoat_syndicate"

/obj/item/clothing/suit/storage/toggle/labcoat/hro
	name = "Human Resource Officer's labcoat"
	desc = "Better than the standard model."
	icon_state = "HRO_open"
	item_state = "HRO"
	icon_open = "HRO_open"
	icon_closed = "HRO"
	armor = list(
		melee = 2,
		bullet = 5,
		energy = 10,
		bomb = 10,
		bio = 75,
		rad = 20
	)
