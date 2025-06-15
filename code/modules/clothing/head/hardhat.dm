/obj/item/clothing/head/hardhat
	name = "hard hat"
	desc = "A piece of headgear used in dangerous working conditions to protect the head. Comes with a built-in flashlight."
	icon_state = "hardhat_yellow"
	action_button_name = "Toggle Headlamp"
	brightness_on = 4 //luminosity when on
	light_overlay = "hardhat_light"
	armor = list(
		melee = 2,
		bullet = 2,
		energy = 2,
		bomb = 50,
		bio = 10,
		rad = 25
	)
	siemens_coefficient = 0.8
	w_class = ITEM_SIZE_NORMAL
	price_tag = 30
	style = STYLE_NEG_LOW
	style_coverage = COVERS_HAIR

/obj/item/clothing/head/hardhat/visor
	name = "visored hard hat"
	desc = "A piece of headgear used in dangerous working conditions to protect the head. Comes with a built-in flashlight and visor, which may protect eyes."
	icon_state = "hardhat_yellow_visor"
	body_parts_covered = HEAD|FACE|EYES
	flags_inv = HIDEEYES

/obj/item/clothing/head/hardhat/blue
	icon_state = "hardhat_blue"

/obj/item/clothing/head/hardhat/orange
	icon_state = "hardhat_orange"

/obj/item/clothing/head/hardhat/red
	name = "firefighter helmet"
	icon_state = "hardhat_red"
	item_flags = STOPPRESSUREDAMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/head/hardhat/white
	icon_state = "hardhat_white"
	item_flags = STOPPRESSUREDAMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/head/deckcrew
	name = "blue deck helmet"
	desc = "A piece of headgear used in aerospace aviation for both deck and craft crews in pressurized areas."
	description_info = "Deck crew colors represent different roles. \
	Blue indicates crew responsible for handling craft movement."
	icon_state = "deck_bl"
	item_state = "deck_bl"
	armor = list(
		melee = 5,
		bullet = 2,
		energy = 5,
		bomb = 50,
		bio = 15,
		rad = 25
	)
	siemens_coefficient = 0.8
	w_class = ITEM_SIZE_NORMAL
	price_tag = 90
	style = STYLE_NEG_LOW
	body_parts_covered = HEAD|FACE|EYES
	flags_inv = HIDEEYES

/obj/item/clothing/head/deckcrew/green
	name = "green deck helmet"
	description_info = "Deck crew colors represent different roles. \
	Green indicates crew responsible for cargo handling, ground support equipment, launch and arrest systems."
	icon_state = "deck_gr"
	item_state = "deck_gr"

/obj/item/clothing/head/deckcrew/brown
	name = "brown deck helmet"
	description_info = "Deck crew colors represent different roles. \
	Brown indicates deck crew leaders."
	icon_state = "deck_br"
	item_state = "deck_br"

/obj/item/clothing/head/deckcrew/white
	name = "white deck helmet"
	description_info = "Deck crew colors represent different roles. \
	White indicates safety and security personnel."
	icon_state = "deck_wh"
	item_state = "deck_wh"

/obj/item/clothing/head/deckcrew/red
	name = "red deck helmet"
	description_info = "Deck crew colors represent different roles. \
	Red indicates ordinance handling and damage control crews."
	icon_state = "deck_rd"
	item_state = "deck_rd"

/obj/item/clothing/head/deckcrew/yellow
	name = "yellow deck helmet"
	description_info = "Deck crew colors represent different roles. \
	Yellow indicates craft handling and loading officers."
	icon_state = "deck_yl"
	item_state = "deck_yl"

/obj/item/clothing/head/deckcrew/violet
	name = "violet deck helmet"
	description_info = "Deck crew colors represent different roles. \
	Violet indicates fuel and volitiles handling crew."
	icon_state = "deck_vi"
	item_state = "deck_vi"

/obj/item/clothing/head/deckcrew/medical
	name = "medical deck helmet"
	desc = "A piece of headgear used in aerospace aviation for medical personnel. Equipped with an integrated HUD system." //TODO: HUD
	icon_state = "deck_med"
	item_state = "deck_med"
