/datum/category_item/underwear/bottom
	underwear_gender = PLURAL
	underwear_name = "underwear"
	underwear_type = /obj/item/underwear/bottom

/datum/category_item/underwear/bottom/none
	name = "None"
	always_last = TRUE
	underwear_type = null

/datum/category_item/underwear/bottom/boxers
	name = "boxers, black"
	icon_state = "underwear_m_1b"
	underwear_name = "boxers"
	underwear_gender = MALE

/datum/category_item/underwear/bottom/boxers/xl
	is_default = TRUE
	name = "boxers, black XL"
	icon_state = "underwear_m_1bxl"

/datum/category_item/underwear/bottom/briefs
	name = "briefs"
	icon_state = "underwear_m_2w"
	underwear_name = "briefs"

/datum/category_item/underwear/bottom/briefs/xl
	name = "briefs, XL"
	icon_state = "underwear_m_2xl"

/datum/category_item/underwear/bottom/panties
	name = "panties, white"
	icon_state = "underwear_f_1w"
	underwear_name = "panties"

/datum/category_item/underwear/bottom/panties/black
	name = "panties XL, black"
	icon_state = "underwear_f_1b"

/datum/category_item/underwear/bottom/panties/xl
	name = "panties XL, white"
	icon_state = "underwear_f_1wxl"
	underwear_name = "panties"

/datum/category_item/underwear/bottom/panties/xl/black
	name = "panties, black"
	icon_state = "underwear_f_1bxl"
	is_default = TRUE


/datum/category_item/underwear/bottom/briefs/xl/is_default(var/gender)
	return gender != FEMALE

/datum/category_item/underwear/bottom/panties/xl/black/is_default(var/gender)
	return gender == FEMALE
