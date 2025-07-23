/datum/job/assistant
	title = ASSISTANT_TITLE
	flag = ASSISTANT
	department = DEPARTMENT_CIVILIAN
	department_flag = CIVILIAN
	faction = "CEV Eris"
	total_positions = -1
	supervisors = "anyone who pays you"
	selection_color = "#dddddd"
	initial_balance	= 0 // This is now defined in code\modules\economy\cash.dm under spacecash/bundle/Vagabond as they carry cash on them.
	wage = WAGE_NONE //Get a job ya lazy bum
	alt_titles = list("Vagrant","Stowaway","Scavenger", "Refugee", "Looter", "Outlaw")
	also_known_languages = list(LANGUAGE_CYRILLIC = 15, LANGUAGE_SERBIAN = 5)

	access = list(access_maint_tunnels)
	outfit_type = /decl/hierarchy/outfit/job/assistant

	stat_modifiers = list(
		STAT_ROB = 8,
		STAT_TGH = 8,
		STAT_BIO = 8,
		STAT_MEC = 8,
		STAT_VIG = 8,
		STAT_COG = 8
	)

	perks = list(/datum/perk/vagabond)

	description = "You are a vagabond, a stowaway or refugee. You will not be paid a wage.<br>\
	The teeming underclasses, the left behind and exiled, the scum and the lowly. The tired, the weak, the huddled masses. Where you came from is a distant memory, and your ID is probably stolen."

	loyalties = "Your loyalty is yours to decide"

/obj/landmark/join/start/assistant
	name = ASSISTANT_TITLE
	icon_state = "player-grey"
	join_tag = /datum/job/assistant

/datum/job/assistant/New()
	..()
	for(var/alt in subtypesof(/datum/job_flavor/assistant))
		random_flavors += new alt
