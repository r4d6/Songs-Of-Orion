/*
 * Science
 */
/obj/item/clothing/under/rank/expedition_overseer
	name = "Human Resources Officer uniform"
	desc = "A jumpsuit worn by those with the know-how to achieve the position of \"Expedition Overseer\"."
	icon_state = "HRO"
	item_state = "lb_suit"
	armor = list(
		melee = 5,
		bullet = 0,
		energy = 5,
		bomb = 0,
		bio = 10,
		rad = 0
	)


/obj/item/clothing/under/rank/scientist
	name = "Bioscience uniform"
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has markings that denote the wearer as HR Bioscience Technician."
	icon_state = "HR"
	item_state = "w_suit"
	permeability_coefficient = 0.50
	armor = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 10,
		rad = 0
	)

/obj/item/clothing/under/rank/wagie
	name = "WAGIE uniform"
	desc = "Worker Assistant, Generalized Indentured Employee. Suit sensors cannot be disabled."
	icon_state = "wagie"
	item_state = "lb_suit"
	has_sensor = 2
	sensor_mode = 3
	permeability_coefficient = 0.50
	armor = list(
		melee = 4,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 10,
		rad = 10
	)


/obj/item/clothing/under/rank/chemist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a chemist rank stripe on it."
	name = "moebius chemist's jumpsuit"
	icon_state = "chemistry"
	item_state = "chemistry"
	permeability_coefficient = 0.50
	armor = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 10,
		rad = 0
	)
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/bioengineer
	name = "Bioengineer uniform"
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has markings that denote the wearer as Human Resources Life Engineer."
	icon_state = "HR"
	item_state = "HR"
	permeability_coefficient = 0.50
	armor = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 10,
		rad = 0
	)

/*
 * Medical
 */
/obj/item/clothing/under/rank/moebius_biolab_officer
	name = "Brotherhood Coordinator uniform"
	desc = "The supposedly classy outfit worn by the Brotherhood Coordinator."
	icon_state = "coord"
	item_state = "coord"
	permeability_coefficient = 0.50
	armor = list(
		melee = 5,
		bullet = 5,
		energy = 0,
		bomb = 0,
		bio = 10,
		rad = 0
	)

/obj/item/clothing/under/rank/virologist
	desc = "An old green shirt and khakis, originally worn by the Moebius Virology Division, now it is discarded in maintenance after their disbandment."
	name = "moebius virologist's uniform"
	icon_state = "virology"
	item_state = "w_suit"
	permeability_coefficient = 0.50
	armor = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 10,
		rad = 0
	)
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/medical
	name = "Brotherhood doctor's scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards."
	icon_state = "doctor"
	item_state = "doctor"
	permeability_coefficient = 0.50
	armor = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 15,
		rad = 0
	)

/obj/item/clothing/under/rank/volunteer
	name = "Brotherhood volunteer scrubs"
	desc = "The mis-matched uniform of Brotherhood Clinic volunteers."
	icon_state = "volunteer"
	item_state = "volunteer"
	permeability_coefficient = 0.50
	armor = list(
		melee = 5,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 10,
		rad = 0
	)

/obj/item/clothing/under/rank/volunteer/turtle
	name = "Brotherhood turtleneck"
	desc = "A surprisingly snappy sweater worn by Brotherhood volunteers."
	icon_state = "brotherhood_turtle"
	item_state = "brotherhood_turtle"
	armor = list(
		melee = 10,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 5,
		rad = 0
	)

/obj/item/clothing/under/rank/medical/blue
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in baby blue."
	icon_state = "scrubsblue"
	item_state = "b_suit"
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/medical/green
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in dark green."
	icon_state = "scrubsgreen"
	item_state = "scrubsgreen"
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/medical/purple
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in deep purple."
	icon_state = "scrubspurple"
	item_state = "p_suit"
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/psych
	desc = "A turqouise turtleneck and a pair of dark blue slacks, belonging to a psychologist."
	name = "moebius psychologist's turtleneck"
	icon_state = "psychturtle"
	item_state = "b_suit"
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/paramedic
	desc = "Jumpsuit of Moebius Medical paramedics. It's made with reinforced fiber to offer more protection for recovery operators."
	name = "moebius paramedic's jumpsuit"
	icon_state = "paramedic"
	item_state = "paramedic"
	permeability_coefficient = 0.50
	armor = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 10,
		rad = 0
	)
	spawn_blacklisted = TRUE //no sprite
