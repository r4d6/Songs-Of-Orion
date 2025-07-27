/datum/job/greytide
	title = "Assistant"
	flag = ASSISTANT
	department = DEPARTMENT_CIVILIAN
	department_flag = CIVILIAN
	faction = "CEV Eris"
	total_positions = -1
	supervisors = "anyone who pays you"
	selection_color = "#dddddd"
	initial_balance	= 0 // This is now defined in code\modules\economy\cash.dm under spacecash/bundle/Vagabond as they carry cash on them.
	wage = WAGE_NONE //Get a job ya lazy bum
	alt_titles = list("Mechanical Assistant","Medical Intern","Research Assistant")
	also_known_languages = list(LANGUAGE_CYRILLIC = 15, LANGUAGE_SERBIAN = 5)

	access = list(access_maint_tunnels)
	outfit_type = /decl/hierarchy/outfit/job/nt/greytide

	stat_modifiers = list(
		STAT_ROB = 8,
		STAT_TGH = 8,
		STAT_BIO = 8,
		STAT_MEC = 8,
		STAT_VIG = 8,
		STAT_COG = 8
	)

	perks = list(/datum/perk/vagabond)

	description = "You are a staff Assistant, the lowest of creatures in space.<br>\
	Hired or enslaved, you are either an unassigned crewmember in need of tasking, or have been selected to help with different departments.<br>\
	Surely, you can't get into too much trouble?"

	loyalties = "Your loyalty is yours to decide"

/obj/landmark/join/start/greytide
	name = "Assistant"
	icon_state = "player-grey"
	join_tag = /datum/job/greytide

/datum/job/cargo_tech_nt
	title = "Cargo Technician"
	flag = GUILDTECH
	department = DEPARTMENT_GUILD
	department_flag = GUILD
	faction = "CEV Eris"
	total_positions = 4
	supervisors = "the chain of command"
	selection_color = "#c3b9a6"
	also_known_languages = list(LANGUAGE_JIVE = 100)
	wage = WAGE_LABOUR_DUMB
	department_account_access = TRUE
	outfit_type = /decl/hierarchy/outfit/job/nt/cargo

	access = list(
		access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_mining,
		access_mining_station
	)

	stat_modifiers = list(
		STAT_ROB = 10,
		STAT_TGH = 10,
		STAT_VIG = 10,
	)

	perks = list(/datum/perk/deep_connection)

	software_on_spawn = list(///datum/computer_file/program/supply,
							 ///datum/computer_file/program/deck_management,
							 /datum/computer_file/program/scanner,
							 /datum/computer_file/program/wordprocessor,
							 /datum/computer_file/program/reports)


	description = "You are the lowest level of NT logistics. A mover of goods and cargo. Welcome to retail."

/obj/landmark/join/start/cargo_tech_nt
	name = "Cargo Tech"
	icon_state = "player-beige"
	join_tag = /datum/job/cargo_tech_nt

/datum/job/janitor_nt
	title = "Janitor"
	flag = CLUBWORKER
	department = DEPARTMENT_CIVILIAN
	department_flag = SERVICE
	faction = "CEV Eris"
	total_positions = 2
	supervisors = "the chain of command"
	selection_color = "#dddddd"
	also_known_languages = list(LANGUAGE_CYRILLIC = 10, LANGUAGE_JIVE = 60)
	access = list(access_bar, access_kitchen, access_maint_tunnels)
	initial_balance = 750
	perks = list(PERK_CLUB)
	wage = WAGE_LABOUR_DUMB
	stat_modifiers = list(
		STAT_ROB = 10,
		STAT_TGH = 10,
		STAT_VIG = 5,
	)
	outfit_type = /decl/hierarchy/outfit/job/nt/janitor

	description = "You are the janitor. Get cleaning."

/obj/landmark/join/start/janitor_nt
	name = "Janitor"
	icon_state = "player-grey"
	join_tag = /datum/job/janitor_nt

