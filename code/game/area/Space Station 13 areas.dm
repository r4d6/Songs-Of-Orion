/*

### This file contains a list of all the areas in your station. Format is as follows:

/area/CATEGORY/OR/DESCRIPTOR/NAME 	(you can make as many subdivisions as you want)
	name = "NICE NAME" 				(not required but makes things really nice)
	icon = "ICON FILENAME" 			(defaults to areas.dmi)
	icon_state = "NAME OF ICON" 	(defaults to "unknown" (blank))
	requires_power = FALSE 				(defaults to 1)

NOTE: there are two lists of areas in the end of this file: centcom and station itself. Please maintain these lists valid. --rastaf0

*/

// Special area for use in .dmm chunks that compose randomly generated maps
/area/template_noop
	name = "Area Passthrough"


/area/space
	name = "\improper Space"
	icon_state = "space"
	requires_power = TRUE
	always_unpowered = TRUE
	dynamic_lighting = TRUE
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	has_gravity = FALSE
	flags = AREA_FLAG_EXTERNAL
	ambience = list('sound/ambience/ambispace.ogg','sound/ambience/spaceambient1.ogg','sound/ambience/spaceambient2.ogg','sound/ambience/spaceambient3.ogg','sound/ambience/spaceambient4.ogg','sound/ambience/spaceambient5.ogg','sound/ambience/spaceambient6.ogg')
	vessel = null

area/space/atmosalert()
	return

/area/space/fire_alert()
	return

/area/space/fire_reset()
	return

/area/space/readyalert()
	return

/area/space/partyalert()
	return

/area/turret_protected
	flags = AREA_FLAG_CRITICAL

/area/arrival
	requires_power = FALSE

/area/arrival/start
	name = "\improper Arrival Area"
	icon_state = "start"

/area/admin
	name = "\improper Admin room"
	icon_state = "start"



////////////
//SHUTTLES//
////////////
//shuttle areas must contain at least two areas in a subgroup if you want to move a shuttle from one
//place to another. Look at escape shuttle for example.
//All shuttles should now be under shuttle since we have smooth-wall code.

/area/shuttle
	requires_power = FALSE
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/space

/area/shuttle/arrival
	name = "\improper Arrival Shuttle"

/area/shuttle/arrival/pre_game
	icon_state = "shuttle2"

/area/shuttle/arrival/station
	icon_state = "shuttle"

/area/shuttle/escape
	name = "\improper Emergency Shuttle"
	flags = AREA_FLAG_RAD_SHIELDED

/area/shuttle/escape/station
	name = "\improper Emergency Shuttle Station"
	icon_state = "shuttle2"

/area/shuttle/escape/centcom
	name = "\improper Emergency Shuttle Centcom"
	icon_state = "shuttle"

/area/shuttle/escape/transit // the area to pass through for 3 minute transit
	name = "\improper Emergency Shuttle Transit"
	icon_state = "shuttle"

/area/shuttle/escape_pod1
	name = "\improper Escape Pod One"
	flags = AREA_FLAG_RAD_SHIELDED
	ship_area = TRUE

/area/shuttle/escape_pod1/station
	icon_state = "shuttle2"

/area/shuttle/escape_pod1/centcom
	icon_state = "shuttle"

/area/shuttle/escape_pod1/transit
	icon_state = "shuttle"

/area/shuttle/escape_pod2
	name = "\improper Escape Pod Two"
	flags = AREA_FLAG_RAD_SHIELDED

/area/shuttle/escape_pod2/station
	icon_state = "shuttle2"
	ship_area = TRUE

/area/shuttle/escape_pod2/centcom
	icon_state = "shuttle"

/area/shuttle/escape_pod2/transit
	icon_state = "shuttle"

/area/shuttle/escape_pod3
	name = "\improper Escape Pod Three"
	flags = AREA_FLAG_RAD_SHIELDED

/area/shuttle/escape_pod3/station
	icon_state = "shuttle2"

/area/shuttle/escape_pod3/centcom
	icon_state = "shuttle"

/area/shuttle/escape_pod3/transit
	icon_state = "shuttle"

/area/shuttle/escape_pod5 //Pod 4 was lost to meteors
	name = "\improper Escape Pod Five"
	flags = AREA_FLAG_RAD_SHIELDED

/area/shuttle/escape_pod5/station
	icon_state = "shuttle2"

/area/shuttle/escape_pod5/centcom
	icon_state = "shuttle"

