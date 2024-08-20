/obj/structure/aetherium_crystal
	name = "aetherium crystal"
	desc = "A strange crystal formation that seems to grow on its own..."
	icon = 'icons/obj/aetherium.dmi'
	icon_state = "aetherium_crystal"
	anchored = TRUE
	density = FALSE // We can walk through them
	light_range = 1 // Glow in the dark
	light_color = COLOR_LIGHTING_GREEN_BRIGHT

	var/growth // the growth level of the crystal. The higher it is, the older the crystal is.
	var/max_growth = 5 // Maximum growth level, in case we want to do stuff relative to size
	var/growth_prob = 1 // The % of chance for the crystal to grow every tickv
	var/blue_crystal_prob = 5 // % chance of spawning a blue crystal instead of a green one when spreading
	var/spread_range = 1 // Radius that the crystal can spawn new crystals.
	var/mining_time = WORKTIME_NORMAL // How much time is needed to mine the crystal

	var/rad_range = 3 // Radius that the crystal irradiate
	var/rad_damage = 1 // How much radiation someone receive when standing on top of it.

	var/hallucination_power = 10 // Power of the hallucinations that psions receive.
	var/hallucination_duration = 5 SECONDS // Duration of the hallucinations

	var/golem_threshold = 10 // How many fully-grown aetherium crystals need to be in a location for a golem to spawn
	var/golem_timer = 100 // How many ticks between golem spawning
	var/golem_range = 2 // Radius that the crystal check for the above threshold
	var/mob/living/carbon/superior_animal/aetherium_golem/golem // The golem that the growth spawned
	var/shooter_prob = 10 // % chance of spawning the ranged golem instead of the regular one.

	// The crystals now fire back at you
	var/shooter = FALSE
	var/shooting = FALSE // Are we currently shooting at someone
	var/shoot_range = 5 // How close before they start shooting you?
	var/projectile_type = /obj/item/projectile/aetherium_shard
	var/max_projectiles = 3 // How many projectiles a crystal can have stored up at once.
	var/projectile_count = 0 // How many crystals are currently stored up.
	var/shoot_delay = 2 SECONDS // How much time in seconds before the crystal shoot you after spotting you.
	var/recharge_delay = 60 SECONDS // How much time in seconds before the crystal has a new projectile for you
	var/last_recharge = 0 // Last time we recharged a shot

	var/is_fake = FALSE // Fake Crystals cannot spread far from any type of spires, and can only spread more fake crystals
	var/fake_spread_range = 5 // How far can a Fake Crystal be from a spire before spread stops

/obj/structure/aetherium_crystal/Initialize(mapload, ...)
	..()
	START_PROCESSING(SSobj, src)
	AddRadSource(src, rad_damage, rad_range)

	// If the crystal was mapped in, spawn at full growth, else spawn as a seed.
	if(!growth) // As long as we didn't manually set a growth level
		if(mapload)
			growth = max_growth
			projectile_count = max_projectiles
		else
			growth = 1
	golem_timer = 0 // Reset the timer
	update_icon()

/obj/structure/aetherium_crystal/pre_grown/New()
	growth = max_growth
	..()

/obj/structure/aetherium_crystal/Destroy()
	STOP_PROCESSING(SSobj, src)
	golem?.node = null
	golem = null
	. = ..()

/obj/structure/aetherium_crystal/examine(mob/user)
	..()
	if(shooter && projectile_count)
		to_chat(user, SPAN_DANGER("There [projectile_count > 1 ? "are [projectile_count] shards" : "is a single shard"] hovering around this crystal."))

/obj/structure/aetherium_crystal/Process()
	if(prob(growth_prob))
		handle_growth()
		handle_duplicate_crystals()

	// Only try to spawn golems if we are at maximum growth
	if(growth >= max_growth)
		handle_golems()
		if(shooter && !shooting)
			handle_shooting()

