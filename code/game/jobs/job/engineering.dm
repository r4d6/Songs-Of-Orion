/datum/job/chief_engineer
	title = "Chief Engineer"
	flag = EXULTANT
	head_position = 1
	department = DEPARTMENT_ENGINEERING
	department_flag = ENGINEERING | COMMAND
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the Captain"
	selection_color = "#d0b04e"
	req_admin_notify = 1
	also_known_languages = list(LANGUAGE_CYRILLIC = 100)
	wage = WAGE_COMMAND
	ideal_character_age = 50

	outfit_type = /decl/hierarchy/outfit/job/engineering/exultant

	access = list(
		access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
		access_teleporter, access_network, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
		access_heads, access_construction, access_sec_doors,, access_mining, access_mining_station,
		access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload, access_change_engineering
	)

	stat_modifiers = list(
		STAT_MEC = 40,
		STAT_COG = 20,
		STAT_TGH = 15,
		STAT_VIG = 15,
	)

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/ntnetmonitor,
							 /datum/computer_file/program/power_monitor,
							 /datum/computer_file/program/alarm_monitor,
							 /datum/computer_file/program/atmos_control,
							 /datum/computer_file/program/rcon_console,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/shield_control,
							 /datum/computer_file/program/reports)

	description = "You are a distinguished middle manager, the station's Chief Engineer and representative of Astra Starworks. <br>\
You are to keep the station running and constantly improve it as much as you are able. Let none question the efficacy of your labours. The Dive Boss should be your right hand, keeping the ship supplied with materials and new components."

	loyalties = "Your first loyalty is the station. Not the concept, but the actual facilities. The engineering department is your territory, and machinery across the station are your responsibility. <br>\
	Your Engineers are equally as important, as they are your comrades and some of the only competent people in the void. Take care of them, stick up for them, and don't let their lives be spent in vain."

	perks = list(/datum/perk/inspiration)

/obj/landmark/join/start/chief_engineer
	name = "Chief Engineer"
	icon_state = "player-orange-officer"
	join_tag = /datum/job/chief_engineer


/datum/job/technomancer
	title = "Space Engineer"
	flag = TECHNOMANCER
	department = DEPARTMENT_ENGINEERING
	department_flag = ENGINEERING
	faction = "CEV Eris"
	total_positions = 3
	supervisors = "the Chief Engineer"
	selection_color = "#b18643"
	also_known_languages = list(LANGUAGE_CYRILLIC = 50)
	wage = WAGE_PROFESSIONAL
	alt_titles = list("Mechanical Engineer","Nuclear Engineer","Field Engineer","Damage Control Specialist", "Engineer")

	outfit_type = /decl/hierarchy/outfit/job/engineering/engineer

	access = list(
		access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
		access_external_airlocks, access_construction, access_atmospherics, access_mining,
		access_mining_station
	)

	stat_modifiers = list(
		STAT_MEC = 30,
		STAT_COG = 15,
		STAT_TGH = 10,
		STAT_VIG = 10,
	)

	software_on_spawn = list(/datum/computer_file/program/power_monitor,
							 /datum/computer_file/program/alarm_monitor,
							 /datum/computer_file/program/atmos_control,
							 /datum/computer_file/program/rcon_console,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/shield_control)

	description = "You are one of the few brave individuals willing and capable to crawl out of the wreckage of humanity to keep what's left running."

	duties = "	-Setup and maintain the Fission Reactor Complex.<br>\
	-Maintain logistics and power systems, keeping the lights on and the air breathable.<br>\
	-Repair anything and anyone that needs repaired.<br>\
	-Process materials and nuclear fuel to keep the ship stocked and running.<br>\
	-Conduct Damage Control and Fire Suppression operations to keep the station habitable in event of emergencies."

	loyalties = "	As an Engineer of the Starworks, your loyalty is to the Chief Engineer and the other cave-beasts of your department. <br>\
	Your second loyaty is to the station itself. She's an old bucket of bolts, but she's yours- and the literal fallout of losing her would leave you dead or worse. Avoid abandoning ship at all costs."

	perks = list(/datum/perk/inspiration)

/obj/landmark/join/start/technomancer
	name = "Engineer"
	icon_state = "player-orange"
	join_tag = /datum/job/technomancer

