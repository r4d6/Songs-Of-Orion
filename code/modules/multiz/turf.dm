/*
see multiz/movement.dm for some info.
*/
/turf/proc/CanZPass(atom/A, direction)
	if(z == A.z) //moving FROM this turf
		return direction == UP //can't go below
	else
		return !density

/turf/open/CanZPass(atom/A, direction)
	var/obj/effect/shield/turf_shield = getEffectShield()
	if(locate(/obj/structure/catwalk, src) || (turf_shield && !turf_shield.CanPass(A)))
		if(z == A.z)
			if(direction == DOWN)
				return 0
		else if(direction == UP)
			return 0
	return 1

/turf/space/CanZPass(atom/A, direction)
	var/obj/effect/shield/turf_shield = getEffectShield()
	if(locate(/obj/structure/catwalk, src) || (turf_shield && !turf_shield.CanPass(A)))
		if(z == A.z)
			if(direction == DOWN)
				return 0
		else if(direction == UP)
			return 0
	return 1

/turf/floor/CanZPass(atom/A, direction)
	return direction != DOWN
/////////////////////////////////////

/turf/open
	name = "open space"
	icon = 'icons/turf/space.dmi'
	icon_state = "black"
	density = FALSE
	plane = OPENSPACE_PLANE

	var/open = FALSE
	var/turf/below
	var/list/underlay_references
	var/global/overlay_map = list()
	is_hole = TRUE

	// A lazy list to contain a list of mobs who are currently scaling
	// up this turf. Used in human/can_fall.

	var/tmp/list/climbers = list()

/turf/open/New()
	icon_state = "transparentclickable"
	..()

/turf/open/LateInitialize()
	. = ..()
	below = SSmapping.GetBelow(src)
	ASSERT(SSmapping.HasBelow(z))
	update_icon()

/turf/open/is_plating()
	return TRUE

/turf/open/is_space()
	var/turf/below = SSmapping.GetBelow(src)
	return !below || below.is_space()

/turf/open/Entered(atom/movable/mover)
	. = ..()
	if(open)
		fallThrough(mover)

/turf/open/proc/updateFallability(obj/structure/catwalk/catwalk)
	var/wasOpen = open
	open = isOpen(catwalk)
	if(open && open != wasOpen)
		for(var/atom/A in src)
			fallThrough(A)

/turf/open/is_solid_structure()
	return !isOpen()

/turf/open/proc/isOpen(obj/structure/catwalk/catwalk)
	. = FALSE
	// only fall down in defined areas (read: areas with artificial gravitiy)
	if(!istype(below)) //make sure that there is actually something below
		below = SSmapping.GetBelow(src)
		if(!below)
			return

	/// If anything on our turf stops falls downwards
	for(var/atom/A in contents)
		if(A.can_prevent_fall(FALSE, null))
			return

	/// If anything below stops falls from above
	for(var/atom/A in below)
		if(A.can_prevent_fall(TRUE,null))
			return

	return TRUE

/turf/proc/fallThrough(var/atom/movable/mover)
	return

/turf/open/fallThrough(var/atom/movable/mover)

	// If the target is open space or a shadow, the projectile traverses down
	if( config.z_level_shooting && istype(mover,/obj/item/projectile) )
		var/obj/item/projectile/P = mover
		if(isnull(P.height) && ( istype(P.original, /turf/open) || (istype(mover, /mob/shadow)) ) && get_dist(P.starting, P.original) <= get_dist(P.starting, src))
			P.Move(below) // We want proc/Enter to get called on the turf, so we can't use forcemove()
			P.trajectory.loc_z = below.z
			P.bumped = FALSE
			P.height = HEIGHT_LOW // We are shooting from above, this protects windows from damage
			return // We are done here

	for(var/atom/A in contents)
		if(A.can_prevent_fall(FALSE, mover))
			return

	if(!mover.can_fall())
		return


	// No gravity, No fall.
	if(!has_gravity(src))
		return

	var/obj/effect/shield/turf_shield = getEffectShield()
	if (turf_shield && !turf_shield.CanPass(mover))
		return

	// See if something prevents us from falling.
	var/soft = FALSE
	for(var/atom/A in below)
		// Dont break here, since we still need to be sure that it isnt blocked
		if(istype(A, /obj/structure/multiz/stairs))
			soft = TRUE

	// We've made sure we can move, now.
	mover.forceMove(below)

	if(ishuman(mover) && mover.gender == MALE && prob(5))
		playsound(src, 'sound/hallucinations/scream.ogg', 100)

	if(!soft)

		if(!isliving(mover))
			if(istype(below, /turf/open))
				mover.visible_message(
					"\The [mover] falls from the deck above through \the [below]!",
					"You hear a whoosh of displaced air."
				)
			else
				mover.visible_message(
					"\The [mover] falls from the deck above and slams into \the [below]!",
					"You hear something slam into the deck."
				)
		else
			var/mob/M = mover
			if(istype(below, /turf/open))
				below.visible_message(
					"\The [mover] falls from the deck above through \the [below]!",
					"You hear a soft whoosh.[M.stat ? "" : ".. and some screaming."]"
				)
			else
				for(var/mob/living/m in below)
					if(istype(m))//is m real?

						if(ishuman(mover))//REAL SHIT
							var/mob/living/carbon/human/H = mover
							if(H.a_intent == I_HURT && !(m == H))
								M.visible_message(
									SPAN_DANGER("\The [mover] falls from the deck above and slams elbow-first into [m]!"),
									SPAN_DANGER("You slam elbow-first into [m]!"),
									SPAN_NOTICE("You hear a soft whoosh and a crunch.")
									)
					else
						M.visible_message(
							"\The [mover] falls from the deck above and slams into \the [below]!",
							"You land on \the [below].", "You hear a soft whoosh and a crunch."
						)

		// Handle people getting hurt, it's funny!
		mover.fall_impact(src, below)



		for(var/mob/living/M in below)
			var/fall_damage = mover.get_fall_damage()

			if(ishuman(mover))
				var/mob/living/carbon/human/H = mover
				if(H.a_intent == I_HURT)
					fall_damage = (H.mob_size + (min(min(H.stats.getStat(STAT_ROB), 1), 60) / 2)) //max is 50(a lot)

			if(M == mover)
				continue
			if(M.getarmor(BP_HEAD, ARMOR_MELEE) < fall_damage || ismob(mover))
				M.Weaken(10)
			if(fall_damage >= FALL_GIB_DAMAGE)
				M.gib()
			else
				var/tmp_damage	// Tmp variable to give the highest possible dmg on the head and less on the rest
				var/organ = BP_HEAD

				while(fall_damage > 0)
					fall_damage -= tmp_damage = rand(0, fall_damage)
					M.damage_through_armor(tmp_damage, BRUTE, organ, used_weapon = mover)
					organ = pickweight(list(BP_HEAD = 0.3, BP_CHEST = 0.8, BP_R_ARM = 0.6, BP_L_ARM = 0.6))