#define REMAP(amount, a1, b1, a2, b2) (((amount) - (a1)) / ((b1) - (a1)) * ((b2) - (a2)) + (a2))
/obj/structure/aetherium_crystal/update_icon()
	transform = initial(transform)
	transform *= ((1/max_growth) * growth) // So the crystal is at 20% size at growth 1, 40% at growth 2, e.t.c.
	set_light(growth, growth)
	underlays.Cut()
	underlays += ("crystal_floor_[clamp(round(REMAP(growth, 1, max_growth, 1, 5)), 1, 5)]")

/obj/structure/aetherium_crystal/attackby(obj/item/I, mob/user)
	if(user.a_intent == I_HELP && user.Adjacent(src))
		var/tool_type = I.get_tool_type(user, list(QUALITY_EXCAVATION, QUALITY_DIGGING, QUALITY_SHOVELING), src)
		if(tool_type)
			visible_message(SPAN_NOTICE("[user] starts digging [src] up."), SPAN_NOTICE("You start digging [src] up."))
			if(I.use_tool(user, src, mining_time, tool_type, FAILCHANCE_EASY, required_stat = STAT_ROB))
				harvest_crystals()
			else
				to_chat(user, SPAN_WARNING("You must stay still to finish excavation."))
	else
		..()

/obj/structure/aetherium_crystal/bullet_act(var/obj/item/projectile/Proj)
	if(istype(Proj, /obj/item/projectile/sonic_bolt))
		visible_message("[src] shatters.")
		Destroy()
	else
		..()

// This proc handle the growth & spread of the crystal
/obj/structure/aetherium_crystal/proc/handle_growth()
	if(growth >= max_growth) // If we are at max growth.
		spread()
	else
		growth += 1 // Keep Growing
		update_icon()

/obj/structure/aetherium_crystal/proc/spread()
	if(is_fake) // Fake crystals can't spread far from spires
		var/can_spread = FALSE
		for(var/obj/structure/aetherium_crystal/AC in range(fake_spread_range))
			if(istype(AC, /obj/structure/aetherium_crystal/spire))
				can_spread = TRUE
				break
		if(!can_spread)
			return FALSE

	var/list/turf_list = list()
	for(var/turf/T in circlerangeturfs(spread_range, get_turf(src)))
		if(!can_spread_to_turf(T))
			continue
		if(T.Enter(src)) // If we can "enter" on the tile then we can spread to it.
			turf_list += T

	if(turf_list.len)
		var/turf/T = pick(turf_list)
		var/crystal

		if(prob(blue_crystal_prob))
			crystal = /obj/structure/aetherium_crystal/blue
		else
			crystal = /obj/structure/aetherium_crystal // We spread

		if(crystal)
			var/obj/structure/aetherium_crystal/AC = new crystal(T) // We spread
			AC.is_fake = is_fake // Fake crystals only produce more fake crystals

// Check the given turf to see if there is any special things that would prevent the spread
/obj/structure/aetherium_crystal/proc/can_spread_to_turf(var/turf/T)
	if(T)
		if(istype(T, /turf/space)) // We can't spread in SPACE!
			return FALSE
		if(locate(/obj/structure/aetherium_crystal) in T) // No stacking.
			return FALSE
		if(locate(/obj/machinery/shieldwall/aetherium) in T) // Sonic fence block spread.
			return FALSE
		if(locate(/obj/machinery/shieldwallgen/aetherium) in T) // Sonic fence block spread. We can't spread in corners
			return FALSE
	return TRUE

