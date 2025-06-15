//Contains: Engineering department jumpsuits
/obj/item/clothing/under/rank/exultant
	name = "Formxn suit"
	desc = "The leader of welders and drunks. This outfit is more suited to paperwork, howerver."
	icon_state = "ce"
	item_state = "ce"
	has_sensor = 1
	sensor_mode = 3
	armor = list(
		melee = 5,
		bullet = 0,
		energy = 0,
		bomb = 10,
		bio = 10,
		rad = 15
	)
	spawn_blacklisted = TRUE

/obj/item/clothing/under/rank/engineer
	name = "engineering turnouts"
	desc = "Heavy utility turnouts with a worn T-shirt and suspenders."
	icon_state = "engineer"
	item_state = "engineer"
	armor = list(
		melee = 5,
		bullet = 0,
		energy = 0,
		bomb = 10,
		bio = 10,
		rad = 15
	)

/obj/item/clothing/under/flightsuit/engineer
	name = "engineering flightsuit"
	desc = "A flight engineer\'s suit, if you will."
	icon_state = "flight_engineer"
	item_state = "flight_engineer"
	armor = list(
		melee = 5,
		bullet = 0,
		energy = 5,
		bomb = 0,
		bio = 0,
		rad = 10
	)

/obj/item/clothing/under/frog/engineer
	name = "tactical engineering suit"
	desc = "Flame Resistant Organizational Gear. A bit much for repairs, no?"
	icon_state = "frog_engineer"
	item_state = "frog_engineer"
	armor = list(
		melee = 0,
		bullet = 0,
		energy = 5,
		bomb = 0,
		bio = 0,
		rad = 10
	)
	spawn_blacklisted = TRUE

/obj/item/clothing/under/rank/miner
	name = "ERP suit"
	desc = "EVA Reclaimation Personnel disposable overalls issued to disposable debt-slaves. Suit sensors cannot be disabled."
	icon_state = "erp"
	item_state = "lb_suit"
	has_sensor = 2
	sensor_mode = 3

/obj/item/clothing/under/rank/diver
	name = "diver jumpsuit"
	desc = "A disposable jumpsuit issued to disposable debt-slaves."
	icon_state = "diver"
	item_state = "diver"
	sensor_mode = 3

/obj/item/clothing/under/frog/erp
	name = "EVA tactical suit"
	desc = "Flame Resistant Organizational Gear. A bit much- actually- this is probably appropriate."
	icon_state = "frog_erp"
	item_state = "frog_erp"

/obj/item/clothing/under/rank/diveboss
	name = "Diveboss uniform"
	desc = "A comfortable, and very tactical sweater."
	icon_state = "dive_boss"
	item_state = "engineer"
	sensor_mode = 3
	armor = list(
		melee = 5,
		bullet = 5,
		energy = 5,
		bomb = 5,
		bio = 5,
		rad = 5
	)
	spawn_blacklisted = TRUE

/obj/item/clothing/under/rank/roboticist
	desc = "A orange jumpsuit that great for industrial work."
	name = "roboticist's jumpsuit"
	icon_state = "robotics"
	item_state = "bl_suit"
	spawn_blacklisted = TRUE //no sprite
