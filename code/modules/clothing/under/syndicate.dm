//Repurposed for the Freight Syndicate :)

/obj/item/clothing/under/rank/cargotech
	name = "Syndicate logistics uniform"
	desc = "A set of overalls issued to low level Syndicate agents. Suit sensors cannot be disabled."
	icon_state = "syndicate"
	item_state = "lb_suit"
	has_sensor = 2
	sensor_mode = 3

/obj/item/clothing/under/syndicate
	name = "Syndicate turtleneck"
	desc = "The leader of hackers and theives, with the crisp facade of an officer."
	icon_state = "syndicate_officer"
	item_state = "bl_suit"
	siemens_coefficient = 0.8
	has_sensor = 0
	price_tag = 500
	spawn_blacklisted = TRUE
	has_sensor = 1
	sensor_mode = 3

/obj/item/clothing/under/syndicate/skirt
	name = "Syndicate turtleneck"
	desc = "The leader of hackers and theives, with the crisp facade of an officer, now without pants."
	icon_state = "officer_skirt"
	item_state = "bl_suit"

/obj/item/clothing/under/frog/cargo
	name = "syndicate tactical suit"
	desc = "Flame Resistant Organizational Gear. A bit much for deliveries, no?"
	icon_state = "frog_syndicate"
	item_state = "frog_syndicate"

/obj/item/clothing/under/flightsuit/cargo
	name = "syndicate flightsuit"
	desc = "A simple flightsuit for spatial delivery operations, specifically compatible with LifeVest technology."
	icon_state = "flight_syndicate"
	item_state = "flight_syndicate"
	armor = list(
		melee = 5,
		bullet = 0,
		energy = 5,
		bomb = 0,
		bio = 0,
		rad = 10
	)
