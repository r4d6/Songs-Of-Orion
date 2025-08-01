//Procs and vars related to dirt, cleaning, and mopping

/*
	Wetness and slipping
*/

/turf/proc/wet_floor(wet_value = 1, force_wet = FALSE)
	if(wet_value < is_wet && !force_wet)
		return

	if(force_wet || !is_wet)
		is_wet = wet_value
	if(!wet_overlay)
		wet_overlay = image('icons/effects/water.dmi',src,"wet_floor")
		overlays += wet_overlay

	addtimer(CALLBACK(src, PROC_REF(unwet_floor), TRUE), rand(1 MINUTES, 1.5 MINUTES), TIMER_UNIQUE|TIMER_OVERRIDE)

/turf/proc/unwet_floor(check_very_wet)
	is_wet = 0
	if(wet_overlay)
		overlays -= wet_overlay
		wet_overlay = null


/*
	Cleaning
*/

/turf/clean_blood()
	for(var/obj/effect/decal/cleanable/blood/B in contents)
		B.clean_blood()
	..()

//expects an atom containing the reagents used to clean the turf
/turf/proc/clean(atom/source, mob/user)
	var/amt = 0  // Amount of filth collected (for holy vacuum cleaner)
	if(source.reagents.has_reagent("water", 1) || source.reagents.has_reagent("cleaner", 1))
		clean_blood()
		for(var/obj/effect/O in src)
			if(istype(O,/obj/effect/decal/cleanable) || istype(O,/obj/effect/overlay))
				amt++
				qdel(O)
		if(ishuman(user) && user.stats && user.stats.getPerk(/datum/perk/neat))
			var/mob/living/carbon/human/H = user
			if(H.sanity)
				H.sanity.changeLevel(0.5)
	else
		to_chat(user, SPAN_WARNING("\The [source] is too dry to wash that."))
	source.reagents.trans_to_turf(src, 1, 10)	//10 is the multiplier for the reaction effect. probably needed to wet the floor properly.
	return amt

/turf/proc/clean_ultimate(var/mob/user)
	clean_blood()
	for(var/obj/effect/O in src)
		if(istype(O,/obj/effect/decal/cleanable) || istype(O,/obj/effect/overlay))
			qdel(O)

//As above, but has limitations. Instead of cleaning the tile completely, it just cleans [count] number of things
/turf/proc/clean_partial(atom/source, mob/user, var/count = 1)
	if (!count)
		return

	//A negative value can mean infinite cleaning, but in that case just call the unlimited version
	if (!isnum(count) || count < 0)
		clean(source, user)
		return

	if(source.reagents.has_reagent("water", 1) || source.reagents.has_reagent("cleaner", 1))
		source.reagents.trans_to_turf(src, 1, 10)
	else
		to_chat(user, SPAN_WARNING("\The [source] is too dry to wash that."))
		return

	for (count;count > 0;count--)
		var/cleanedsomething = FALSE


		for(var/obj/effect/O in src)
			if(istype(O,/obj/effect/decal/cleanable) || istype(O,/obj/effect/overlay))
				qdel(O)
				cleanedsomething = TRUE
				break //Only clean one per loop iteration

		//If the tile is clean, don't keep looping
		if (!cleanedsomething)
			break

/turf/proc/update_blood_overlays()
	return








/turf/proc/AddTracks(typepath, bloodDNA, comingdir, goingdir, bloodcolor="#A10808")
	var/obj/effect/decal/cleanable/blood/tracks/tracks = locate(typepath) in src
	if(!tracks)
		tracks = new typepath(src)
	tracks.AddTracks(bloodDNA,comingdir,goingdir,bloodcolor)


//returns 1 if made bloody, returns 0 otherwise
/turf/add_blood(mob/living/carbon/human/M as mob)
	if (!..())
		return 0

	if(istype(M))
		for(var/obj/effect/decal/cleanable/blood/B in contents)
			if(!B.blood_DNA)
				B.blood_DNA = list()
			if(!B.blood_DNA[M.dna_trace])
				B.blood_DNA[M.dna_trace] = M.b_type
			return 1 //we bloodied the floor
		blood_splatter(src,M.get_blood(),1)
		return 1 //we bloodied the floor
	return 0

// Only adds blood on the floor -- Skie
/turf/proc/add_blood_floor(mob/living/carbon/M as mob)
	if( istype(M, /mob/living/silicon/robot ))
		new /obj/effect/decal/cleanable/blood/oil(src)
