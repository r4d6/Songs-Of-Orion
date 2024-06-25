// Blue Crystals wait until an enemy is nearby before spawning multiple golems.
// It also boost the growth of nearby crystals.

/obj/structure/aetherium_crystal/blue
	name = "blue aetherium crystal"
	desc = "A strange crystal formation that seems to grow on its own..."
	icon_state = "aetherium_crystal_blue"
	anchored = TRUE
	density = FALSE
	light_range = 5 // Glow brighter in the dark
	growth_prob = 2.5 // Spread crystals faster
	blue_crystal_prob = 0 // Cannot spawn more blue crystal
	rad_damage = 0.75
	rad_range = 2
	golem_timer = 150
	var/boost_range = 2
	var/max_runtlings_spawn = 5
	var/trigger_range = 2

// Spawn golems in groups.
/obj/structure/aetherium_crystal/blue/handle_golems()
	if(golem)
		return FALSE

	golem_timer++

	if(golem_timer >= initial(golem_timer))
		for(var/mob/living/L in range(trigger_range))
			if(L.faction != "Aetherium") // If there's an enemy in range
				var/runt_amount = rand(1, max_runtlings_spawn)
				spawn_runtling(runt_amount) // Spawn a random amount of runtlings
				growth -= runt_amount
				golem_timer = 0
				return TRUE
		return FALSE

/obj/structure/aetherium_crystal/blue/spread()
	..()
	for(var/obj/structure/aetherium_crystal/AC in range(boost_range))
		if(istype(AC, /obj/structure/aetherium_crystal/blue) || istype(AC, /obj/structure/aetherium_crystal/spire))
			continue // To prevent infinite loops
		else
			AC.handle_growth() // The crystal grow & spread faster

/obj/structure/aetherium_crystal/blue/proc/spawn_runtling(var/runtling_amt = 1)
	var/list/turf_list = list()
	for(var/turf/T in view(1, src))
		if(istype(T, /turf/space) || locate(/obj/machinery/shieldwall/aetherium) in T || locate(/obj/machinery/shieldwallgen/aetherium) in T)
			continue // Ignore turfs that are actually air
		if(T.Enter(src)) // If we can "enter" on the tile then we can spread to it.
			turf_list += T

	var/sound/S = sound('sound/effects/screech.ogg')
	/*for(var/mob/living/carbon/human/H in viewers(src))
		if(H.stats.getPerk(PERK_PSION))
			to_chat(H, SPAN_PSION("[src] whistles..."))
			H.playsound_local(get_turf(src), S, 50) // Only psionics can hear that
*/
	sleep((S.len + 4) SECONDS) // 5 Seconds before the golems spawn


	for(var/I = 0, I < runtling_amt, I++)
		if(!golem) // Only one golem out of the pack get to be our main golem
			golem = new /mob/living/carbon/superior_animal/aetherium_golem/runtling(pick(turf_list))
			golem.node = src
		else
			new /mob/living/carbon/superior_animal/aetherium_golem/runtling(pick(turf_list))

	return runtling_amt
