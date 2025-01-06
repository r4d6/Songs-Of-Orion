/decl/flooring/reinforced/orion/
	name = "biological shield"
	desc = "Heavy radiation shielding tiles."
	icon = 'modular/turfs/floors/icons/tiles_reactor.dmi'
	icon_base = "reactor"
	flags = TURF_HAS_CORNERS | TURF_HAS_INNER_CORNERS | TURF_REMOVE_WRENCH | TURF_ACID_IMMUNE | TURF_CAN_BURN | TURF_CAN_BREAK | TURF_HIDES_THINGS |TURF_HIDES_THINGS
	build_type = /obj/item/stack/rods
	build_cost = 2
	build_time = 30
	apply_thermal_conductivity = 0.025
	apply_heat_capacity = 325000
	can_paint = 1
	resistance = RESISTANCE_TOUGH
	footstep_sound = "plating"

/turf/floor/reinforced/orion/reactor
	name = "biological shield"
	desc = "Heavy radiation shielding tiles."
	icon = 'modular/turfs/floors/icons/tiles_reactor.dmi'
	icon_state = "reactor"
	carbon_dioxide = 3000
	temperature = 293
	initial_flooring = /decl/flooring/reinforced/orion/

/decl/flooring/orion/venting
	name = "venting"
	icon_base = "venting"
	icon = 'modular/turfs/floors/icons/tech.dmi'
	build_type = /obj/item/stack/tile/floor/steel
	footstep_sound = "floor"

/turf/floor/reinforced/orion/venting
	icon_state = "venting"
	initial_flooring = /decl/flooring/orion/venting

/decl/flooring/tiling/orion
	name = "decking"
	icon_base = "tile"
	icon = 'modular/turfs/floors/icons/tiles.dmi'
	build_type = /obj/item/stack/tile/floor/steel
	footstep_sound = "floor"

/turf/floor/tiled/orion
	name = "decking"
	icon = 'modular/turfs/floors/icons/tiles.dmi'
	icon_state = "tile"
	initial_flooring = /decl/flooring/tiling/orion

/decl/flooring/tiling/orion/tech
	name = "decking"
	icon_base = "techfloor"
	icon = 'modular/turfs/floors/icons/tech.dmi'
	build_type = /obj/item/stack/tile/floor/steel
	footstep_sound = "floor"

	floor_smooth = SMOOTH_WHITELIST
	flooring_whitelist = list(/decl/flooring/tiling/orion/tech/panel, /decl/flooring/tiling/orion/tech/maint)

/turf/floor/tiled/orion/tech
	name = "decking"
	icon = 'modular/turfs/floors/icons/tech.dmi'
	icon_state = "techfloor"
	initial_flooring = /decl/flooring/tiling/orion/tech

/decl/flooring/tiling/orion/tech/panel
	icon_base = "techpanel"
	build_type = /obj/item/stack/tile/floor/steel/panels

/turf/floor/tiled/orion/tech/panel
	icon_state = "techpanel"
	initial_flooring = /decl/flooring/tiling/orion/tech/panel

/decl/flooring/tiling/orion/tech/conduit
	icon_base = "techconduit"
	build_type = /obj/item/stack/tile/floor/steel/panels

/turf/floor/tiled/orion/tech/conduit
	icon_state = "techconduit"
	initial_flooring = /decl/flooring/tiling/orion/tech/conduit

/decl/flooring/tiling/orion/tech/maint
	icon_base = "techmaint"
	build_type = /obj/item/stack/tile/floor/steel/panels

/turf/floor/tiled/orion/tech/maint
	icon_state = "techmaint"
	initial_flooring = /decl/flooring/tiling/orion/tech/maint


