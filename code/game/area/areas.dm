#define STARTUP_STAGE 1
#define MAIN_STAGE 2
#define WIND_DOWN_STAGE 3
#define END_STAGE 4

/area
	name = "Unknown"
	icon = 'icons/turf/areas.dmi'
	icon_state = "unknown"
	plane = BLACKNESS_PLANE // Keeping this on the default plane, GAME_PLANE, will make area overlays fail to render on FLOOR_PLANE
	layer = AREA_LAYER
	level = null
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	luminosity = TRUE
	var/dynamic_lighting = TRUE
	var/lightswitch = TRUE
	var/fire
	var/atmos = TRUE
	var/atmosalm = FALSE
	var/poweralm = TRUE
	var/party
	var/eject
	var/is_maintenance = FALSE
	var/debug = 0
	var/area_light_color		//Used by lights to create different light on different departments and locations
	var/has_gravity = 1
	var/cached_gravity = 1		//stores updated has_gravity even if it's blocked
	var/no_air
	var/air_doors_activated = 0
	var/sound_env = STANDARD_STATION
	var/holomap_color // Color of this area on station holomap
	var/vessel = "CEV Eris" // Consoles can only control shields on the same vessel as them
	var/ship_area = FALSE

	var/requires_power = TRUE
	var/always_unpowered = FALSE
	var/power_light = TRUE
	var/power_equip = TRUE
	var/power_environ = TRUE

	var/used_equip = 0
	var/used_light = 0
	var/used_environ = 0

	var/static_equip
	var/static_light = 0
	var/static_environ

	var/bluespace_entropy = 0
	var/bluespace_hazard_threshold = 100

	var/uid
	var/global/global_uid = 0
	var/tmp/camera_id = 0 // For automatic c_tag setting

	var/list/air_vent_names = list()
	var/list/air_scrub_names = list()
	var/list/air_vent_info = list()
	var/list/air_scrub_info = list()
	var/list/turret_controls = list() // Turrets use this list to see if individual power/lethal settings are allowed
	var/list/all_doors = list()		//Added by Strumpetplaya - Alarm Change - Contains a list of doors adjacent to this area
	var/list/ambience = list('sound/ambience/ambigen1.ogg','sound/ambience/ambigen3.ogg','sound/ambience/ambigen4.ogg','sound/ambience/ambigen5.ogg','sound/ambience/ambigen6.ogg','sound/ambience/ambigen7.ogg','sound/ambience/ambigen8.ogg','sound/ambience/ambigen9.ogg','sound/ambience/ambigen10.ogg','sound/ambience/ambigen11.ogg','sound/ambience/ambigen12.ogg','sound/ambience/ambigen14.ogg')
	var/list/forced_ambience

	// Each area may have at most one media source that plays songs into that area.
	// We keep track of that source so any mob entering the area can lookup what to play.
	var/atom/gravity_blocker	//ref to antigrav
	var/turf/base_turf //The base turf type of the area, which can be used to override the z-level's base turf
	var/obj/machinery/media/media_source = null
	var/obj/machinery/power/apc/apc
	var/obj/machinery/alarm/master_air_alarm
	var/datum/turf_initializer/turf_initializer = null
	var/datum/area_sanity/sanity

/**
 * Called when an area loads
 */
/area/New()
	uid = ++global_uid
	SSmapping.all_areas |= src
	SSmapping.all_areas_by_name[name] = src

	if(ship_area)
		SSmapping.main_ship_areas |= src
		SSmapping.main_ship_areas_by_name[name] = src

	// Some atoms would like to use power in Initialize()
	if(!requires_power)
		power_light = FALSE
		power_equip = FALSE
		power_environ = FALSE

	sanity = new(src)

	if(dynamic_lighting)
		luminosity = FALSE

	. = ..()

/*
 * Initalize this area
 *
 * returns INITIALIZE_HINT_LATELOAD
 */
