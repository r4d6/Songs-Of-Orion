//wrapper
/proc/do_teleport(ateleatom, adestination, aprecision = 0, afteleport = 1, aeffectin, aeffectout, asoundin, asoundout, no_checks = FALSE)
	new /datum/teleport/instant/science(arglist(args))
	return

/datum/teleport
	var/atom/movable/teleatom //atom to teleport
	var/atom/destination //destination to teleport to
	var/precision = 0 //teleport precision
	var/datum/effect/effect/system/effectin //effect to show right before teleportation
	var/datum/effect/effect/system/effectout //effect to show right after teleportation
	var/soundin //soundfile to play before teleportation
	var/soundout //soundfile to play after teleportation
	var/force_teleport = 1 //if false, teleport will use Move() proc (dense objects will prevent teleportation)
	var/no_checks = FALSE //Bypasses all teleportation checks, used for admin portals and pulsar portals


/datum/teleport/New(ateleatom, adestination, aprecision = 0, afteleport = 1, aeffectin, aeffectout, asoundin, asoundout, no_checks = FALSE)
	..()
	if(!initTeleport(arglist(args)))
		return 0
	return 1

/datum/teleport/proc/initTeleport(ateleatom, adestination, aprecision, afteleport, aeffectin, aeffectout, asoundin, asoundout, no_checks)
	if(!setTeleatom(ateleatom))
		return 0
	if(!setDestination(adestination))
		return 0
	if(!setPrecision(aprecision))
		return 0
	setEffects(aeffectin, aeffectout)
	setForceTeleport(afteleport)
	setSounds(asoundin, asoundout)
	setChecks(no_checks)
	return 1

//must succeed
/datum/teleport/proc/setPrecision(aprecision)
	if(isnum(aprecision))
		precision = aprecision
		return 1
	return 0

//must succeed
/datum/teleport/proc/setDestination(atom/adestination)
	if(istype(adestination))
		destination = adestination
		return 1
	return 0

//must succeed in most cases
/datum/teleport/proc/setTeleatom(atom/movable/ateleatom)
	if(istype(ateleatom))
		teleatom = ateleatom
		return 1
	return 0

//custom effects must be properly set up first for instant-type teleports
//optional
/datum/teleport/proc/setEffects(datum/effect/effect/system/aeffectin=null, datum/effect/effect/system/aeffectout=null)
	effectin = istype(aeffectin) ? aeffectin : null
	effectout = istype(aeffectout) ? aeffectout : null
	return 1

//optional
/datum/teleport/proc/setForceTeleport(afteleport)
		force_teleport = afteleport
		return 1

//optional
/datum/teleport/proc/setSounds(asoundin=null, asoundout=null)
		soundin = isfile(asoundin) ? asoundin : null
		soundout = isfile(asoundout) ? asoundout : null
		return 1

//optional
/datum/teleport/proc/setChecks(_no_checks = FALSE)
	no_checks = _no_checks

//placeholder
/datum/teleport/proc/teleportChecks()
		return 1

/datum/teleport/proc/playSpecials(atom/location, datum/effect/effect/system/effect, sound)
	if(location)
		if(effect)
			spawn(-1)
				src = null
				effect.attach(location)
				effect.start()
		if(sound)
			spawn(-1)
				src = null
				playsound(location, sound, 60, 1)
	return

//do the monkey dance
/datum/teleport/proc/doTeleport()

	var/turf/destturf
	var/turf/curturf = get_turf(teleatom)
	var/area/destarea = get_area(destination)
	if(precision)
		var/list/posturfs = circlerangeturfs(destination, precision)
		destturf = safepick(posturfs)
	else
		destturf = get_turf(destination)

	if(!destturf || !curturf)
		return 0

	playSpecials(curturf, effectin, soundin)

	var/obj/structure/bed/chair/C = null
	if(isliving(teleatom))
		var/mob/living/L = teleatom
		if(L.buckled)
			C = L.buckled
	if(force_teleport)
		teleatom.forceMove(destturf)
		playSpecials(destturf, effectout, soundout)
	else
		if(teleatom.Move(destturf))
			playSpecials(destturf, effectout, soundout)
	if(C)
		C.forceMove(destturf)

	destarea.Entered(teleatom)

	return 1

/datum/teleport/proc/teleport()
	if(no_checks || teleportChecks())
		return doTeleport()
	return 0

