/datum/job/cmo
	title = "Brotherhood Coordinator"
	flag = MBO
	head_position = 1
	department = DEPARTMENT_MEDICAL
	department_flag = MEDICAL | COMMAND
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "The Brotherhood and God"
	selection_color = "#424b4d"
	req_admin_notify = 1
	also_known_languages = list(LANGUAGE_CYRILLIC = 10, LANGUAGE_SERBIAN = 5)
	wage = WAGE_COMMAND
	outfit_type = /decl/hierarchy/outfit/job/medical/cmo
	alt_titles = list("Chief Hospitalier", "Brotherhood Medical Officer", "Head Surgeon", "Attending Physician", "Brotherhood Shepherd")

	access = list(
		access_moebius, access_medical_equip, access_morgue, access_genetics, access_heads,
		access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
		access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_maint_tunnels,
		access_external_airlocks, access_paramedic, access_research_equipment, access_change_medbay
	)

	ideal_character_age = 50

	stat_modifiers = list(
		STAT_BIO = 35,
		STAT_MEC = 10,
		STAT_COG = 20,
		STAT_VIG = 40
	)

	perks = list(/datum/perk/oddity/gunslinger,/datum/perk/oddity/charming_personality)

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/chem_catalog,
							 /datum/computer_file/program/reports)

	description = "You are the rock in the storm, the Coodinator of activities and volunteers of the Worker's Brotherhood aboard the station.<br>\
	You are here to keep everyone alive and ideally, at work. You should make choices that preserve life as much as possible.<br>\
	As the leader of the local branch of the Brotherhood, you are the ethical and spiritual leader of those not lost in the depravity of these dark times.<br>\
	Keep the Brotherhood alive, the carry the torch of humanity through the storm of inhuman abomination."

	duties = "Organise the doctors under your command to help save lives. Assign patients, and check on their progress periodically<br>\
	Advise the captain on medical issues that concern the crew<br>\
	Advise the crew on ethical issues<br>\
	In times of crisis, lock down the clinic to protect those within from outside threats.<br>\
	Keep the peace within the Brotherhood, mediate issues, and keep the faith and fire alive, even if in shadow."

	loyalties = "As the head of the medical clinic, your loyalty is to God and those in your care. It falls on you to be the ethical and moral core of the crew. You should speak up for prisoners, captured lifeforms, and test subjects. Nobody else will.<br>\

	Your second loyalty is to the Brotherhood as an organization. Keep its secrets, keep its standing. Many seek to bring ruin to your flock, don't let them."

/obj/landmark/join/start/cmo
	name = "Brotherhood Coordinator"
	icon_state = "player-green-officer"
	join_tag = /datum/job/cmo


/datum/job/doctor
	title = "Brotherhood Doctor"
	flag = DOCTOR
	department = DEPARTMENT_MEDICAL
	department_flag = MEDICAL
	faction = "CEV Eris"
	total_positions = 2
	supervisors = "the Brotherhood Coordinator"
	selection_color = "#6a817a"
	wage = WAGE_LABOUR_DUMB //RIP
	also_known_languages = list(LANGUAGE_CYRILLIC = 10)
	alt_titles = list("Hospitalier", "Nurse", "Hospitalier Surgeon", "Brotherhood Clinician")

	outfit_type = /decl/hierarchy/outfit/job/medical/doctor

	access = list(
		access_moebius, access_medical_equip, access_maint_tunnels, access_morgue, access_surgery, access_chemistry, access_virology,
		access_genetics
	)

	stat_modifiers = list(
		STAT_BIO = 40,
		STAT_COG = 10
	)

	perks = list(/datum/perk/selfmedicated, /datum/perk/oddity/charming_personality)

	software_on_spawn = list(/datum/computer_file/program/suit_sensors,
							/datum/computer_file/program/chem_catalog,
							/datum/computer_file/program/camera_monitor)


	description = "You are a doctor with a cause. Working with the Brotherhood, you dedicate your time to a meager stipend and to the good of your fellow worker. <br>\
	Volunteering or directly employed by the Brotherhood, you keep the sacred fire of life from being snuffed out in the void.<br>\
	Working the Clinic, your duties are to see to the medical needs of those in need to the best of your abilities and resources.<br>\
	Your background in medicine could be almost anything, from a backwater tent to the mega-city high life, you've found yourself here by choice or desperation."

	duties = "Staff and operate the Clinic<br>\
	Provide medical care to the injured or sick<br>\
	Advise and assist those in need with ethical or psychological issues<br>\
	Keep the peace within the Brotherhood, mediate issues, and keep the faith and fire alive, even if in shadow."

	loyalties = "As a doctor, your first loyalty is to your conscience. You swore an oath to save lives and do no harm. It falls on you to be the ethical and moral core of the crew. You should speak up for prisoners, captured lifeforms, and test subjects. Nobody else will.<br>\
	Your second loyalty is to the Brotherhood and to your coworkers, they are your brothers, in arms and in the faith, if you have any."

