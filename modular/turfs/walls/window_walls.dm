//This is the cargo-est of cargo cult coding and kitbashing anyone has ever done and may God have mercy on us for it.

/turf/wall/untinted/orion/window
	icon_state = "paneglass_wall"
	name = "glass wall"
	desc = "Cheaper than it looks."
	health = 150
	max_health = 150
	hardness = 30
	wall_type = "paneglass_wall"
	opacity = FALSE
	var/shardtype = /obj/item/material/shard
	var/glasstype = null // Set this in subtypes. Null is assumed strange or otherwise impossible to dismantle, such as for shuttle glass.


/turf/wall/untinted/orion/window/take_damage(damage)
	if(!is_simulated)
		return
	if(damage < 1)
		return
	if(locate(/obj/effect/overlay/wallrot) in src)
		damage *= 10
	. = min(health, damage)
	health -= damage
	if(health <= 0)
		dismantle_wall()
		playsound(src, "shatter", 70, 1)
		visible_message("[src] shatters!")
	else
		update_icon()


/turf/wall/untinted/orion/window/attack_hand(mob/user as mob)
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	if (user.a_intent == I_HURT)

		if (ishuman(user))
			var/mob/living/carbon/human/H = user
			if(H.species.can_shred(H))
				attack_generic(H,25)
				return
		playsound(get_turf(src), 'sound/effects/glassknock.ogg', 100, 1, 10, 10)
		user.do_attack_animation(src)
		user.visible_message(SPAN_DANGER("\The [user] bangs against \the [src]!"),
							SPAN_DANGER("You bang against \the [src]!"),
							"You hear a banging sound.")
	else
		playsound(get_turf(src), 'sound/effects/glassknock.ogg', 80, 1, 5, 5)
		user.visible_message("[user.name] knocks on the [src.name].",
							"You knock on the [src.name].",
							"You hear a knocking sound.")
	return

//TODO: Actually make this nonsense work
/turf/wall/untinted/orion/window/proc/shatter(var/display_message = 1, var/explode = FALSE)
	alpha = 0
	if (explode)
		playsound(src, "shatter", 100, 1, 5,5)
	else
		playsound(src, "shatter", 70, 1)

	//Cache a list of nearby turfs for throwing shards at
	var/list/turf/nearby
	if (explode)
		nearby = (RANGE_TURFS(2, src) - get_turf(src))
	else
		nearby = (RANGE_TURFS(1, src) - get_turf(src))

	if(display_message)
		visible_message("[src] shatters!")
		var/index = null
		index = 0
		while(index < rand(4,6))
			var/obj/item/material/shard/S = new shardtype(loc)
			if (nearby.len > 0)
				var/turf/target = pick(nearby)
				//spawn()
				S.throw_at(target,40,3)
			index++
	else
		new shardtype(loc) //todo pooling?
	dismantle_wall()
	return

/turf/wall/untinted/orion/window/basic
	icon_state = "paneglass_wall"
	name = "glass wall"
	desc = "Cheaper than it looks."
	glasstype = /obj/item/stack/material/glass
	health = 150
	max_health = 150
	hardness = 30
	wall_type = "paneglass_wall"
/turf/wall/untinted/orion/window/basic/get_matter()
	return list(MATERIAL_GLASS = 5)

/turf/wall/untinted/orion/window/reinforced
	icon_state = "paneglass_wall"
	name = "reinforced glass wall"
	desc = "More durable than it looks."
	health = 400
	max_health = 400
	hardness = 100
	wall_type = "reinfglass_wall"
	glasstype = /obj/item/stack/material/glass/reinforced
	opacity = FALSE

/turf/wall/untinted/orion/window/reinforced/get_matter()
	return list(MATERIAL_RGLASS  = 5)