/area/shuttle/escape_pod5/transit
	icon_state = "shuttle"

/area/shuttle/mining
	name = "\improper Mining Shuttle"

/area/shuttle/mining/station
	icon_state = "shuttle2"
	requires_power = TRUE
	ship_area = TRUE

/area/shuttle/mining/outpost
	icon_state = "shuttle"
	requires_power = TRUE
	base_turf = /turf/floor/asteroid

/area/shuttle/transport1/centcom
	icon_state = "shuttle"
	name = "\improper Transport Shuttle Centcom"

/area/shuttle/transport1/station
	icon_state = "shuttle"
	name = "\improper Transport Shuttle"

/area/shuttle/alien/base
	icon_state = "shuttle"
	name = "\improper Alien Shuttle Base"
	requires_power = TRUE

/area/shuttle/alien/mine
	icon_state = "shuttle"
	name = "\improper Alien Shuttle Mine"
	requires_power = TRUE

/area/shuttle/prison/
	name = "\improper Prison Shuttle"

/area/shuttle/prison/station
	icon_state = "shuttle"

/area/shuttle/prison/prison
	icon_state = "shuttle2"

/area/shuttle/specops/centcom
	name = "\improper Special Ops Shuttle"
	flags = AREA_FLAG_RAD_SHIELDED

/area/shuttle/specops/centcom
	icon_state = "shuttlered"

/area/shuttle/specops/station
	icon_state = "shuttlered2"

/area/shuttle/mercenary
	name = "\improper Mercenary Ship"
	flags = AREA_FLAG_RAD_SHIELDED

/area/shuttle/pirate
	name = "\improper Pirate Ship"
	flags = AREA_FLAG_RAD_SHIELDED

/area/shuttle/syndicate_elite/mothership
	icon_state = "shuttlered"

/area/shuttle/syndicate_elite/station
	icon_state = "shuttlered2"

/area/shuttle/administration
	flags = AREA_FLAG_RAD_SHIELDED

/area/shuttle/administration/centcom
	name = "\improper Administration Shuttle Centcom"
	icon_state = "shuttlered"

/area/shuttle/administration/station
	name = "\improper Administration Shuttle"
	icon_state = "shuttlered2"

/area/shuttle/thunderdome
	name = "honk"

/area/shuttle/thunderdome/grnshuttle
	name = "\improper Thunderdome GRN Shuttle"
	icon_state = "green"

/area/shuttle/thunderdome/grnshuttle/dome
	name = "\improper GRN Shuttle"
	icon_state = "shuttlegrn"

/area/shuttle/thunderdome/grnshuttle/station
	name = "\improper GRN Station"
	icon_state = "shuttlegrn2"

/area/shuttle/thunderdome/redshuttle
	name = "\improper Thunderdome RED Shuttle"
	icon_state = "red"

/area/shuttle/thunderdome/redshuttle/dome
	name = "\improper RED Shuttle"
	icon_state = "shuttlered"

/area/shuttle/thunderdome/redshuttle/station
	name = "\improper RED Station"
	icon_state = "shuttlered2"
// === Trying to remove these areas:

/area/shuttle/research
	name = "\improper Research Shuttle"

/area/shuttle/research/station
	icon_state = "shuttle2"
	requires_power = TRUE
	ship_area = TRUE

/area/shuttle/research/outpost
	icon_state = "shuttle"
	requires_power = TRUE
	base_turf = /turf/floor/asteroid



// CENTCOM

/area/centcom
	name = "\improper Centcom"
	icon_state = "centcom"
	requires_power = FALSE
	dynamic_lighting = 0
	vessel = "centcom"

/area/centcom/control
	name = "\improper Centcom Control"

/area/centcom/evac
	name = "\improper Centcom Emergency Shuttle"

/area/centcom/suppy
	name = "\improper Centcom Supply Shuttle"

/area/centcom/ferry
	name = "\improper Centcom Transport Shuttle"

/area/centcom/shuttle
	name = "\improper Centcom Administration Shuttle"

/area/centcom/test
	name = "\improper Centcom Testing Facility"

/area/centcom/living
	name = "\improper Centcom Living Quarters"

/area/centcom/specops
	name = "\improper Centcom Special Ops"

/area/centcom/creed
	name = "Creed's Office"

/area/centcom/holding
	name = "\improper Holding Facility"

/area/centcom/alien
	name = "\improper Alien base"
	icon_state = "yellow"
	requires_power = FALSE
	vessel = "alien"

