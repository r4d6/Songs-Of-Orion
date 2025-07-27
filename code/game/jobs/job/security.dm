/datum/job/ihc
	title = "Director of Asset Denial"
	flag = IHC
	head_position = 1
	department = DEPARTMENT_SECURITY
	department_flag = IRONHAMMER | COMMAND
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the Captain"
	selection_color = "#4e729e"
	req_admin_notify = 1
	wage = WAGE_COMMAND
	alt_titles = list("Head of Security", "Asset Protection Director")

	outfit_type = /decl/hierarchy/outfit/job/security/ihc

	access = list(
		access_security, access_eva, access_sec_doors, access_brig, access_armory, access_medspec,
		access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
		access_moebius, access_engine, access_mining, access_construction, access_mailsorting,
		access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway,
		access_external_airlocks, access_change_sec
	)

	stat_modifiers = list(
		STAT_ROB = 40,
		STAT_TGH = 30,
		STAT_VIG = 40,
	)

	perks = list(PERK_SURVIVOR,
				 PERK_CODESPEAK_COP)

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/digitalwarrant,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)

	description = "You are the commander of the local detatchment of Proxima Centauri Risk Control, a private first responder corporation.<br>\
	<br>\
	Your goal is to keep everyone aboard the station as safe as possible, and to eliminate any threats to safety.<br>\
	The Deputy Marshals are tasked under your leadership as you are the Head of Security aboard the station."

	duties = "		Coordinate PCRC personnel, assigning them to threats and distress calls as needed.<br>\
		Allocate department funds for necessary supplies, equipment, armor, weapons, upgrades, etc. Spend your money as required to ensure the effectiveness of the company in this sector.<br>\
		Plan operations and ensure each officer and Specialist knows their roles and carries them out precisely.<br>\
		Oversee performance of the personnel under your command, and punish any that are insubordinate or incompetent<br>\
		Advise the captain on threats to station security, and counsel him towards choices that will minimise exposure to threats.<br>\
		If it comes to it, ensure the facility does not fall into hostile control."

	loyalties = "		As Director, your first loyalty is to the safety of the officers under your command. Do not allow them to be sent on suicide missions.<br>\
		<br>\
		Your second loyalty is to the name and reputation of the company. You are often the captain's primary tool in keeping order and you must pride yourself on ensuring commands are carried out, threats extinguished and safety preserved. You may need to carry out unsavory orders like executions, and must balance your professional pride versus your conscience.<br>\
		<br>\
		Your third loyalty is to the crew. As the long arm of the law on the station, any mutiny attempt is likely at your mercy, and if unjustified, it will fall to you to put it down. If the captain has gone mad and a mutiny is justified, your support will be the difference between a peaceful arrest and a bloody civil war in the halls. Without your guns, an insane captain will usually be forced to surrender."

/obj/landmark/join/start/ihc
	name = "HOS"
	icon_state = "player-blue-officer"
	join_tag = /datum/job/ihc


