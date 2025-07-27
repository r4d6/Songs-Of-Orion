/datum/job/rd
	title = "Human Resources Officer"
	flag = MEO
	head_position = 1
	department = DEPARTMENT_SCIENCE
	department_flag = SCIENCE | COMMAND
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "Human Resources, Inc"
	selection_color = "#27cab3"
	req_admin_notify = 1
	wage = WAGE_COMMAND

	outfit_type = /decl/hierarchy/outfit/job/science/rd

	access = list(
		access_rd, access_heads, access_tox, access_genetics, access_morgue,
		access_tox_storage, access_teleporter, access_sec_doors,
		access_moebius, access_medical_equip, access_chemistry, access_virology, access_cmo, access_surgery, access_psychiatrist,
		access_robotics, access_xenobiology, access_ai_upload, access_tech_storage, access_eva, access_external_airlocks,
		access_RC_announce, access_keycard_auth, access_tcomsat, access_gateway, access_xenoarch, access_network, access_maint_tunnels, access_research_equipment,
		access_change_research
	)
	ideal_character_age = 50

	stat_modifiers = list(
		STAT_MEC = 25,
		STAT_COG = 40,
		STAT_BIO = 25,
	)

	perks = list(/datum/perk/selfmedicated)

	// TODO: enable after baymed
	software_on_spawn = list(/datum/computer_file/program/comm,
							///datum/computer_file/program/aidiag,
							/datum/computer_file/program/signaller,
							/datum/computer_file/program/ntnetmonitor,
							/datum/computer_file/program/camera_monitor,
							/datum/computer_file/program/chem_catalog,
							/datum/computer_file/program/reports)

	description = "You are the representative officer of the station's branch of Human Resources, Inc."

	duties = "Direct the betterment of humanity through Science!<br>\
	Use the biotechnologies available to achieve the very best for your customers- and profit for the company.<br>\
	As HR's mission to improve upon all forms of biology, your team will strive to study and manufacture the bio-goods people crave.<br>\
	Keep the WAGIEs busy maintaining the Life-Loop of the station, keeping the ship clean and fed."

	loyalties = "As a scientist, your first loyalty is to Science(TM), the ultimate good in the universe. Learning and consuming the newest biotech is the greatest goal humanity can pursue, and no sacrifice is too great to achieve that end. Even the lives of others or yourself.<br>\
<br>\
Your second loyalty is to Human Resources, Inc. In order to ensure it can continue its mission of research, it must remain profitable. Ensure its interests are farthered, and take care of your colleagues in both research and medical wings"

/obj/landmark/join/start/rd
	name = "Human Resources Officer"
	icon_state = "player-purple-officer"
	join_tag = /datum/job/rd

access_kitchen

/datum/job/scientist
	title = "HR Biotechnician"
	flag = SCIENTIST
	department = DEPARTMENT_SCIENCE
	department_flag = SCIENCE
	faction = "CEV Eris"
	total_positions = 3
	supervisors = "the Human Resources Officer"
	selection_color = "#0c9d98"
	wage = WAGE_PROFESSIONAL

	//alt_titles = list("Moebius Xenobiologist")
	outfit_type = /decl/hierarchy/outfit/job/science/scientist

	software_on_spawn = list(/datum/computer_file/program/signaller, /datum/computer_file/program/chem_catalog)

	access = list(
		access_tox, access_tox_storage, access_moebius, access_maint_tunnels, access_xenobiology, access_xenoarch, access_research_equipment
	)

	stat_modifiers = list(
		STAT_MEC = 20,
		STAT_COG = 30,
		STAT_BIO = 15,
	)

	perks = list(/datum/perk/selfmedicated)

	description = "You are an (individual) of Science!(TM), a Biotechnician of the Human Resources corporation. <br>\
	<br>\
	As a scientist, your primary purpose is research, testing, and the advancement of knowledge. You can justify almost anything if its done for the purpose of Science! You should craft, lathe and print anything you can, toy around with it, and figure out how it works in detail. Deeply explore everything you can."

	duties = "	Create unusual things and experiment with them.<br>\
	Explore, learn and adventure, do anything to advance the cause of Science!<br>\
	Use the new technologies and skills at your disposal to enhance the crew, or at least put the insured back together if need be.<br>\
	Maintain the station's stock of bio-products for sale and export. This varies from advanced organoids and xenobiology, to growing food for the station."

	loyalties = "As a scientist, your first loyalty is to Science!- the ultimate good in the universe. Learning and consuming the newest biotech is the greatest goal humanity can pursue, and no sacrifice is too great to achieve that end. Even the lives of others or yourself.<br>\
	Your second loyalty is to Human Resources, Inc. In order to ensure it can continue its mission of research, it must remain profitable. Ensure its interests are farthered, and take care of your colleagues in both research and medical wings"