/area/centcom/merc_base
	name = "\improper Mercenary Base"
	icon_state = "syndie-ship"
	requires_power = FALSE
	dynamic_lighting = 0
	vessel = "syndicate mothership"

/area/centcom/pirate_base
	name = "\improper Pirate Base"
	icon_state = "syndie-ship"
	requires_power = FALSE
	dynamic_lighting = 0
	vessel = "pirate mothership"

/area/centcom/raider_base
	name = "\improper Raider Base"
	icon_state = "syndie-control"

/area/centcom/small_base
	name = "\improper Unused base"
	icon_state = "syndie-elite"

/area/testing/first
	name = "testing one"

/area/testing/second
	name = "testing two"

/area/testing/third
	name = "testing three"



//EXTRA

/area/outpost/pulsar
	name = "\improper Pulsar Satellite Core"
	icon_state = "engineering"
	area_light_color = COLOR_LIGHTING_SCI_BRIGHT
	requires_power = FALSE
	dynamic_lighting = TRUE
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	ambience = list('sound/ambience/technoambient1.ogg','sound/ambience/technoambient2.ogg',
					'sound/ambience/technoambient3.ogg','sound/ambience/technoambient4.ogg',
					'sound/ambience/technoambient5.ogg','sound/ambience/technoambient6.ogg')

/area/outpost/pulsar/maintenance
	name = "\improper Pulsar Satellite Maintenance"
	icon_state = "engineering_storage"
	area_light_color = COLOR_LIGHTING_SCI_DARK

/area/outpost/pulsar/shuttle
	name = "\improper Pulsar Satellite Shuttle"
	icon_state = "engine_eva"
	area_light_color = null
	dynamic_lighting = FALSE

/area/asteroid					// -- TLE
	name = "\improper Moon"
	icon_state = "asteroid"
	requires_power = FALSE
	sound_env = ASTEROID

/area/asteroid/cave				// -- TLE
	name = "\improper Moon - Underground"
	icon_state = "cave"
	requires_power = FALSE
	sound_env = ASTEROID
	flags = AREA_FLAG_RAD_SHIELDED

/area/asteroid/artifactroom
	name = "\improper Moon - Artifact"
	icon_state = "cave"
	sound_env = SMALL_ENCLOSED

/area/wizard_station
	name = "\improper Wizard's Den"
	icon_state = "yellow"
	requires_power = FALSE
	dynamic_lighting = 0

/area/holodeck
	name = "\improper Holodeck"
	icon_state = "Holodeck"
	sound_env = LARGE_ENCLOSED
	requires_power = FALSE
	var/obj/machinery/computer/HolodeckControl/linked_console

/area/holodeck/powered(chan)		// return true if the area has power to given channel

	if(linked_console && linked_console.active)
		return TRUE // If the linked console is active, we are always powered
	. = ..()

//We'll assume holodecks have their own private gravity/antigrav generator, and are thus immune to any changes in gravity elsewhere
//This proc checks and sets nothing. Gravity will be set directly on the area from a nearby holodeck console
/area/holodeck/update_gravity()
	//Always assume it changed whenever this is called
	gravity_changed()

/area/holodeck/alphadeck
	name = "\improper Holodeck Alpha"
	sound_env = LARGE_ENCLOSED
	ship_area = TRUE

/area/holodeck/source
	name = "\improper Holodeck - Nonexistent"
	atmos = FALSE // So open spaces don't lose air
	no_air = TRUE // Make there be no air to lose either

/area/holodeck/source/off
	name = "\improper Holodeck - Off"

/area/holodeck/source/spacebar
	name = "\improper Holodeck - Spacebar"
	sound_env = LARGE_SOFTFLOOR

/area/holodeck/source/wireframe
	name = "\improper Holodeck - Wireframe Bar"
	sound_env = TUNNEL_ENCLOSED
	has_gravity = FALSE

/area/holodeck/source/texas
	name = "\improper Holodeck - Texas Saloon"
	sound_env = AUDITORIUM

/area/holodeck/source/industrial
	name = "\improper Holodeck - Industrial Bar"
	sound_env = LARGE_ENCLOSED

/area/holodeck/source/industrial_arena
	name = "\improper Holodeck - Industrial arena"
	sound_env = LARGE_ENCLOSED