/datum/job/cook_nt
	title = "Cook"
	flag = CLUBMANAGER
	department = DEPARTMENT_CIVILIAN
	department_flag = SERVICE
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the chain of command"
	selection_color = "#dddddd"
	also_known_languages = list(LANGUAGE_CYRILLIC = 25, LANGUAGE_SERBIAN = 15, LANGUAGE_JIVE = 80)
	access = list(access_bar, access_kitchen, access_maint_tunnels, access_change_club, access_artist, access_hydroponics)
	initial_balance = 3000
	perks = list(PERK_CLUB)
	wage = WAGE_LABOUR_DUMB
	department_account_access = TRUE
	stat_modifiers = list(
		STAT_ROB = 15,
		STAT_TGH = 15,
		STAT_VIG = 15,
	)
	outfit_type = /decl/hierarchy/outfit/job/nt/cook //Re-using this.
	description = "Keep the crew fed and entertained."

/obj/landmark/join/start/cook_nt
	name = "Cook"
	icon_state = "player-grey"
	join_tag = /datum/job/cook_nt

/datum/job/botanist_nt
	title = "Botanist"
	flag = BOTANIST
	department = DEPARTMENT_CIVILIAN
	department_flag = SERVICE
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the chain of command, and the Cook"
	selection_color = "#dddddd"
	also_known_languages = list(LANGUAGE_CYRILLIC = 25, LANGUAGE_SERBIAN = 15, LANGUAGE_JIVE = 80)
	access = list(access_bar, access_kitchen, access_maint_tunnels, access_hydroponics)
	perks = list(PERK_CLUB)
	wage = WAGE_LABOUR_DUMB
	stat_modifiers = list(
		STAT_ROB = 15,
		STAT_TGH = 15,
		STAT_VIG = 15,
	)
	outfit_type = /decl/hierarchy/outfit/job/nt/botanist
	description = "Keep the plants growing and thriving to provide food for the crew."

/obj/landmark/join/start/botanist_nt
	name = "Botanist"
	icon_state = "player-grey"
	join_tag = /datum/job/botanist_nt



/datum/job/doctor_nt
	title = "Doctor"
	flag = DOCTOR
	department = DEPARTMENT_MEDICAL
	department_flag = MEDICAL
	faction = "CEV Eris"
	total_positions = 3
	supervisors = "the chain of command"
	selection_color = "#dddddd"
	wage = WAGE_PROFESSIONAL
	also_known_languages = list(LANGUAGE_CYRILLIC = 25, LANGUAGE_SERBIAN = 15, LANGUAGE_JIVE = 80)
	access = list(
		access_moebius, access_medical_equip, access_maint_tunnels, access_morgue, access_surgery, access_chemistry, access_virology,
		access_genetics
	)
	stat_modifiers = list(
		STAT_BIO = 40,
		STAT_COG = 10
	)

	perks = list(/datum/perk/selfmedicated)

	software_on_spawn = list(/datum/computer_file/program/suit_sensors,
							/datum/computer_file/program/chem_catalog,
							/datum/computer_file/program/camera_monitor)

	outfit_type = /decl/hierarchy/outfit/job/nt/medical/doctor
	description = "Keep the crew alive. We're almost done here, they can make it another day."

/obj/landmark/join/start/doctor_nt
	name = "Doctor"
	icon_state = "player-grey"
	join_tag = /datum/job/doctor_nt



