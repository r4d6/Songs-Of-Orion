// Admin-only for events

/obj/machinery/aetherium_lure
	name = "aetherium lure"
	desc = "A machine that can attract an aetherium spire."
	icon = 'icons/obj/adms.dmi'
	icon_state = "adms"
	circuit = /obj/item/electronics/circuitboard/aetherium_lure
	var/ping_sound = 'sound/ambience/sonar.ogg'
	var/crystal_radius = 4
	var/mob_count = 30

/obj/machinery/aetherium_lure/attack_hand(mob/user as mob)
	switch(alert(user, "Are you sure you want to active the lure?", "Lure Activation", "Yes","No"))
		if("No")
			return
		if("Yes")
			visible_message(SPAN_WARNING("[user] activates [src]!"))
			activate()

/obj/machinery/aetherium_lure/proc/activate()
	var/sound/S = sound(ping_sound)
	playsound(loc, S)
	sleep(20 SECONDS) // Length of ping_sound, needs to be set manually
	crystal_raid(get_turf(src), crystal_radius, mob_count)
	qdel(src)


// Aetherium "raid". A spire erupts from the ground, bringing more crystals and golems with it.
proc/crystal_raid(var/turf/Center, var/radius = 3, var/mob_count, var/spawn_delay = 10 SECONDS, var/behemoth_count = 3)
	if(!Center || !radius || !mob_count)
		return

	// Advance warning
	for(var/mob/living/carbon/human/M in range(radius * 2.5, Center))
		shake_camera(M, 3)

	playsound(Center, 'sound/effects/screech.ogg', 20, 1, 8, 8)
	playsound(Center, 'sound/effects/screech.ogg', 60, 1, 8, 8)
	playsound(Center, 'sound/effects/screech.ogg', 80, 1, 8, 8)
	playsound(Center, 'sound/effects/screech.ogg', 100, 1, 8, 8)

	sleep(spawn_delay) // Wait a bit

	for(var/mob/living/carbon/human/M in range(radius * 2, Center))
		shake_camera(M, 5)
		M.Weaken(5)

	// The spire arrives gun-blazing
	var/obj/structure/aetherium_crystal/spire/S = new /obj/structure/aetherium_crystal/spire(Center)
	S.projectile_count = S.max_projectiles
	playsound(Center, 'sound/effects/impacts/thud_break.ogg', 100, 1, 8, 8)
	playsound(Center, 'sound/effects/impacts/thud_break.ogg', 100, 1, 8, 8)
	playsound(Center, 'sound/effects/impacts/thud_break.ogg', 100, 1, 8, 8)
	playsound(Center, 'sound/effects/impacts/thud_break.ogg', 100, 1, 8, 8)
	playsound(Center, 'sound/effects/impacts/thud_break.ogg', 100, 1, 8, 8)

	S.visible_message(SPAN_DANGER("[S] erupts from the ground, spewing deadly golems"))

	// Quickly spread a bunch of crystals
	for(var/turf/T in (circlerangeturfs(Center, radius)))
		// Skip turfs we can't spread on.
		if(!S.can_spread_to_turf(T))
			continue
		new /obj/structure/aetherium_crystal/pre_grown(T)

	// Spawn a bunch of golems

	for(var/i = mob_count, i > 0, i -= 1)
		var/turf/T = pick(circlerangeturfs(Center, radius))
		new /mob/living/carbon/superior_animal/aetherium_golem(T)

	/*for(var/turf/T in orange(Center, 2))
		new /mob/living/carbon/superior_animal/aetherium_golem(T)*/

	// Spawn a few behemoths on top of that
	for(var/i = behemoth_count, i > 0, i -= 1)
		new /mob/living/carbon/superior_animal/aetherium_golem/behemoth(Center)

	// Wake up all the new mobs
	activate_mobs_in_range(Center, radius*2)