/*datum/job/gunserg
	title = "DEFUNCT ROLE"
	flag = GUNSERG
	department = DEPARTMENT_SECURITY
	department_flag = IRONHAMMER
	faction = "CEV Eris"
	total_positions = 0
	supervisors = "the Ironhammer Commander"
	selection_color = "#a7bbc6"
	department_account_access = TRUE
	wage = WAGE_PROFESSIONAL
	also_known_languages = list(LANGUAGE_NEOHONGO = 100)

	outfit_type = /decl/hierarchy/outfit/job/security/gunserg

	access = list(
		access_security, access_moebius, access_medspec, access_engine, access_mailsorting,
		access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_morgue,
		access_external_airlocks
	)

	stat_modifiers = list(
		STAT_ROB = 25,
		STAT_TGH = 25,
		STAT_VIG = 25,
	)

	perks = list(PERK_SURVIVOR,
				 PERK_CODESPEAK_COP)

	software_on_spawn = list(/datum/computer_file/program/digitalwarrant,
							 /datum/computer_file/program/camera_monitor)

	description = "You are the Second-in-Command of the local Ironhammer regiment, and the defacto leader if the commander isn't around. <br>\
	Within ironhammer you largely hold a desk job, your duties will rarely take you outside of the Ironhammer wing, and you are not expected to interact with civilians. You have enough to deal with as is, and are probably the hardest working member of Ironhammer.<br>\
	<br>\
	You have several core duties:<br>\
		1. As second in command, any of the commander's duties may be delegated to you, if they decide to do so. This means that at any time, you may be expected to handle funding, paperwork, disciplinary matters, planning combat tactics, or even carrying out executions. If there's no commander, these duties fall naturally to you. If there is a commander on site though, you shouldn't make these kind of decisions without consulting them.<br>\
		<br>\
		2. You serve as the ironhammer quartermaster. And as such, it is your job to maintain the armoury, and stocks of other equipment. You should keep track of its contents, and who has what. Make sure weapons and equipment are returned at the end of a shift, and procure new armaments from the guild or from scavengers as necessary to keep supplies up and respond to new threat	s.<br>\
		<br>\
		3. You are the defacto warden, and if there are any prisoners being kept in the Ironhammer brig, it is your responsibility to ensure they are fed, treated appropriately with regard to their legal rights, and ensure they have access to medical care. If necessary you may need to suppress riots or escape attempts within the brig too.<br>\
		<br>\
		4. In times of peace, prepare for war. To this end, you are also the onsite military instructor. If the station is in a lull and there are no outstanding threats, you should take the initiative to order training drills. Allow junior operatives to train and learn with less conventional weapons and tactics, give lessons on aiming, trigger discipline, hand to hand combat. Conduct drills on threat response, squad tactics, and EVA manoeuvres.<br>\ "

	loyalties = "You're a military man through and through. As such, your first loyalty is to the Commander, and thusly to the chain of command"
*/
/obj/landmark/join/start/gunserg
	name = "Ironhammer Gunnery Sergeant"
	icon_state = "player-blue"
	join_tag = /datum/job/assistant


/datum/job/inspector
	title = "Deputy Solar Marshal"
	flag = INSPECTOR
	department = DEPARTMENT_SECURITY
	department_flag = IRONHAMMER
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the Head of Security, regional Sky Marshal, and SOLCOM high command"
	selection_color = "#60616a"
	wage = WAGE_PROFESSIONAL

	outfit_type = /decl/hierarchy/outfit/job/security/inspector

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
	A Deputy's job is to interrogate suspects, gather witness statements,  harvest evidence and reach a conclusion about the nature and culprit of a crime.<br>\
	<br>\
	You are a low level SOLCOM agent, and you can give commands to security officers.  But this doesn't mean you should be commanding assaults. You're not any kind of tactical commander<br>\
	<br>\
	When there are no outstanding cases, your job is to go look for them. Mingle with civilians, interact and converse, sniff out leads about potential criminal activity. The security budget can often include stipends to pay informers for any useful info"

	duties = "		Interview suspects and witnesses after a crime. Record important details of their statements, and look for inconsistencies.<br>\
		Gather evidence and bring it back for processing<br>\
		Send out operatives to bring suspects in for questioning<br>\
		Ensure compliance with corporate and SolCon mandates<br>\
		Interact with civilians and be on the lookout for criminal activity"

	loyalties = "		As a Deputy, your loyalty is firstly, to the Truth. Be that the truth behind the violation of law, or that provided by the State. Seek to uncover the true events of any crime.<br>\
		<br>\
		Secondly, you are under the command of the Head of Security, the Director of Asset Denial. Follow the chain of command"

/obj/landmark/join/start/inspector
	name = "Deputy Solar Marshal"
	icon_state = "player-blue"
	join_tag = /datum/job/inspector