/obj/landmark/join/start/doctor
	name = "Brotherhood Doctor"
	icon_state = "player-green"
	join_tag = /datum/job/doctor



/*datum/job/chemist
	title = "Moebius Chemist"
	flag = CHEMIST
	department = DEPARTMENT_MEDICAL
	department_flag = MEDICAL
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the Moebius Biolab Officer"
	selection_color = "#a8b69a"
	wage = WAGE_PROFESSIONAL
	also_known_languages = list(LANGUAGE_CYRILLIC = 10)

	outfit_type = /decl/hierarchy/outfit/job/medical/chemist

	access = list(
		access_moebius, access_medical_equip, access_maint_tunnels, access_morgue, access_surgery, access_chemistry, access_virology
	)

	stat_modifiers = list(
		STAT_COG = 10,
		STAT_MEC = 10,
		STAT_BIO = 30
	)

	perks = list(/datum/perk/selfmedicated/chemist)

	software_on_spawn = list(/datum/computer_file/program/chem_catalog,
							/datum/computer_file/program/scanner)

	description = "The chemist is a man of medicine, as much as of science. You mix up colorful liquids to make other, equally colorful, but more useful liquids.<br>\
	<br>\
	Your primary responsibility is working as a pharmacist. Prepare medicines for use by the medical staff, so that they can capably treat a broad variety of conditions. It's good to keep a stock of bicaridine, dexalin, peridaxon, and alkysine.<br>\
	<br>\
	Your secondary responsibility is as a chemical manufacturer for moebius generally. You may be requested to make non-medical chemicals for your colleagues in science, or even for other medical staff. Anyone within moebius should be freely and quickly provided with anything they request. Don't question why, it's above your paygrade.<br>\
	<br>\
	Your third duty is to run a chemical sales outlet. You may get requests from other crewmembers to make acid, chemical grenades, smoke, cleaning products, napalm, or perhaps even just to make medicines. You are fully licensed to sell any and all chemicals to those outside moebius. Sell being the operative word here. If someone isn't an employee of Moebius corp, charge them for their chemicals.<br>\
	<br>\
	Its worth noting that you don't always have everything you need on hand. Some recipes will require external ingredients. Bicaridine, most notably, requires the roach toxin blattedin, so you should gather up roach corpses to hack apart for their chemicals. Pay assistants to do this if necessary"

	duties = "		Mix medicines for doctors<br>\
		Fill chemical requests for moebius staff<br>\
		Sell chemicals and chem grenades to outsiders"

	loyalties = "Your loyalty is to your career with Moebius corp, and to your coworkers in both branches of moebius. Help out your scientific colleagues, and aid in their pursuit of knowledge."
*/

/obj/landmark/join/start/chemist
	name = "Moebius Chemist"
	icon_state = "player-green"
	join_tag = /datum/job/doctor