/*
/area/holodeck/source_emptycourt
	name = "\improper Holodeck - Empty Court"
	sound_env = ARENA

/area/holodeck/source_boxingcourt
	name = "\improper Holodeck - Boxing Court"
	sound_env = ARENA

/area/holodeck/source_basketball
	name = "\improper Holodeck - Basketball Court"
	sound_env = ARENA

/area/holodeck/source_thunderdomecourt
	name = "\improper Holodeck - Thunderdome Court"
	sound_env = ARENA

/area/holodeck/source_courtroom
	name = "\improper Holodeck - Courtroom"
	sound_env = AUDITORIUM

/area/holodeck/source_beach
	name = "\improper Holodeck - Beach"
	sound_env = PLAIN

/area/holodeck/source_burntest
	name = "\improper Holodeck - Atmospheric Burn Test"

/area/holodeck/source_wildlife
	name = "\improper Holodeck - Wildlife Simulation"

/area/holodeck/source_picnicarea
	name = "\improper Holodeck - Picnic Area"
	sound_env = PLAIN

/area/holodeck/source_snowfield
	name = "\improper Holodeck - Snow Field"
	sound_env = FOREST

/area/holodeck/source_desert
	name = "\improper Holodeck - Desert"
	sound_env = PLAIN

/area/holodeck/source_space
	name = "\improper Holodeck - Space"
	has_gravity = 0
	sound_env = SPACE

/area/holodeck/source_meetinghall
	name = "\improper Holodeck - Meeting Hall"
	sound_env = AUDITORIUM

/area/holodeck/source_theatre
	name = "\improper Holodeck - Theatre"
	sound_env = CONCERT_HALL
*/

//DJSTATION

/area/djstation
	name = "\improper Listening Post"
	icon_state = "LP"

/area/djstation/solars
	name = "\improper Listening Post Solars"
	icon_state = "LPS"

//DERELICT

/area/derelict
	name = "\improper Derelict Station"
	icon_state = "storage"

/area/derelict/hallway/primary
	name = "\improper Derelict Primary Hallway"
	icon_state = "hallP"

/area/derelict/hallway/secondary
	name = "\improper Derelict Secondary Hallway"
	icon_state = "hallS"

/area/derelict/arrival
	name = "\improper Derelict Arrival Centre"
	icon_state = "yellow"

/area/derelict/storage/equipment
	name = "Derelict Equipment Storage"

/area/derelict/storage/storage_access
	name = "Derelict Storage Access"

/area/derelict/storage/engine_storage
	name = "Derelict Engine Storage"
	icon_state = "green"

/area/derelict/bridge
	name = "\improper Derelict Control Room"
	icon_state = "bridge"

/area/derelict/secret
	name = "\improper Derelict Secret Room"
	icon_state = "library"

/area/derelict/bridge/access
	name = "Derelict Control Room Access"
	icon_state = "auxstorage"

/area/derelict/bridge/ai_upload
	name = "\improper Derelict Computer Core"
	icon_state = "ai"

/area/derelict/solar_control
	name = "\improper Derelict Solar Control"
	icon_state = "engine"

/area/derelict/crew_quarters
	name = "\improper Derelict Crew Quarters"
	icon_state = "fitness"

/area/derelict/medical
	name = "Derelict Medbay"
	icon_state = "medbay"

/area/derelict/medical/morgue
	name = "\improper Derelict Morgue"
	icon_state = "morgue"

/area/derelict/medical/chapel
	name = "\improper Derelict Chapel"
	icon_state = "chapel"

/area/derelict/teleporter
	name = "\improper Derelict Teleporter"
	icon_state = "teleporter"

/area/derelict/eva
	name = "Derelict EVA Storage"
	icon_state = "eva"

/area/derelict/ship
	name = "\improper Abandoned Ship"
	icon_state = "yellow"

/area/derelict/singularity_engine
	name = "\improper Derelict Singularity Engine"
	icon_state = "engine"





//AI

/area/ai_monitored/storage/eva
	name = "EVA Storage"
	icon_state = "eva"

/area/ai_monitored/storage/secure
	name = "Secure Storage"
	icon_state = "storage"

/area/ai_monitored/storage/emergency
	name = "Emergency Storage"
	icon_state = "storage"

/area/turret_protected/ai_upload
	name = "\improper AI Upload Chamber"
	icon_state = "ai_upload"
	ambience = list('sound/ambience/ambimalf.ogg')

/area/turret_protected/ai_upload_foyer
	name = "AI Upload Access"
	icon_state = "ai_foyer"
	ambience = list('sound/ambience/ambimalf.ogg','sound/ambience/aicoreambient.ogg')
	sound_env = SMALL_ENCLOSED
	ship_area = TRUE

