/datum/category_item/underwear/top
	underwear_name = "bra"
	underwear_type = /obj/item/underwear/top
	underwear_gender = FEMALE

/datum/category_item/underwear/top/none
	name = "None"
	always_last = TRUE
	underwear_type = null
	underwear_gender = MALE

/datum/category_item/underwear/top/bra
	name = "bra, white"
	icon_state = "top_2w"

/datum/category_item/underwear/top/bra/black
	name = "bra, black"
	icon_state = "top_2b"

/datum/category_item/underwear/top/xl
	name = "bra XL, white"
	icon_state = "top_1wxl"

/datum/category_item/underwear/top/xl/black
	is_default = TRUE
	name = "bra XL, black"
	icon_state = "top_1bxl"

/datum/category_item/underwear/top/none/is_default(var/gender)
	return gender != FEMALE

/datum/category_item/underwear/top/bra/black/is_default(var/gender)
	return gender == FEMALE