/area/Initialize()
	icon_state = ""

	if(!requires_power || !apc)
		power_light = FALSE
		power_equip = FALSE
		power_environ = FALSE

	for(var/turf/T in src)
		if(turf_initializer)
			turf_initializer.Initialize(T)

	..()
	return INITIALIZE_HINT_LATELOAD

/**
 * Sets machine power levels in the area
 */
/area/LateInitialize()
	power_change() // all machines set to current power level, also updates icon

/area/proc/get_cameras()
	var/list/cameras = list()
	for(var/obj/machinery/camera/C in src)
		cameras += C
	return cameras

/area/proc/get_camera_tag(var/obj/machinery/camera/C)
	return "[name] #[camera_id++]"

/area/proc/atmosalert(danger_level, var/alarm_source)
	if(danger_level == 0)
		atmosphere_alarm.clearAlarm(src, alarm_source)
	else
		atmosphere_alarm.triggerAlarm(src, alarm_source, severity = danger_level)

	//Check all the alarms before lowering atmosalm. Raising is perfectly fine.
	for(var/obj/machinery/alarm/AA in src)
		if(!(AA.stat & (NOPOWER|BROKEN)) && !AA.shorted && AA.report_danger_level)
			danger_level = max(danger_level, AA.danger_level)

	if(danger_level != atmosalm)
		if(danger_level < 1 && atmosalm >= 1)
			//closing the doors on red and opening on green provides a bit of hysteresis that will hopefully prevent fire doors from opening and closing repeatedly due to noise
			air_doors_open()
		else if(danger_level >= 2 && atmosalm < 2)
			air_doors_close()

		atmosalm = danger_level
		for(var/obj/machinery/alarm/AA in src)
			AA.update_icon()

		return 1
	return 0

/area/proc/air_doors_close()
	if(!air_doors_activated)
		air_doors_activated = 1
		for(var/obj/machinery/door/firedoor/D in all_doors)
			D.close()

/area/proc/air_doors_open()
	if(air_doors_activated)
		air_doors_activated = 0
		for(var/obj/machinery/door/firedoor/D in all_doors)
			D.open()


/area/proc/fire_alert()
	if(!fire)
		fire = 1	//used for firedoor checks
		updateicon()
		mouse_opacity = 0
		for(var/obj/machinery/door/firedoor/D in all_doors)
			D.close()

/area/proc/fire_reset()
	if(fire)
		fire = 0	//used for firedoor checks
		updateicon()
		mouse_opacity = 0
		for(var/obj/machinery/door/firedoor/D in all_doors)
			D.open()

/area/proc/readyalert()
	if(!eject)
		eject = 1
		updateicon()
	return

/area/proc/readyreset()
	if(eject)
		eject = 0
		updateicon()
	return

/area/proc/partyalert()
	if(!( party ))
		party = 1
		updateicon()
		mouse_opacity = 0
	return

/area/proc/partyreset()
	if(party)
		party = 0
		mouse_opacity = 0
		updateicon()
		for(var/obj/machinery/door/firedoor/D in src)
			D.open()
	return

/area/proc/updateicon()

	///////weather

	var/weather_icon
	for(var/V in SSweather.processing)
		var/datum/weather/W = V
		if(W.stage != END_STAGE && (src in get_areas(/area)))
			W.update_areas()
			weather_icon = TRUE
	if(!weather_icon)
		icon_state = null

	////////////weather

	if((fire || eject || party || atmosalm == 2) && (!requires_power||power_environ) && !istype(src, /area/space))//If it doesn't require power, can still activate this proc.
		if(fire)
			for(var/obj/machinery/light/L in src)
				if(istype(L, /obj/machinery/light/small))
					continue
				L.set_red()
		else if(atmosalm == 2)
			for(var/obj/machinery/light/L in src)
				if(istype(L, /obj/machinery/light/small))
					continue
				L.set_blue()
		else if(!fire && eject && !party && !(atmosalm == 2))
			for(var/obj/machinery/light/L in src)
				if(istype(L, /obj/machinery/light/small))
					continue
				L.set_red()
		else if(party && !fire && !eject && !(atmosalm == 2))
			icon_state = "party"
	else
	//	new lighting behaviour with obj lights
		icon_state = null
		for(var/obj/machinery/light/L in src)
			if(istype(L, /obj/machinery/light/small))
				continue
			L.reset_color()