/datum/job/dive_boss
	title = "EVA Foremxn"
	flag = MINER
	department = DEPARTMENT_ENGINEERING
	department_flag = ENGINEERING
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the Chief Engineer"
	selection_color = "#829d72"
	wage = WAGE_PROFESSIONAL
	alt_titles = list("Dive Boss","Foreman","Dive Foreman","Pathfinder")
	also_known_languages = list(LANGUAGE_JIVE = 100, LANGUAGE_CYRILLIC = 50)

	outfit_type = /decl/hierarchy/outfit/job/engineering/foreman

	description = "You are a leader of apes, the 'Dive Boss' as you are more commonly known. Officially an Astra Starworks EVA Foremxn, you are in charge of all Extravehicular Activities.<br>\
	<br>\
	EVA is a long tradition. Expeditions to and from vacuum environments are typically called 'dives' and those who work outside the hull, 'Divers.'<br>\
	The ones who don't come back? 'Drowned.'<br>\
	Your job is to ensure that doesn't happen."

	duties = "Oversee all EVA and depressurized activities.<br>\
	Keep the Divers alive.<br>\
	Train the crew on EVA activities, micro-gravity operations, and survival in depressurized spaces.<br>\
	Lead and organize the dive team towards profit and maybe home someday."

	loyalties = "	Your first loyalty is to your team. <br>\
	Your second loyalty is to the Chief Engineer, you're supposed to be there for the Chief and his Engineers.<br>\
	Your third loyalty are to all the poor spacer fools who came up from ground-pounding to drink vacuum and drift in micro-G, you should make some attempt to train or save them when some idiot cracks a seal."

	access = list(
		access_maint_tunnels, access_mailsorting, access_mining,
		access_mining_station, access_eva, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage,
		access_heads, access_construction
	)

	stat_modifiers = list(
		STAT_ROB = 20,
		STAT_TGH = 20,
		STAT_VIG = 25,
		STAT_MEC = 15
	)

	perks = list(/datum/perk/survivor, /datum/perk/oddity/lungs_of_iron)

	software_on_spawn = list(///datum/computer_file/program/supply,
							 ///datum/computer_file/program/deck_management,
							 /datum/computer_file/program/wordprocessor,
							 /datum/computer_file/program/reports,
							 /datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/camera_monitor)

/obj/landmark/join/start/mining
	name = "Dive Boss"
	icon_state = "player-beige"
	join_tag = /datum/job/mining


/datum/job/mining
	title = "EVA Reclaimation Personnel"
	flag = MINER
	department = DEPARTMENT_ENGINEERING
	department_flag = ENGINEERING
	faction = "CEV Eris"
	total_positions = 6
	supervisors = "the Dive Boss, the Engies, and the Chief"
	selection_color = "#617953"
	wage = WAGE_LABOUR_DUMB //RIP
	alt_titles = list("Diver","Shipbreaker","Surveyor", "EVA Laborer")
	also_known_languages = list(LANGUAGE_JIVE = 100, LANGUAGE_CYRILLIC = 50)

	outfit_type = /decl/hierarchy/outfit/job/cargo/mining

	description = "You are a laborer, by choice or by force, on contract with the Astra Starworks corporation to reclaim the resouces of the local solar system.<br>\
	<br>\
	The working class of space. ERPs- more commonly known as 'Divers'- are anywhere from the so-called middle-class of spacefarer to mass-indentured debt-slaves<br>\
	Miners should be tough and physically strong, trying to turn 'disposable worker' into 'invaluable asset.'<br>\
	You should be competent in an EVA suit and in operating heavy machinery. You'll want to find some better gear if you live long enough."


	duties = "Dig up ores and minerals, process them into useable material.<br>\
	Go on away-missions to salvage and recover materials and equipment that can no longer be produced.<br>\
	Collapse burrows around the station to help fight off the roach infestation<br>\
	Protect the Engineering department and each other. "

	loyalties = "	Your first loyalty is to yourself and survival. This station is mostly just a paycheck to you<br>\
	Your second loyalty is to the Dive Boss, the EVA Foreman. You owe them something, at least."

	access = list(
		access_maint_tunnels, access_mining,
		access_mining_station, access_eva, access_construction
	)


	stat_modifiers = list(
		STAT_ROB = 15,
		STAT_TGH = 15,
		STAT_VIG = 15,
		STAT_MEC = 15
	)

	perks = list(/datum/perk/deep_connection)

	software_on_spawn = list(///datum/computer_file/program/supply,
							 ///datum/computer_file/program/deck_management,
							 /datum/computer_file/program/wordprocessor,
							 /datum/computer_file/program/reports)

/obj/landmark/join/start/mining
	name = "ERP"
	icon_state = "player-beige"
	join_tag = /datum/job/mining