/area/turret_protected/ai_server_room
	name = "Messaging Server Room"
	icon_state = "ai_server"
	sound_env = SMALL_ENCLOSED
	flags = AREA_FLAG_CRITICAL

/area/turret_protected/ai
	name = "\improper AI Chamber"
	icon_state = "ai_chamber"
	ambience = list('sound/ambience/ambimalf.ogg','sound/ambience/aicoreambient.ogg')
	flags = AREA_FLAG_CRITICAL
	ship_area = TRUE

/area/turret_protected/ai_cyborg_station
	name = "\improper Cyborg Station"
	icon_state = "ai_cyborg"
	sound_env = SMALL_ENCLOSED

/area/turret_protected/aisat
	name = "\improper AI Satellite"
	icon_state = "ai"

/area/turret_protected/aisat_interior
	name = "\improper AI Satellite"
	icon_state = "ai"

/area/turret_protected/AIsatextFP
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	dynamic_lighting = 0

/area/turret_protected/AIsatextFS
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	dynamic_lighting = 0

/area/turret_protected/AIsatextAS
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	dynamic_lighting = 0

/area/turret_protected/AIsatextAP
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	dynamic_lighting = 0

/area/turret_protected/NewAIMain
	name = "\improper AI Main New"
	icon_state = "storage"



//Misc


/area/wreck/ai
	name = "\improper AI Chamber"
	icon_state = "ai"

/area/wreck/main
	name = "\improper Wreck"
	icon_state = "storage"

/area/wreck/engineering
	name = "\improper Power Room"
	icon_state = "engine"

/area/wreck/bridge
	name = "\improper Bridge"
	icon_state = "bridge"





// Away Missions
/area/awaymission
	name = "\improper Strange Location"
	icon_state = "away"

/area/awaymission/example
	name = "\improper Strange Station"
	icon_state = "away"

/area/awaymission/wwmines
	name = "\improper Wild West Mines"
	icon_state = "away1"
	luminosity = 1
	requires_power = FALSE

/area/awaymission/wwgov
	name = "\improper Wild West Mansion"
	icon_state = "away2"
	luminosity = 1
	requires_power = FALSE

/area/awaymission/wwrefine
	name = "\improper Wild West Refinery"
	icon_state = "away3"
	luminosity = 1
	requires_power = FALSE

/area/awaymission/wwvault
	name = "\improper Wild West Vault"
	icon_state = "away3"

/area/awaymission/wwvaultdoors
	name = "\improper Wild West Vault Doors"  // this is to keep the vault area being entirely lit because of requires_power
	icon_state = "away2"
	requires_power = FALSE

/area/awaymission/desert
	name = "Mars"
	icon_state = "away"

/area/awaymission/BMPship1
	name = "\improper Aft Block"
	icon_state = "away1"

/area/awaymission/BMPship2
	name = "\improper Midship Block"
	icon_state = "away2"

/area/awaymission/BMPship3
	name = "\improper Fore Block"
	icon_state = "away3"

/area/awaymission/spacebattle
	name = "\improper Space Battle"
	icon_state = "away"
	requires_power = FALSE

/area/awaymission/spacebattle/cruiser
	name = "\improper NanoTrasen Cruiser"

/area/awaymission/spacebattle/syndicate1
	name = "\improper Syndicate Assault Ship 1"

/area/awaymission/spacebattle/syndicate2
	name = "\improper Syndicate Assault Ship 2"

/area/awaymission/spacebattle/syndicate3
	name = "\improper Syndicate Assault Ship 3"

/area/awaymission/spacebattle/syndicate4
	name = "\improper Syndicate War Sphere 1"

/area/awaymission/spacebattle/syndicate5
	name = "\improper Syndicate War Sphere 2"

/area/awaymission/spacebattle/syndicate6
	name = "\improper Syndicate War Sphere 3"

/area/awaymission/spacebattle/syndicate7
	name = "\improper Syndicate Fighter"

/area/awaymission/spacebattle/secret
	name = "\improper Hidden Chamber"

/area/awaymission/listeningpost
	name = "\improper Listening Post"
	icon_state = "away"
	requires_power = FALSE