/*
#define EQUIP 1
#define LIGHT 2
#define ENVIRON 3
*/

/area/proc/powered(var/chan)		// return true if the area has power to given channel

	if(!requires_power)
		return 1
	if(always_unpowered)
		return 0
	switch(chan)
		if(STATIC_EQUIP)
			return power_equip
		if(STATIC_LIGHT)
			return power_light
		if(STATIC_ENVIRON)
			return power_environ

	return 0

// called when power status changes
/area/proc/power_change()
	for(var/obj/machinery/M in src)	// for each machine in the area
		M.power_change()			// reverify power status (to update icons etc.)
	SEND_SIGNAL_OLD(src, COMSIG_AREA_APC_POWER_CHANGE)
	if(fire || eject || party)
		updateicon()

/area/proc/usage(var/chan)
	var/used = 0
	switch(chan)
		if(TOTAL)
			used += static_light + static_equip + static_environ + used_equip + used_light + used_environ
		if(STATIC_EQUIP)
			used += static_equip + used_equip
		if(STATIC_LIGHT)
			used += static_light + used_light
		if(STATIC_ENVIRON)
			used += static_environ + used_environ
	return used

/area/proc/addStaticPower(value, powerchannel)
	switch(powerchannel)
		if(STATIC_EQUIP)
			static_equip += value
		if(STATIC_LIGHT)
			static_light += value
		if(STATIC_ENVIRON)
			static_environ += value

/area/proc/removeStaticPower(value, powerchannel)
	addStaticPower(-value, powerchannel)

/area/proc/clear_usage()
	used_equip = 0
	used_light = 0
	used_environ = 0

/area/proc/use_power(var/amount, var/chan)
	switch(chan)
		if(STATIC_EQUIP)
			used_equip += amount
		if(STATIC_LIGHT)
			used_light += amount
		if(STATIC_ENVIRON)
			used_environ += amount


var/list/mob/living/forced_ambiance_list = new

/area/Entered(A)
	if(!isliving(A))
		return

	var/mob/living/L = A
	if(!L.ckey)	return

	if(!L.lastarea)
		L.lastarea = get_area(L.loc)
	var/area/newarea = get_area(L.loc)
	var/area/oldarea = L.lastarea
	if(oldarea.has_gravity != newarea.has_gravity)
		if(newarea.has_gravity == 1 && !MOVING_DELIBERATELY(L)) // Being ready when you change areas allows you to avoid falling.
			thunk(L)
		L.update_floating()

	L.lastarea = newarea
	play_ambience(L)

/area/proc/play_ambience(var/mob/living/L)
	// Ambience goes down here -- make sure to list each area seperately for ease of adding things in later, thanks! Note: areas adjacent to each other should have the same sounds to prevent cutoff when possible.- LastyScratch
	if(!(L && L.client && L.get_preference_value(/datum/client_preference/play_ambiance) == GLOB.PREF_YES))
		return

	var/client/CL = L.client

	if(CL.ambience_playing) // If any ambience already playing
		if(forced_ambience && forced_ambience.len)
			if(CL.ambience_playing in forced_ambience)
				return 1
			else
				var/new_ambience = pick(pick(forced_ambience))
				CL.ambience_playing = new_ambience
				sound_to(L, sound(new_ambience, repeat = 1, wait = 0, volume = 30, channel = GLOB.ambience_sound_channel))
				return 1
		if(CL.ambience_playing in ambience)
			return 1

	if(ambience.len && prob(35))
		if(world.time >= L.client.played + 600)
			var/sound = pick(ambience)
			CL.ambience_playing = sound
			sound_to(L, sound(sound, repeat = 0, wait = 0, volume = 10, channel = GLOB.ambience_sound_channel))
			L.client.played = world.time
			return 1
	else
		var/sound = 'sound/ambience/shipambience.ogg'
		CL.ambience_playing = sound
		sound_to(L, sound(sound, repeat = 1, wait = 0, volume = 30, channel = GLOB.ambience_sound_channel))


