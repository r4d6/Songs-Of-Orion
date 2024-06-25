// Everything that would normally be spread out across dozens of files, is all here because of Modularity

/obj/item/material/shard/aetherium
	name = "aetherium"

/obj/item/material/shard/aetherium/New(loc)
	..(loc, MATERIAL_AETHERIUM)

// Material Datum
/material/aetherium
	name = MATERIAL_AETHERIUM
	stack_type = /obj/item/stack/material/aetherium
	icon_colour = "#007A00"
	sheet_singular_name = "shard"
	sheet_plural_name = "shards"
	stack_origin_tech = list(TECH_MATERIAL = 9)

/obj/item/stack/material/aetherium
	name = "aetherium shard"
	desc = "A weird green crystal that seems to grow on its own."
	singular_name = "aetherium crystal"
	icon = 'icons/obj/aetherium.dmi'
	icon_state = "aetherium_crystal_item"
	default_type = MATERIAL_AETHERIUM
	novariants = TRUE
	price_tag = 50 // Aetherium mining is extremly dangerous and very profitable
	max_amount = 360

/obj/item/stack/material/aetherium/full
	amount = 360

// Crafting Recipe
/datum/craft_recipe/aetherium_seed
	name = "new aetherium growth"
	flags = CRAFT_ON_FLOOR|CRAFT_ONE_PER_TURF
	result = /obj/structure/aetherium_crystal
	icon_state = "device"
	steps = list(
		list(/obj/item/aetherium_gem, 1, "time" = 25)
	)

//----------------------------
// Aetherium beam effect
//----------------------------
/obj/effect/projectile/aetherium/tracer
	icon_state = "xray_old"

/obj/effect/projectile/aetherium/muzzle
	icon_state = "muzzle_xray_old"

/obj/effect/projectile/aetherium/impact
	icon_state = "impact_xray_old"

/datum/design/research/circuit/aetheriumshieldwallgen
	name = "sonic fence generator"
	build_path = /obj/item/electronics/circuitboard/aetheriumshieldwallgen
	category = CAT_AETHERIUM

/datum/design/research/circuit/aetherium_refinery
	name = "aetherium refinery"
	build_path = /obj/item/electronics/circuitboard/aetherium_refinery
	category = CAT_AETHERIUM

/datum/design/research/circuit/liquid_aetherium_processor
	name = "liquid aetherium processor"
	build_path = /obj/item/electronics/circuitboard/liquid_aetherium_processor
	category = CAT_AETHERIUM

/datum/design/research/circuit/aetherium_analyzer
	name = "liquid aetherium analyzer"
	build_path = /obj/item/electronics/circuitboard/aetherium_analyzer
	category = CAT_AETHERIUM

// Power Cell
/datum/design/research/item/powercell/large/aetherium
	name = "\"Aetherium 20000L\""
	build_path = /obj/item/cell/large/aetherium
	chemicals = list(MATERIAL_AETHERIUM = 120) //Beakers worth on top of normal cell costs

// A cell powered by an aetherium gem. It is self-charging if it has an aetherium core inside it.
/obj/item/cell/large/aetherium
	name = "aetherium power cell adapter"
	desc = "Todo"
	icon_state = "hydrogen"
	maxcharge = 20000
	autorecharging = TRUE
	autorecharge_rate = 0.1
	price_tag = 600
	origin_tech = list(TECH_POWER = 15)
	var/obj/item/aetherium_gem/core

/obj/item/cell/large/aetherium/New()
	..()
	update_core()

/obj/item/cell/large/aetherium/examine(mob/user)
	..()
	if(!core)
		to_chat(user, SPAN_NOTICE("[src] doesn't have an aetherium gem installed."))

/obj/item/cell/large/aetherium/attackby(obj/item/W, mob/user)
	..()
	if(istype(W, /obj/item/aetherium_gem) && !core)
		insert_item(W, user) // Insert the fuel cell into the adapter
		core = W
		update_core() // Update the charge
		return

/obj/item/cell/large/aetherium/MouseDrop(over_object)
	if(core)
		usr.visible_message(
								SPAN_NOTICE("[usr] remove [core] from [src]."),
								SPAN_NOTICE("You remove [core] from [src].")
									)
		eject_item(core, usr)
		core = null
		update_core() // Update the charge
	else
		to_chat(usr, SPAN_NOTICE("[src] doesn't have an aetherium gem."))

/obj/item/cell/large/aetherium/update_icon()
	icon_state = "[initial(icon_state)]_[core ? "1" : "0"]" // hydrogen_1 if it has a core, hydrogen_0 if it doesn't.

/obj/item/cell/large/aetherium/proc/update_core()
	autorecharging = core ? TRUE : FALSE
	update_icon()

/obj/item/cell/large/aetherium/loaded/New()
	..()
	core = new(src)
	update_core()

// Potted Aetherium Crystal.
/obj/structure/flora/pottedplant/green_rock
	name = "potted aetherium shard"
	desc = "An aetherium shard in a plant pot, contained using a small sonic fence powered by a duo of Essence-Crystals. It has a small knob to set the fence's opacity level."
	icon = 'icons/obj/plants.dmi'
	icon_state = "aetherium_pot_shield_powered"
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	light_range = 2
	light_power = 0.6
	light_color = "#43BA69" //Green!
	var/shield_level = 3