/datum/job/paramedic
	title = "Brotherhood Volunteer"
	flag = PARAMEDIC
	department = DEPARTMENT_MEDICAL
	department_flag = MEDICAL
	faction = "CEV Eris"
	total_positions = -1
	supervisors = "the Coordinator and Brotherhood doctors"
	selection_color = "#6a817a"
	wage = WAGE_LABOUR_DUMB //RIP
	also_known_languages = list(LANGUAGE_CYRILLIC = 20, LANGUAGE_SERBIAN = 15)
	alt_titles = list("Brother", "Brotherhood Worker", "Brotherhood Orderly", "Nursing Assistant", "Clinic Volunteer")

	outfit_type = /decl/hierarchy/outfit/job/medical/volunteer
	access = list(
		access_moebius, access_medical_equip, access_morgue, access_surgery, access_paramedic,
		access_eva, access_maint_tunnels, access_external_airlocks
	)

	stat_modifiers = list(
		STAT_BIO = 15,
		STAT_ROB = 10,
		STAT_TGH = 10,
		STAT_VIG = 10,
	)

	perks = list(/datum/perk/selfmedicated)

	software_on_spawn = list(/datum/computer_file/program/suit_sensors,
							//datum/computer_file/program/chem_catalog,
							 /datum/computer_file/program/camera_monitor)

	description = "You have volunteered your time or your life for the good of the Brotherhood.<br>\
	As a volunteer, you have sacrificed your titles and time to do the hard work for the sake of your people.<br>\
	Volunteering may be to climb out from the depths of despair, or to lower yourself to the needs of the many, <br>\
	but you're all equals trying to make a better world, some day."

	duties = "	Help keep the Clinic clean, safe, stocked, and orderly.<br>\
	Go out and be the hands of the Brotherhood, run errands and tasks for the Doctors so they can stop the bleeding.<br>\
	Maintain and operate the garden, keeping some kind of real food available for your brothers.<br>\
	Trade and collect items for use or resale by the Brotherhood to keep the Clinic running and to help those with nothing."

	loyalties = "	You answer to the Doctors and Coordinator of the Brotherhood, and to God for your actions.<br>\
	Keep them safe, keep out those who would do them harm, and bring in those who would do them well."

/obj/landmark/join/start/paramedic
	name = "Brotherhood Volunteer"
	icon_state = "player-green"
	join_tag = /datum/job/paramedic

/*datum/job/bioengineer
	title = "Moebius Bio-Engineer"
	flag = BIOENGINEER
	department = DEPARTMENT_MEDICAL
	department_flag = MEDICAL
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the Moebius Biolab Officer"
	selection_color = "#a8b69a"
	wage = WAGE_PROFESSIONAL
	also_known_languages = list(LANGUAGE_CYRILLIC = 10)

	outfit_type = /decl/hierarchy/outfit/job/medical/bioengineer

	access = list(
		access_moebius, access_medical_equip, access_maint_tunnels, access_morgue, access_surgery, access_chemistry, access_virology,
		access_genetics
	)

	stat_modifiers = list(
		STAT_BIO = 35,
		STAT_COG = 20,
		STAT_MEC = 15
	)

	perks = list(/datum/perk/selfmedicated)

	software_on_spawn = list(/datum/computer_file/program/suit_sensors,
							/datum/computer_file/program/chem_catalog,
							/datum/computer_file/program/camera_monitor)


	description = "You are a visionary. Your work lies on the bleeding edge of the medical sciences.<br>\
					Primarily, your goal is to perfect the human form via biological enhancement. \
					Your medical expertise compels you to aid your fellow doctors, but only in the direst of circumstances.\
					<br>\
					As a bio-engineer, you have two avenues to explore: genetics and visceral research.<br>\
					<br>\
						-Genetics: Using the Chrysalis Pod and its associated tools to develop new and powerful mutations. <br>\
						-Visceral Research: Creating new organs or upgrading existing ones using the organ fabricator.<br>\
						<br>\
					You have full access to Moebius medical facilities, and can utilize them if medical is short staffed. \
					If there are dedicated doctors or chemists on staff, they take priority and their respective work areas belongs to them.<br>\
					<br>\
					Character Expectations:<br>\
					You may be a doctor, but your research comes first.<br>\
					While you have priority in Visceral Research and Genetics, you are expected to provide doctors with organ replacements if necessary."

	loyalties = "As a medical researcher, your first loyalty is to progress. Your placement on the crew of the CEV Eris is the result of Moebius' desire for knowledge and your own morbid curiosity.<br>\
Your second loyalty is to your career with Moebius, and to your coworkers in both branches of the corporation. Help out your scientific colleagues, and aid in their pursuit of knowledge."
*/
/obj/landmark/join/start/bioengineer
	name = "Moebius Bio-Engineer"
	icon_state = "player-green"
	join_tag = /datum/job/doctor