//Figures out what gravity should be and sets it appropriately
/area/proc/update_gravity()
	var/grav_before = has_gravity
	if(gravity_blocker)
		if(get_area(gravity_blocker) == src)
			has_gravity = FALSE
			if(grav_before != has_gravity)
				gravity_changed()
			return
		else
			gravity_blocker = null

	if(GLOB.active_gravity_generator)
		has_gravity = gravity_is_on

	if(grav_before != has_gravity)
		gravity_changed()



//Called when the gravity state changes
/area/proc/gravity_changed()
	for(var/mob/M in src)
		if(has_gravity)
			thunk(M)
		M.update_floating()

//This thunk should probably not be an area proc.
//TODO: Make it a mob proc
/area/proc/thunk(mob)
	if(istype(get_turf(mob), /turf/space)) // Can't fall onto nothing.
		return

	if(istype(get_turf(mob), /turf/open))
		var/turf/open/O = get_turf(mob)
		O.fallThrough(mob)
		return

	if(istype(mob,/mob/living/carbon/human/))
		var/mob/living/carbon/human/H = mob
		if(istype(H.shoes, /obj/item/clothing/shoes/magboots) && (H.shoes.item_flags & NOSLIP))
			return
		if(H.stats.getPerk(PERK_ASS_OF_CONCRETE))
			return
		if(MOVING_QUICKLY(H))
			H.AdjustStunned(2)
			H.AdjustWeakened(2)
		else
			H.AdjustStunned(1)
			H.AdjustWeakened(1)
		to_chat(mob, SPAN_NOTICE("The sudden appearance of gravity makes you fall to the floor!"))

/area/proc/prison_break()
	var/obj/machinery/power/apc/theAPC = get_apc()
	if(theAPC.operating)
		for(var/obj/machinery/power/apc/temp_apc in src)
			temp_apc.overload_lighting(70)
		for(var/obj/machinery/door/airlock/temp_airlock in src)
			temp_airlock.prison_open()
		for(var/obj/machinery/door/window/temp_windoor in src)
			temp_windoor.open()

/area/proc/has_gravity()
	return has_gravity

/area/space/has_gravity()
	return 0

/area/proc/are_living_present()
	for(var/mob/living/L in src)
		if(L.stat != DEAD)
			return TRUE
	return FALSE

/proc/has_gravity(atom/AT, turf/T)
	if(!T)
		T = get_turf(AT)
	var/area/A = get_area(T)
	if(A && A.has_gravity())
		return 1
	return 0


/area/proc/set_ship_area()
	if(!ship_area)
		ship_area = TRUE
		SSmapping.main_ship_areas |= src

/area/AllowDrop()
	CRASH("Bad op: area/AllowDrop() called")

/area/drop_location()
	CRASH("Bad op: area/drop_location() called")


// Changes the area of T to A. Do not do this manually.
// Area is expected to be a non-null instance.
/proc/ChangeArea(var/turf/T, var/area/A)
	if(!istype(A))
		CRASH("Area change attempt failed: invalid area supplied.")
	var/area/old_area = get_area(T)
	if(old_area == A)
		return
	A.contents.Add(T)
	if(old_area)
		old_area.Exited(T, A)
		for(var/atom/movable/AM in T)
			old_area.Exited(AM, A)  // Note: this _will_ raise exited events.
	A.Entered(T, old_area)
	for(var/atom/movable/AM in T)
		A.Entered(AM, old_area) // Note: this will _not_ raise moved or entered events. If you change this, you must also change everything which uses them.