/obj/structure/flora/pottedplant/green_rock/attack_hand(mob/living/user as mob)
	switch(shield_level)
		if(3)
			shield_level = 2
			icon_state = "aetherium_pot_shield_powered"
			to_chat(user, "You turn the knob and make the fence translucent.")
		if(2)
			shield_level = 1
			icon_state = "aetherium_pot_shield_unpowered"
			to_chat(user, "You turn the knob and make the fence opaque.")
		if(1)
			shield_level = 3
			icon_state = "aetherium_pot_shieldless"
			to_chat(user, "You turn the knob and make the fence almost invisible.")

/obj/structure/flora/pottedplant/green_rock/emp_act(severity)
	if(severity) // Just a safety check. We don't need to check for the kind of severity, because fucking everything EMP-related always fire at full blast anyway.
		visible_message(SPAN_DANGER("[src] fizzles as the containment fail."))
		new /obj/structure/aetherium_crystal(get_turf(src))
		new /obj/effect/decal/cleanable/blood/gibs/robot(src.loc)
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(3, 1, src)
		s.start()
		qdel(src)

// Reagents
/datum/reagent/liquid_aetherium
	name = "Liquid Aetherium"
	id = MATERIAL_AETHERIUM
	description = "A green liquid with small crystals floating in it."
	taste_description = "crystalline crystals"
	reagent_state = SOLID
	color = "#5FE45E"
	metabolism = 5

/datum/reagent/liquid_aetherium/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.apply_effect(effect_multiplier, IRRADIATE, 0, 0) // We ignore physical protection because we're inside

/datum/reagent/liquid_aetherium/touch_turf(turf/T)
	if(volume >= 10)
		if(can_grow(T))
			new /obj/structure/aetherium_crystal(T)
		return TRUE
	return TRUE

/datum/reagent/liquid_aetherium/proc/can_grow(var/turf/T)
	if(T)
		if(T.density)
			return FALSE
		if(istype(T, /turf/space)) // We can't spread in SPACE!
			return FALSE
		if(locate(/obj/structure/aetherium_crystal) in T) // No stacking.
			return FALSE
		if(locate(/obj/machinery/shieldwall/aetherium) in T) // Sonic fence block spread.
			return FALSE
		if(locate(/obj/machinery/shieldwallgen/aetherium) in T) // Sonic fence block spread. We can't spread in corners
			return FALSE
	return TRUE

/obj/item/reagent_containers/glass/bottle/aetherium
	name = "liquid aetherium bottle"
	desc = "A small bottle. Contains liquid aetherium."
	icon_state = "bottle"
	preloaded_reagents = list(MATERIAL_AETHERIUM = 60)

/datum/technology/aetherium
	name = "Aetherium Refinement"
	desc = "Advanced refinements of aetherium between liquid and solid states."
	tech_type = RESEARCH_ENGINEERING

	x = 0.9
	y = 0.7
	icon = "aetherium"

	required_technologies = list()
	required_tech_levels = list()
	cost = 1500 //Cheap-ish I guess?

	unlocks_designs = list(/datum/design/research/circuit/aetherium_refinery,
							/datum/design/research/circuit/liquid_aetherium_processor,
							/datum/design/research/circuit/aetherium_analyzer
							)

// Circuit boards for aetherium-related machinery

/obj/item/electronics/circuitboard/aetheriumshieldwallgen
	name = "sonic fence generator"
	board_type = "machine"
	build_path = /obj/machinery/shieldwallgen/aetherium
	origin_tech = list(TECH_BLUESPACE = 3, TECH_MAGNET = 3)
	req_components = list(
		/obj/item/stock_parts/subspace/transmitter = 1,
		/obj/item/stock_parts/subspace/crystal = 1,
		/obj/item/stock_parts/subspace/amplifier = 1,
		/obj/item/stock_parts/capacitor = 2,
		/obj/item/stack/cable_coil = 30
	)

/obj/item/electronics/circuitboard/aetherium_refinery
	name = "aetherium refinery"
	board_type = "machine"
	build_path = /obj/machinery/aetherium_refinery
	origin_tech = list(TECH_DATA = 4, TECH_MATERIAL = 9, TECH_ENGINEERING = 5)
	frame_type = FRAME_VERTICAL
	req_components = list(
		/obj/structure/reagent_dispensers/bidon = 1
	)

/obj/item/electronics/circuitboard/liquid_aetherium_processor
	name = "liquid aetherium processor"
	board_type = "machine"
	build_path = /obj/machinery/liquid_aetherium_processor
	origin_tech = list(TECH_DATA = 4, TECH_MATERIAL = 9, TECH_ENGINEERING = 5)
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/aetherium_gem = 1
	)

/obj/item/electronics/circuitboard/aetherium_analyzer
	name = "liquid aetherium analyzer"
	board_type = "machine"
	build_path = /obj/machinery/aetherium_analyzer
	origin_tech = list(TECH_DATA = 4, TECH_MATERIAL = 9, TECH_ENGINEERING = 5)
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/aetherium_gem = 1
	)

/obj/item/electronics/circuitboard/aetherium_lure
	name = "aetherium lure"
	board_type = "machine"
	build_path = /obj/machinery/aetherium_lure
	origin_tech = list(TECH_DATA = 4, TECH_MATERIAL = 9, TECH_ENGINEERING = 5)
	req_components = list(
		/obj/item/stock_parts/subspace/transmitter = 2,
		/obj/item/stock_parts/subspace/crystal = 2,
		/obj/item/stock_parts/subspace/amplifier = 2,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/aetherium_gem = 5
	)

/obj/machinery
	var/anchor_direction = null //The immediate directions an object can be anchored to a machine. If null, any direction is allowed.
	var/anchor_type = null //What type of object can be anchored to a machine
