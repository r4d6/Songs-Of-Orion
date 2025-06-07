//Alphabetical order of civilian jobs.
/obj/item/clothing/under/rank/assistant
	desc = "Filled with hatred and envy."
	name = "assistant's uniform"
	icon_state = "assistant"
	item_state = "assistant"

/obj/item/clothing/under/rank/bartender
	desc = "Expensive shirt and tie with tailored pants."
	name = "bartender's uniform"
	icon_state = "ba_suit"
	item_state = "ba_suit"
	style = STYLE_HIGH
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/bartender/skirt
	desc = "Expensive shirt and tie with a tailored skirt."
	name = "bartender's skirtsuit"
	icon_state = "ba_skirt"
	item_state = "ba_skirt"
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/captain //Alright, technically not a 'civilian' but its better then giving a .dm file for a single define.
	desc = "A red jumpsuit with some gold markings denoting the rank of \"Captain\"."
	name = "captain's jumpsuit"
	icon_state = "captain"
	item_state = "b_suit"

/obj/item/clothing/under/rank/crewman
	desc = "A utility jumpsuit for the working spaceman."
	name = "crewman's jumpsuit"
	icon_state = "crewman"
	item_state = "crewman"
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/preacher
	desc = "Ceremonial garb of NeoTheology preachers."
	name = "preacher vestments"
	icon_state = "preacher"
	item_state = "w_suit"
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/acolyte
	desc = "Ceremonial garb of NeoTheology disciples."
	name = "acolyte vestments"
	icon_state = "acolyte"
	item_state = "acolyte"
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/church
	desc = "Smells like incense."
	name = "church vestments"
	icon_state = "church"
	item_state = "church"
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/church/sport
	desc = "Smells like lilac."
	name = "church sports vestment"
	icon_state = "nt_sports"
	item_state = "nt_sports"
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/chef
	desc = "An apron which is given only to the most <b>hardcore</b> chefs in space."
	name = "chef's uniform"
	icon_state = "chef"
	item_state = "w_suit"
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/artist
	name = "Jester's Garments"
	desc = "The bright colors are almost distracting."
	icon_state = "artist"
	item_state = "artist"
	spawn_frequency = 0
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/clown
	name = "awful suit"
	desc = "People are awful."
	icon_state = "awful"
	item_state = "awful"
	style = STYLE_LOW

/obj/item/clothing/under/rank/first_officer
	desc = "A jumpsuit worn by someone who works in the position of \"First Officer\"."
	name = "First Officer's jumpsuit"
	icon_state = "FO"
	item_state = "b_suit"

/obj/item/clothing/under/rank/hydroponics
	desc = "A jumpsuit from the Bradhaanata Agroponics 'Farm Yourself' kit."
	name = "botanist's jumpsuit"
	icon_state = "hydroponics"
	item_state = "g_suit"
	permeability_coefficient = 0.50
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/rank/janitor
	desc = "An ancient janitorial jumpsuit."
	name = "janitor's jumpsuit"
	icon_state = "janitor"
	item_state = "janitor"
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

/obj/item/clothing/under/librarian
	name = "sensible suit"
	desc = "It's very... sensible."
	icon_state = "red_suit"
	item_state = "lawyer_red"
	style = STYLE_LOW
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/mime
	name = "mime's outfit"
	desc = "It's not very colourful."
	icon_state = "mime"
	item_state = "ba_suit"
	style = STYLE_LOW
	spawn_blacklisted = TRUE //no sprite

/obj/item/clothing/under/color/prisoner
	name = "prison jumpsuit"
	initial_name = "prison jumpsuit"
	desc = "Standardised prison-wear. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "prisoner"
	item_state = "o_suit"

	has_sensor = 2
	sensor_mode = 3

/obj/item/clothing/under/vatnik
	name = "vatnik outfit"
	desc = "We are few in number, but we are in telnyashkas!"
	icon_state = "vatnik"
	item_state = "lb_suit"