/datum/job/security_nt
	title = "Security"
	flag = IHOPER
	department = DEPARTMENT_SECURITY
	department_flag = IRONHAMMER
	faction = "CEV Eris"
	total_positions = 2
	supervisors = "the chain of command"
	//alt_titles = list("Ironhammer Junior Operative")
	selection_color = "#a7bbc6"
	wage = WAGE_LABOUR_HAZARD

	outfit_type = /decl/hierarchy/outfit/job/nt/security

	access = list(
		access_security, access_moebius, access_engine, access_mailsorting,access_eva,
		access_sec_doors, access_brig, access_maint_tunnels, access_morgue, access_external_airlocks
	)

	stat_modifiers = list(
		STAT_ROB = 25,
		STAT_TGH = 20,
		STAT_VIG = 25,
	)

	perks = list(PERK_SURVIVOR,
				 PERK_CODESPEAK_COP)

	software_on_spawn = list(/datum/computer_file/program/digitalwarrant,
							 /datum/computer_file/program/camera_monitor)

	description = "You are the long arm of the law and the short end of the stick."

/obj/landmark/join/start/security_nt
	name = "Security Officer"
	icon_state = "player-blue"
	join_tag = /datum/job/security_nt

/datum/job/detective_nt
	title = "Detective"
	flag = INSPECTOR
	department = DEPARTMENT_SECURITY
	department_flag = IRONHAMMER
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the chain of command"
	selection_color = "#a7bbc6"
	wage = WAGE_PROFESSIONAL

	outfit_type = /decl/hierarchy/outfit/job/nt/detective

	access = list(
		access_security, access_moebius, access_medspec, access_engine, access_mailsorting,
		access_sec_doors, access_forensics_lockers, access_morgue, access_maint_tunnels,
		access_external_airlocks, access_brig
	)

	stat_modifiers = list(
		STAT_BIO = 15,
		STAT_ROB = 15,
		STAT_TGH = 15,
		STAT_VIG = 25,
	)

	perks = list(PERK_SURVIVOR,
				 PERK_CODESPEAK_COP)

	software_on_spawn = list(/datum/computer_file/program/digitalwarrant,
							 /datum/computer_file/program/audio,
							 /datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/camera_monitor)

	description = "You are the station's detective, here to take care of the cases that aren't always what they seem, and suspects that aren't always caught red handed or ready to confess.<br>\
	A Deputy's job is to interrogate suspects, gather witness statements,  harvest evidence and reach a conclusion about the nature and culprit of a crime."

/obj/landmark/join/start/detective_nt
	name = "Detective"
	icon_state = "player-blue"
	join_tag = /datum/job/detective_nt

/datum/job/engineer_nt
	title = "Engineer"
	flag = TECHNOMANCER
	department = DEPARTMENT_ENGINEERING
	department_flag = ENGINEERING
	faction = "CEV Eris"
	total_positions = 3
	supervisors = "the chain of command"
	selection_color = "#d5c88f"
	also_known_languages = list(LANGUAGE_CYRILLIC = 50)
	wage = WAGE_PROFESSIONAL

	outfit_type = /decl/hierarchy/outfit/job/nt/engineer

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

	perks = list(/datum/perk/inspiration)

/obj/landmark/join/start/engineer_nt
	name = "Engineer"
	icon_state = "player-orange"
	join_tag = /datum/job/engineer_nt

/datum/job/scientist_nt
	title = "Scientist"
	flag = SCIENTIST
	department = DEPARTMENT_SCIENCE
	department_flag = SCIENCE
	faction = "CEV Eris"
	total_positions = 3
	supervisors = "the chain of command"
	selection_color = "#bdb1bb"
	wage = WAGE_PROFESSIONAL

	//alt_titles = list("Moebius Xenobiologist")
	outfit_type = /decl/hierarchy/outfit/job/nt/scientist

	software_on_spawn = list(/datum/computer_file/program/signaller, /datum/computer_file/program/chem_catalog)

	access = list(
		access_robotics, access_tox, access_tox_storage, access_moebius, access_maint_tunnels, access_xenobiology, access_xenoarch, access_research_equipment
	)

	stat_modifiers = list(
		STAT_MEC = 20,
		STAT_COG = 30,
		STAT_BIO = 15,
	)

	perks = list(/datum/perk/selfmedicated)

	description = "You are an (individual) of Science!(TM)"