/datum/teleport/instant //teleports when datum is created

/datum/teleport/instant/New(ateleatom, adestination, aprecision = 0, afteleport = 1, aeffectin, aeffectout, asoundin, asoundout, no_checks = FALSE)
	if(..())
		teleport()
	return


/datum/teleport/instant/science/setEffects(datum/effect/effect/system/aeffectin, datum/effect/effect/system/aeffectout)
	if(!aeffectin || !aeffectout)
		var/datum/effect/effect/system/spark_spread/aeffect = new
		aeffect.set_up(5, 1, teleatom)
		effectin = effectin || aeffect
		effectout = effectout || aeffect
		return 1
	else
		return ..()

/datum/teleport/instant/science/setPrecision(aprecision)
	..()
	if(istype(teleatom, /obj/item/storage/backpack/holding) || istype(teleatom, /obj/item/storage/pouch/holding/) || \
		istype(teleatom, /obj/item/storage/belt/holding) || istype(teleatom, /obj/item/storage/bag/trash/holding) || \
		istype(teleatom, /obj/item/storage/bag/ore/holding))
		precision = rand(1, 100)

	var/ofholding = 0
	var/list/bagholding = teleatom.search_contents_for(/obj/item/storage/backpack/holding)
	if(bagholding.len)
		ofholding += bagholding.len
	var/list/pouchholding = teleatom.search_contents_for(/obj/item/storage/pouch/holding)
	if(pouchholding.len)
		ofholding += pouchholding.len
	var/list/beltholding = teleatom.search_contents_for(/obj/item/storage/belt/holding)
	if(beltholding.len)
		ofholding += beltholding.len
	var/list/trashholding = teleatom.search_contents_for(/obj/item/storage/bag/trash/holding)
	if(trashholding.len)
		ofholding += trashholding.len
	var/list/satchelholding = teleatom.search_contents_for(/obj/item/storage/bag/ore/holding)
	if(satchelholding.len)
		ofholding += satchelholding.len

	if(ofholding)
		GLOB.bluespace_entropy += ofholding
		precision = max(rand(1, 100)*ofholding, 100)
		if(isliving(teleatom))
			var/mob/living/MM = teleatom
			if(bagholding.len)
				to_chat(MM, SPAN_DANGER("The bluespace interface of your bag of holding interferes with the teleport!"))
			if(pouchholding.len)
				to_chat(MM, SPAN_DANGER("The bluespace interface of your pouch of holding interferes with the teleport!"))
			if(beltholding.len)
				to_chat(MM, SPAN_DANGER("The bluespace interface of your belt of holding interferes with the teleport!"))
			if(trashholding.len)
				to_chat(MM, SPAN_DANGER("The bluespace interface of your trashbag of holding interferes with the teleport!"))
			if(satchelholding.len)
				to_chat(MM, SPAN_DANGER("The bluespace interface of your satchel of holding interferes with the teleport!"))
	return 1
/datum/teleport/instant/science/teleportChecks()
	if(istype(teleatom, /obj/effect/sparks))
		return 0
	if(istype(teleatom, /obj/item/disk/nuclear)) // Don't let nuke disks get teleported --NeoFite
		teleatom.visible_message(SPAN_DANGER("\The [teleatom] bounces off of the portal!"))
		return 0

	if(!isemptylist(teleatom.search_contents_for(/obj/item/disk/nuclear)))
		if(isliving(teleatom))
			var/mob/living/MM = teleatom
			MM.visible_message(
				SPAN_DANGER("\The [MM] bounces off of the portal!"),
				SPAN_WARNING("Something you are carrying seems to be unable to pass through the portal. Better drop it if you want to go through.")
			)
		else
			teleatom.visible_message(SPAN_DANGER("\The [teleatom] bounces off of the portal!"))
		return 0

	if(IS_TECHNICAL_LEVEL(destination.z))
		if(istype(teleatom, /mob/living/exosuit))
			var/mob/living/exosuit/MM = teleatom
			MM.occupant_message(SPAN_DANGER("\The [MM.pilots.Join(" and ")] would not survive the jump to a location so far away!"))
			return 0
		if(!isemptylist(teleatom.search_contents_for(/obj/item/storage/backpack/holding)))
			teleatom.visible_message(SPAN_DANGER("\The [teleatom] bounces off of the portal!"))
			return 0

	return 1
