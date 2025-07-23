var/datum/announcement/minor/captain_announcement = new(do_newscast = 1)

/datum/job/captain
	title = "Captain"
	flag = CAPTAIN
	department = DEPARTMENT_COMMAND
	head_position = TRUE
	aster_guild_member = TRUE
	department_flag = COMMAND
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "your heart and wisdom... and the company."
	selection_color = "#0c9d98"
	req_admin_notify = 1
	wage = WAGE_NONE //The captain doesn't get paid, he's the one who does the paying
	//The ship account is his, and he's free to draw as much salary as he likes
	alt_titles = list("Site Manager", "Corporate Rep")

	also_known_languages = list(LANGUAGE_CYRILLIC = 20, LANGUAGE_SERBIAN = 20)

	perks = list(/datum/perk/sommelier)

	ideal_character_age = 70 // Old geezer captains ftw
	outfit_type = /decl/hierarchy/outfit/job/captain

	description = "You are the executive officer of the station, the leader of the hopeless. <br>\
	Yours is the hand that guides the facility to glory or ruin. Using power and influence (and money) to get what your want, you are the face of the station and the company. <br>\
	As an officer of Keystone Securities, you're responsible for keeping this rust bucket profitable."
	loyalties = "Your first loyalty is the company and the Station. It is the purpose of your life, and you are nothing without it. <br>\
	You second loyalty is to your command officers. The First Officer is your right hand, and possibly the only one you can trust. The heads of each faction. Listen to their counsel, ensure their interests are served, and keep them happy"

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

/obj/landmark/join/start/captain
	name = "Captain"
	icon_state = "player-gold-officer"
	join_tag = /datum/job/captain

/datum/job/hop
	title = "First Officer"
	flag = FIRSTOFFICER
	department = DEPARTMENT_COMMAND
	head_position = TRUE
	aster_guild_member = TRUE
	department_flag = COMMAND
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the Captain, and the Company"
	selection_color = "#5c0e34"
	req_admin_notify = 1
	wage = WAGE_COMMAND
	also_known_languages = list(LANGUAGE_CYRILLIC = 20, LANGUAGE_SERBIAN = 15)
	perks = list(/datum/perk/sommelier)
	ideal_character_age = 50
	alt_titles = list("Head of Personnel")

	description = "You are the captain's right hand. Their second in command. Where they go, you follow. Where they lead, you drag everyone else along. You make sure their will is done, their orders obeyed, and their rules enforced.<br>\
	If they makes mistakes, discreetly inform them. Help to cover up their indiscretions and smooth relations with the crew, especially other command staff. Keep the captain safe, by endangering yourself in their stead if necessary.<br>\
	<br>\
	Do not embarass him or harm relations with faction leaders.<br>\
	<br>\
	But who are you?<br>\
	Perhaps you're a consummate professional who comes highly recommended.<br>\
	A retired general or naval officer? An advisor sent by Keystone Securies to keep an eye on the Captain?<br>\
	Perhaps you're the captain's sibbling, firstborn offspring, or spouse. Nobody can prevent nepotism if they choose.<br>\
	Whatever your origin, you are fiercely loyal to the captain"

	duties = "Oversee everyone else, especially the other command staff, to ensure the captain's orders are being carried out.<br>\
	Handle job reassignments and promotion requests, if an appropriate faction leader isn't available<br>\
	Act as the captain's surrogate in risky situations where a command presence is required<br>\
	Replace the captain if they become incapacitated, need to take a break, or suffer a premature death<br>\
	Act as the captain's sidekick, bodyguard, and last line of defense in a crisis or mutiny situation"

	loyalties = "Your first and only loyalty is to the captain as an extension of Keystone's interests. Unless you're an antagonist and have a good reason for betrayal, you should remain loyal to the death. You are the only one they can trust"

	outfit_type = /decl/hierarchy/outfit/job/hop


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

/obj/landmark/join/start/hop
	name = "First Officer"
	icon_state = "player-gold"
	join_tag = /datum/job/hop