/obj/landmark/join/start/scientist_nt
	name = "Scientist"
	icon_state = "player-purple"
	join_tag = /datum/job/scientist_nt

/datum/job/clown_nt
	title = "Clown"
	flag = ARTIST
	department = DEPARTMENT_CIVILIAN
	department_flag = SERVICE
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the funny ones"
	selection_color = "#dddddd"
	also_known_languages = list(LANGUAGE_CYRILLIC = 10, LANGUAGE_JIVE = 40, LANGUAGE_MONKEY = 20)
	access = list(access_bar, access_kitchen, access_maint_tunnels, access_artist, access_theatre)
	initial_balance = 600
	outfit_type = /decl/hierarchy/outfit/job/nt/clown
	wage = WAGE_NONE //They should get paid by the club owner, otherwise you know what to do.
	stat_modifiers = list(
		STAT_TGH = 30,
	)

	perks = list(PERK_ARTIST)

	description = "Honk."

/obj/landmark/join/start/clown_nt
	name = "Clown"
	icon_state = "player-grey"
	join_tag = /datum/job/clown_nt

/datum/job/captain_nt
	title = "Captain"
	flag = CAPTAIN
	department = DEPARTMENT_COMMAND
	head_position = TRUE
	aster_guild_member = TRUE
	department_flag = COMMAND
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "your heart and wisdom"
	selection_color = "#ccccff"
	req_admin_notify = 1
	wage = WAGE_NONE //The captain doesn't get paid, he's the one who does the paying
	//The ship account is his, and he's free to draw as much salary as he likes

	also_known_languages = list(LANGUAGE_CYRILLIC = 20, LANGUAGE_SERBIAN = 20)

	perks = list(/datum/perk/sommelier)

	ideal_character_age = 70 // Old geezer captains ftw
	outfit_type = /decl/hierarchy/outfit/job/nt/captain

	description = "The big man, the one everyone wants or hates to see."

	stat_modifiers = list(
		STAT_ROB = 15,
		STAT_TGH = 15,
		STAT_BIO = 15,
		STAT_MEC = 15,
		STAT_VIG = 25,
		STAT_COG = 15
	)

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/card_mod,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)


	equip(var/mob/living/carbon/human/H)
		if(!..())	return 0
		if(H.age>49)
			var/obj/item/clothing/under/U = H.w_uniform
			if(istype(U)) U.accessories += new /obj/item/clothing/accessory/medal/gold/captain(U)
		return 1

	get_access()
		return get_all_station_access()

/obj/landmark/join/start/captain_nt
	name = "Captain"
	icon_state = "player-gold-officer"
	join_tag = /datum/job/captain_nt

/datum/job/hop_nt
	title = "Head of Personnel"
	flag = FIRSTOFFICER
	department = DEPARTMENT_COMMAND
	head_position = TRUE
	aster_guild_member = TRUE
	department_flag = COMMAND
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the captain"
	selection_color = "#ddddff"
	req_admin_notify = 1
	wage = WAGE_COMMAND
	also_known_languages = list(LANGUAGE_CYRILLIC = 20, LANGUAGE_SERBIAN = 15)
	perks = list(/datum/perk/sommelier)
	ideal_character_age = 50

	description = "You are the captain's right hand. His second in command. Where he goes, you follow. Where he leads, you drag everyone else along. You make sure his will is done, his orders obeyed, and his laws enforced."
	outfit_type = /decl/hierarchy/outfit/job/nt/hop


	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/card_mod,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)


	get_access()
		return get_all_station_access()

	stat_modifiers = list(
		STAT_ROB = 15,
		STAT_TGH = 15,
		STAT_BIO = 10,
		STAT_MEC = 10,
		STAT_VIG = 20,
		STAT_COG = 10
	)

/obj/landmark/join/start/hop_nt
	name = "Head of Personnel"
	icon_state = "player-gold"
	join_tag = /datum/job/hop_nt