// This proc handle the spawning of golems
/obj/structure/aetherium_crystal/proc/handle_golems()
	if(golem)
		return FALSE

	if(++golem_timer >= initial(golem_timer))
		golem_timer = 0

		var/valid_crystal = 0
		for(var/obj/structure/aetherium_crystal/AC in range(golem_range, src))
			if(istype(AC, /obj/structure/aetherium_crystal/spire))
				continue // Ignore the aetherium spire if there's one
			if(AC.golem)
				return FALSE // Don't spawn a golem if any nearby growth spawned one, to prevent a fuckton of golems from spawning
			if(AC.growth >= max_growth)
				valid_crystal++
			if(valid_crystal >= golem_threshold)
				break // We have enough crystals, leave early

		if(valid_crystal >= golem_threshold)
			// Commented out because it would be annoying, but maybe other people want it.
			/*var/sound/S = sound('sound/synthesized_instruments/chromatic/vibraphone1/c5.ogg')
			for(var/mob/living/carbon/human/H in view(src))
				to_chat(H, SPAN_PSION("[src] chimes."))
				H.playsound_local(get_turf(src), S, 50)

			sleep((S.len + 1) SECONDS) // Wait until the sound is done, we're using S.len in case the sound change for another with a different duration. We add a second to give a slightly longer warning time.
			*/
			if(prob(shooter_prob))
				golem = new /mob/living/carbon/superior_animal/aetherium_golem/aetherium_shooter(get_turf(src))
			else
				golem = new(get_turf(src)) // Spawn a golem
			golem.node = src
			src.visible_message("[src] create a crystal golem to defend itself.")
			if(is_fake) // Fake crystals consume 1 growth to create a golem
				growth -= 1
			return TRUE
		return FALSE

// Check for duplicate crystals in the same turf
/obj/structure/aetherium_crystal/proc/handle_duplicate_crystals()
	for(var/obj/structure/aetherium_crystal/TC in orange(0, src)) // Check the turf we are in
		if(TC.growth > growth)
			continue // Don't delete crystals bigger than us
		qdel(TC)

// Proc for admins to manually allow the crystals to process or not
/obj/structure/aetherium_crystal/proc/toggle_processing()
	if(is_processing)
		STOP_PROCESSING(SSobj, src)
	else
		START_PROCESSING(SSobj, src)

/obj/structure/aetherium_crystal/proc/handle_golem_distance()
	return

/obj/structure/aetherium_crystal/proc/harvest_crystals()
	var/obj/item/stack/material/aetherium/T = new(get_turf(src))
	T.amount = growth // Drop more crystal the further along we are
	activate_mobs_in_range(src, 15) // Wake up the nearby golems
	qdel(src)

/obj/structure/aetherium_crystal/proc/handle_shooting()
	recharge_shot()
	if(projectile_count < 1)// Nothing to shoot
		return FALSE

	var/list/targets = list()
	for(var/mob/living/M in view(shoot_range, src))
		if(M.stat != DEAD && M.faction != "aetherium") // Do not shoot our guys
			targets += M
	if(!targets.len)
		return FALSE

	var/mob/living/current_target = pick(targets)
	/*
	var/sound/S = sound('sound/synthesized_instruments/chromatic/vibraphone1/c2.ogg')
	for(var/mob/living/carbon/human/H in view(src))
		if(H.stats.getPerk(PERK_PSION))
			to_chat(H, SPAN_PSION("[src] rings."))
			H.playsound_local(get_turf(src), S, 50) // Only psionics can hear that
	*/
	shooting = TRUE
	spawn(/*S.len SECOND + */shoot_delay) shoot(current_target) // Wait until the sound is done, we're using S.len in case the sound change for another with a different duration.
	return TRUE

/obj/structure/aetherium_crystal/proc/shoot(var/mob/living/M)
	if((!M) || (!M in view())) // Can't see it. Intentionally bigger than the targeting range
		return FALSE
	if(!projectile_count) // Nothing to shoot
		return FALSE

	var/obj/item/projectile/P = new projectile_type(src.loc)
	projectile_count--
	P.launch(M, ran_zone()) // Fire away!
	src.visible_message(SPAN_DANGER("[src] fire a shard at [M]"))
	shooting = FALSE
	return TRUE

/obj/structure/aetherium_crystal/proc/recharge_shot()
	if(last_recharge <= world.time) // Enough time has passed
		last_recharge = world.time + recharge_delay
		if(projectile_count < max_projectiles)
			projectile_count++
			src.visible_message(SPAN_DANGER("A crystal shard splinter off [src]"))
			return TRUE