/obj/landmark/join/start/scientist
	name = "Biotechnician"
	icon_state = "player-purple"
	join_tag = /datum/job/scientist

/datum/job/wagie
	title = "HR WAGIE"
	flag = ASSISTANT
	flag = SCIENTIST
	department = DEPARTMENT_SCIENCE
	department_flag = SCIENCE
	faction = "CEV Eris"
	total_positions = -1
	supervisors = "Human Resources personnel, the First Officer, and anyone you're put under by them"
	selection_color = "#246775"
	initial_balance	= 0 // This is now defined in code\modules\economy\cash.dm under spacecash/bundle/Vagabond as they carry cash on them.
	wage = WAGE_LABOUR_DUMB
	alt_titles = list("HR Assistant","HR custodian","HR biolab assistant", "HR laborer", "HR debt slave", "Human Resource", "HR nutrition technician")
	also_known_languages = list(LANGUAGE_CYRILLIC = 15, LANGUAGE_SERBIAN = 5)

	access = list(access_maint_tunnels, access_moebius)
	outfit_type = /decl/hierarchy/outfit/job/science/wagie

	stat_modifiers = list(
		STAT_ROB = 8,
		STAT_TGH = 8,
		STAT_BIO = 8,
		STAT_MEC = 8,
		STAT_VIG = 8,
		STAT_COG = 8
	)

	perks = list(/datum/perk/vagabond)

	description = "Worker Assistant, Generalized Indentured Employee<br>\
	You are the backbone of all services in the galaxy, the Human Resources WAGIE. If it needs done, you're probably going to be the one sent to do it.<br>\
	As a low level worker- or indentured employee, you do whatever is needed. Your job is to keep things moving and to keep up with the constant maintainance of the station.<br>\
	From processing biomass and cleaning up around the station, to recycling materials, to preparing and serving food for the crew, you work for whoever you're ordered to work for."

	duties = "	- Follow orders and assist HR in its operations<br>\
	- Operate the kitchen<br>\
	- Clean the station<br>\
	- Recycle materials and biomass"

	loyalties = "Your loyalty isn't yours to decide. The HRO may assign you to virtually any task, or even other departments if they pay for your service."

/obj/landmark/join/start/wagie
	name = "WAGIE"
	icon_state = "player-grey"
	join_tag = /datum/job/wagie


/*datum/job/psychiatrist
	title = "Moebius Psychiatrist"
	flag = PSYCHIATRIST
	department = DEPARTMENT_SCIENCE
	department_flag = SCIENCE
	faction = "CEV Eris"
	total_positions = 0
	wage = WAGE_PROFESSIONAL
	supervisors = "the Moebius Expedition Overseer"
	selection_color = "#bdb1bb"
	also_known_languages = list(LANGUAGE_CYRILLIC = 10)

	outfit_type = /decl/hierarchy/outfit/job/science/psychiatrist

	access = list(
		access_robotics, access_tox, access_tox_storage, access_moebius, access_maint_tunnels, access_research_equipment, access_psychiatrist, access_medical_equip
	)

	stat_modifiers = list(
		STAT_BIO = 25,
		STAT_COG = 15,
		STAT_VIG = 15
	)

	perks = list(/datum/perk/selfmedicated)

	software_on_spawn = list(/datum/computer_file/program/suit_sensors,
							/datum/computer_file/program/chem_catalog,
							/datum/computer_file/program/camera_monitor)

*/
/obj/landmark/join/start/psychiatrist
	name = "Moebius Psychiatrist"
	icon_state = "player-purple"
	join_tag = /datum/job/assistant