/area/awaymission/beach
	name = "Beach"
	icon_state = "null"
	luminosity = 1
	dynamic_lighting = 0
	requires_power = FALSE
	ambience = list()
	var/sound/mysound

	New()
		..()
		var/sound/S = new/sound()
		mysound = S
		S.file = 'sound/ambience/shore.ogg'
		S.repeat = 1
		S.wait = 0
		S.channel = 123
		S.volume = 100
		S.priority = 255
		S.status = SOUND_UPDATE
		Process()

	Entered(atom/movable/Obj,atom/OldLoc)
		if(ismob(Obj))
			if(Obj:client)
				mysound.status = SOUND_UPDATE
				Obj << mysound
		return

	Exited(atom/movable/Obj)
		if(ismob(Obj))
			if(Obj:client)
				mysound.status = SOUND_PAUSED | SOUND_UPDATE
				Obj << mysound

	Process()
		set background = 1

		var/sound/S
		var/sound_delay = 0
		if(prob(25))
			S = sound(file=pick('sound/ambience/seag1.ogg','sound/ambience/seag2.ogg','sound/ambience/seag3.ogg'), volume=100)
			sound_delay = rand(0, 50)

		for(var/mob/living/carbon/human/H in src)
			if(H.s_tone > -55)
				H.s_tone--
				H.update_body()
			if(H.client)
				mysound.status = SOUND_UPDATE
				H << mysound
				if(S)
					spawn(sound_delay)
						H << S

		spawn(60) .()

/////////////////////////////////////////////////////////////////////
/*
Lists of areas to be used with is_type_in_list.
Used in gamemodes code at the moment. --rastaf0
*/

// CENTCOM
var/list/centcom_areas = list (
	/area/centcom,
	/area/shuttle/escape/centcom,
	/area/shuttle/escape_pod1/centcom,
	/area/shuttle/escape_pod2/centcom,
	/area/shuttle/escape_pod3/centcom,
	/area/shuttle/escape_pod5/centcom,
	/area/shuttle/transport1/centcom,
	/area/shuttle/administration/centcom,
	/area/shuttle/specops/centcom,
)


//Rouguelike Mining
/area/asteroid/rogue
	icon_state = "away"
	name = "Asteroid Belt"
	var/asteroid_spawns = list()
	var/mob_spawns = list()
	var/teleporter_spawns = list()
	var/teleporter

/area/deepmaint
	icon_state = "away"
	name = "Deep Maintenance"
	sound_env = TUNNEL_ENCLOSED
	turf_initializer = new /datum/turf_initializer/maintenance()
	forced_ambience = list('sound/ambience/maintambience.ogg')
	base_turf = /turf/floor/tiled
	has_gravity = 1
	requires_power = FALSE
	area_light_color = COLOR_LIGHTING_MAINT_DARK


/datum/turf_initializer/proc/Initialize(turf/T)
	return

/datum/turf_initializer/maintenance/Initialize(turf/T)
	if(T.density)
		return
	// Quick and dirty check to avoid placing things inside windows
	if(locate(/obj/structure/grille, T))
		return

	var/cardinal_turfs = T.CardinalTurfs()

	if(prob(2))
		var/path = junk()
		new path(T)
	if(prob(2))
		new /obj/effect/decal/cleanable/blood/oil(T)
	if(prob(1))
		new /mob/living/simple_animal/mouse(T)
	if(prob(25))	// Keep in mind that only "corners" get any sort of web
		attempt_web(T, cardinal_turfs)

var/global/list/random_junk
/datum/turf_initializer/maintenance/proc/junk()
	if(prob(25))
		return /obj/effect/decal/cleanable/generic
	if(!random_junk)
		random_junk = subtypesof(/obj/item/trash)
		random_junk += /obj/effect/decal/cleanable/spiderling_remains
		random_junk += /obj/item/remains/mouse
		random_junk += /obj/item/remains/robot
		random_junk -= /obj/item/trash/material
		random_junk -= /obj/item/trash/plate
		random_junk -= /obj/item/trash/snack_bowl
		random_junk -= /obj/item/trash/wok
		random_junk -= /obj/item/trash/tray
	return pick(random_junk)

/datum/turf_initializer/maintenance/proc/attempt_web(turf/T)
	var/turf/north_turf = get_step(T, NORTH)
	if(!north_turf || !north_turf.density)
		return

	for(var/dir in list(WEST, EAST))	// For the sake of efficiency, west wins over east in the case of 1-tile valid spots, rather than doing pick()
		var/turf/neighbour = get_step(T, dir)
		if(neighbour && neighbour.density)
			if(dir == WEST)
				new /obj/effect/decal/cleanable/cobweb(T)
			if(dir == EAST)
				new /obj/effect/decal/cleanable/cobweb2(T)
			return