/datum/job/ihoper
	title = "Security Officer"
	flag = IHOPER
	department = DEPARTMENT_SECURITY
	department_flag = IRONHAMMER
	faction = "CEV Eris"
	total_positions = 2
	supervisors = "the Director of Asset Denial, Solar Marshals"
	alt_titles = list("Asset Protection Specialist")
	selection_color = "#3c5485"
	wage = WAGE_LABOUR_HAZARD

	outfit_type = /decl/hierarchy/outfit/job/security/ihoper

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

	description = "You are the long arm of the law and the short end of the stick. Formally, a Risk Controller. <br>\
	<br>\
	You are a consummate professional, you're often expected to put your pride aside, and work with others. Tactics and teamwork are vital.<br>\
	<br>\
	You are paid to act, not to think. When in doubt, follow orders, and leave the hard choices to someone else. Trust in your chain of command.<br>\
	<br>\
	When there are no standing orders, your ongoing task is to patrol the station and be on the lookout for trouble. Check in at departments, ask if there are any concerns, break up fights and do your best to prevent issues before they spirals out of control.<br>\
	<br>\
	You have almost-total access to the station in order to carry out your duties and reach threats quickly. Do not abuse this. It does not mean you can walk into anywhere you like, many areas are full of sensitive machinery and entering unnanounced can be harmful to your health. Do not steal from departments either. If it's not in your department, it doesn't belong to you."

	duties = "		Patrol the station, provide a security presence, and look for trouble<br>\
		Subdue and arrest criminals, terrorists, and other threats<br>\
		Follow orders from the chain of command<br>\
		Obey the law. You are not above it"

	loyalties = "		As an officer, your first loyalty is to the chain of command, which ends with the Director of Asset Denial. Their orders are supreme over all, even if they're currently leading a mutiny against the captain.<br>\
		<br>\
		Your second loyalty is to your fellow Risk Controllers and Specialists. As long as the company takes care of you, you should follow orders. But if you start being sent on suicide missions and treated as expendable fodder, that should change.<br>\
		<br>\
		Your third loyalty is to humanity. You are still human under all that armour. If you're being ordered to slaughter civilians en masse, it may be time to start thinking for yourself."

/obj/landmark/join/start/ihoper
	name = "Security Officer"
	icon_state = "player-blue"
	join_tag = /datum/job/ihoper

/datum/job/medspec
	title = "Search And Rescue Specialist"
	flag = MEDSPEC
	department = DEPARTMENT_SECURITY
	department_flag = IRONHAMMER
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the Director of Asset Denial"
	selection_color = "#66788f"
	wage = WAGE_PROFESSIONAL

	outfit_type = /decl/hierarchy/outfit/job/security/medspec

	access = list(
		access_security, access_moebius, access_sec_doors, access_medspec, access_morgue, access_maint_tunnels, access_medical_equip
	)

	stat_modifiers = list(
		STAT_BIO = 25,
		STAT_TGH = 5,
		STAT_VIG = 15,
	)

	perks = list(PERK_SURVIVOR,
				 PERK_CODESPEAK_COP)

	software_on_spawn = list(/datum/computer_file/program/digitalwarrant,
							 /datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/chem_catalog,
							 /datum/computer_file/program/camera_monitor)

	description = "You are a highly trained Specialist within Proxima Centauri Risk Control. The one who gets everyone back home, in as many peices as you can carry if need be.<br>\
	<br>\
	Playing hero, you are not an officer, you are not a doctor, and you are not a paramedic. However, you may have to wear the hat of whatever the circumstances require.<br>\
	Search And Rescue requires lifesaving skills of every type, and the guts to do what it takes to find and recover whoever needs saving. But remember, your job is to ensure others can do their jobs more effectively."

	duties = "You are a lifesaver in every sense, and your tasks are varied. <br>\
	1. Search And Rescue. <br>\
	As the name suggests, your primary task is the recovery of personnel, be they lost, hurt, or dead, and getting them back to safety. This means stabilizing injured or ensuring the lost are found.<br>\
	<br>\
	2. Field Medic.<br>\
	You may be expected to serve on the backlines in a combat situation, treating and stabilising the wounded, making the call as to whether they can return to combat or leave by medivac. You may need to perform emergency trauma surgery in undesireable conditions. <br>\
	You are allowed to be armed to a limited degree, but remember that saving lives, not taking them, is your first duty.<br>\
	<br>\
	3. Prison Doctor.<br>\
	During quiet times, when inmates are serving in the brig, you will often be required to treat prisoners, criminal suspects, and the condemned. Suicide attempts are common in prison, and you will often be treating a patient against their will, who is attempting to escape. When serving in this role, stay on guard, work closely with security, and keep control of the situation<br>\
	<br>\
	4. Caregiver.<br>\
	Lastly, you may be required to see to the general health and safety of the crew. Make the rounds to ensure no one is hurt or missing. If no other medical personnel are available, you may have to step up to help. However, if there are any other medical staff, you shouldn't be doing their job for them."

	loyalties = "		As an emplyee of PCRC, you report directly to the Director of Asset Denial.<br>\
		<br>\
		Secondly, if you are working with other medical staff, they outrank you in their respective fifedoms. Don't get in their way and stay out of their hair."


/obj/landmark/join/start/medspec
	name = "SARS"
	icon_state = "player-blue"
	join_tag = /datum/job/medspec