// override to make sure nothing is hidden
/turf/open/levelupdate()
	for(var/obj/O in src)
		O.hide(FALSE)
		SEND_SIGNAL_OLD(O, COMSIG_TURF_LEVELUPDATE, FALSE)

// Straight copy from space.
/turf/open/attackby(obj/item/C as obj, mob/user as mob)
	if (istype(C, /obj/item/stack/rods))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			return
		var/obj/item/stack/rods/R = C
		if (R.use(1))
			to_chat(user, SPAN_NOTICE("Constructing support lattice ..."))
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			ReplaceWithLattice()
		return

	if (istype(C, /obj/item/stack/material))
		var/obj/item/stack/material/M = C
		var/material/mat = M.get_material()
		if (!mat.name == MATERIAL_STEEL)
			return

		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			to_chat(user, SPAN_NOTICE("You start constructing underplating on the lattice."))
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			if(do_after(user, (40 * user.stats.getMult(STAT_MEC, STAT_LEVEL_EXPERT, src))))
				qdel(L)
				M.use(1)
				ChangeTurf(/turf/floor/plating/under)
			return
		else
			to_chat(user, SPAN_WARNING("The plating is going to need some support."))

	if(istype(C, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/coil = C
		coil.turf_place(src, user)
		return

//Some effect handling procs for openspaces

//Add tracks is called when a mob with bloody feet walks across the tile.
//Since there's no floor to walk on, this will simply not happen. Return without doing anything
/turf/open/AddTracks(typepath, bloodDNA, comingdir, goingdir, bloodcolor="#A10808")
	return


//Since walking around on openspaces wasn't possible before i fixed jetpacks, nobody thought to fix this
/turf/open/get_footstep_sound()
	var/obj/structure/catwalk/catwalk = locate(/obj/structure/catwalk) in src
	if(catwalk)
		return footstep_sound("catwalk")

/turf/open/MouseDrop_T(mob/target, mob/user)
	var/mob/living/H = user
	for(var/obj/structure/S in SSmapping.GetBelow(src))
		if(istype(H) && can_descend(H, S) && target == user)
			do_descend(target, S)
			return
	return ..()

/turf/open/proc/can_descend(mob/living/user, obj/structure/structure, post_descent_check = 0)
	if(!structure || !structure.climbable || (!post_descent_check && (user in climbers)))
		return

	if(!user.Adjacent(src))
		to_chat(user, SPAN_DANGER("You can't descend there, the way is blocked."))
		return

	var/obj/occupied = structure.turf_is_crowded()
	if(occupied)
		to_chat(user, SPAN_DANGER("There's \a [occupied] in the way."))
		return

	return 1

/turf/open/proc/do_descend(mob/living/user, obj/structure/structure)
	if(!can_descend(user, structure))
		return

	user.visible_message(SPAN_WARNING("[user] starts descending onto [structure]!"))
	structure.visible_message(SPAN_WARNING("Someone starts descending onto [structure]!"))
	climbers |= user

	var/delay = (issmall(user) ? 32 : 60) * (user.stats.getPerk(PERK_PARKOUR) ? 0.5 : 1)
	var/duration = max(delay * user.stats.getMult(STAT_VIG, STAT_LEVEL_EXPERT), delay * 0.66)
	if(!do_after(user, duration, src) || !can_descend(user, structure, post_descent_check = 1))
		climbers -= user
		return

	user.forceMove(SSmapping.GetBelow(src))

	if(get_turf(user) == SSmapping.GetBelow(src))
		user.visible_message(SPAN_WARNING("[user] descends onto [structure]!"))
	climbers -= user
