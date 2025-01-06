//"Astra Apollo" style walls. Always untinted, we paid good money for these.

/turf/wall/untinted/orion
	icon_state = "steel_wall"
	icon = 'modular/turfs/walls/icons/walls.dmi'
	name = "steel wall"
	desc = "A few sheet-metal panels claiming to keep space from leaking in."
	wall_style = "minimalistic"
	wall_type = "steel_wall"

/turf/wall/untinted/orion_reinforced
	name = "reinforced wall"
	desc = "Layers of reinforced metal to keep space out, no matter what."
	icon_state = "reinforced_wall"
	icon = 'modular/turfs/walls/icons/walls.dmi'
	health = 600
	max_health = 600
	hardness = 150
	is_reinforced = TRUE
	wall_style = "minimalistic"
	wall_type = "reinforced_wall"
/turf/wall/untinted/orion_reinforced/get_matter()
	return list(MATERIAL_PLASTEEL = 5)

/turf/wall/untinted/test
	name = "test article wall"
	desc = "Back stage walls, not for sore eyes."
	icon_state = "reinforced_wall"
	icon = 'modular/turfs/walls/icons/walls.dmi'
	health = 600
	max_health = 600
	hardness = 150
	is_reinforced = TRUE
	wall_style = "minimalistic"
	wall_type = "test_wall"
	simulated = FALSE



/*
//Maybe later?
/turf/wall/untinted/orion_reinforced/padded
	icon_state = "padded_wall"
	name = "padded wall"
	desc = "Lightly padded in case of unintented contact."
	wall_type = "padded_wall"
*/

/turf/wall/untinted/orion_reinforced/psych
	name = "padded reinforced wall"
	desc = "Heavily padded and structurally reinforced for extra safe keeping."
	icon_state = "psych_wall"
	wall_type = "psych_wall"
/turf/wall/untinted/orion_reinforced/psych/get_matter()
	return list(MATERIAL_plastic = 5)

/turf/wall/untinted/orion_reinforced/reactor
	icon_state = "reactor_wall"
	icon = 'modular/turfs/walls/icons/reactor.dmi'
	name = "containment wall"
	desc = "Heavily shielded radiation containment system to keep the magic in the box."
	wall_type = "reactor_wall"
	health = 800
	max_health = 800
	hardness = 100


//Flimsy walls. Like space drywall.
/turf/wall/untinted/orion/panel
	icon_state = "panel_wall"
	name = "plastic panel wall"
	desc = "Cheaper than it looks."
	health = 150
	max_health = 150
	hardness = 30
	wall_type = "panel_wall"
/turf/wall/untinted/orion/panel/get_matter()
	return list(MATERIAL_PLASTIC = 5)

//Decorated types

/turf/wall/untinted/orion/wood
	icon_state = "wood_wall"
	name = "wood panel wall"
	desc = "Intricately decorated wood paneling over sheet metal. Classy."
	wall_type = "wood_wall"
/turf/wall/untinted/orion/wood/get_matter()
	return list(MATERIAL_WOOD = 5)

/*turf/wall/untinted/orion/panel/red
	icon_state = "rpanel_wall"
	wall_type = "rpanel_wall"
*/
	//opacity = TRUE

//==============
//Low walls
//==============

/turf/wall/low/orion
	name = "steel low wall"
	desc = "One half of a wall. Wonder where the rest is?"
	icon = 'modular/turfs/walls/icons/walls.dmi'
	icon_state = "steel_low"
	opacity = FALSE
	layer = LOW_WALL_LAYER
	throwpass = TRUE
	max_health = 500
	health = 500
	is_low_wall = TRUE
	blocks_air = FALSE
	wall_type = "steel_low"

/turf/wall/low/orion/with_glass
	icon_state = "steel_low_glass"
	wall_type = "steel_low"
	window_prespawned_material = MATERIAL_GLASS

/turf/wall/low/orion/padded
	name = "padded low wall"
	desc = "One half of a padded wall. Wonder where the rest is?"
	icon_state = "padded_low"
	wall_type = "padded_low"

/turf/wall/low/orion/padded/with_glass
	icon_state = "padded_low_glass"
	wall_type = "padded_low"

/turf/wall/low/orion/with_glass
	icon_state = "padded_low_glass"
	wall_type = "padded_low"
	window_prespawned_material = MATERIAL_GLASS
