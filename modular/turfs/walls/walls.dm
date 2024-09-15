//"Astra Apollo" style walls. Always untinted, we paid good money for these.

/turf/wall/untinted/orion
	icon_state = "orion_wall"
	icon = 'modular/turfs/walls/icons/walls.dmi'
	name = "steel wall"
	desc = "A few sheet-metal panels claiming to keep space from leaking in."
	wall_style = "minimalistic"
	wall_type = "steel_wall"

/turf/wall/untinted/orion_reinforced
	name = "reinforced wall"
	desc = "Layers of reinforced metal to keep space out, no matter what."
	icon_state = "orion_reinf_wall"
	icon = 'modular/turfs/walls/icons/walls.dmi'
	health = 600
	max_health = 600
	hardness = 140
	is_reinforced = TRUE
	wall_style = "minimalistic"
	wall_type = "orion_reinf_wall"

//Decorated types

/*turf/wall/untinted/orion/civil
	icon_state = "civil_wall"
	wall_type = "civil_wall"
*/
/turf/wall/untinted/orion/wood
	icon_state = "wood_wall"
	name = "wood panel wall"
	desc = "Intricately decorated wood paneling over sheet metal. Classy."
	wall_type = "wood_wall"

/turf/wall/untinted/orion/padded
	icon_state = "padded_wall"
	name = "padded wall"
	desc = "Lightly padded in case of unintented contact."
	wall_type = "padded_wall"

/turf/wall/untinted/orion_reinforced/psych
	name = "padded reinforced wall"
	desc = "Heavily padded and structurally reinforced for extra safe keeping."
	icon_state = "psychf_wall"
	wall_type = "psych_wall"

/*turf/wall/untinted/orion/industrial
	icon_state = "industrial_wall"
	name = "industrial wall"
	desc = "Sheet metal with extra provisions for mounting and locomotion in micro-gravity."
	wall_style = "minimalistic"
	wall_type = "steel_wall"

/turf/wall/untinted/orion_reinforced/industrial
	name = "reinforced industrial wall"
	desc = "Heavy mounting points, conduit ports, everything you could ever need except style."
	icon_state = "industrial_reinf_wall"
	wall_type = "industrial_reinf_wall"
*/
//Flimsy walls. Like space drywall.
/turf/wall/untinted/orion/panel
	icon_state = "panel_wall"
	name = "plastic panel wall"
	desc = "Cheaper than it looks."
	health = 150
	max_health = 150
	hardness = 30
	wall_type = "panel_wall"

/*turf/wall/untinted/orion/panel/red
	icon_state = "rpanel_wall"
	wall_type = "rpanel_wall"
*/
	//opacity = TRUE

//==============
//Low walls
//==============

/turf/wall/low/orion
	name = "padded low wall"
	desc = "" // TODO --KIROV
	icon = 'modular/turfs/walls/icons/walls.dmi'
	icon_state = "padded_low"
	opacity = FALSE
	layer = LOW_WALL_LAYER
	throwpass = TRUE
	max_health = 500
	health = 500
	is_low_wall = TRUE
	blocks_air = FALSE
	wall_type = "padded_low"

/turf/wall/low/orion/with_glass
	icon_state = "padded_low_glass"
	wall_type = "padded_low"
	window_prespawned_material = MATERIAL_GLASS
