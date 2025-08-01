#define LOYALTY_CIVILIAN "As a civilian, your only loyalty is to yourself and your livelihood.<br>\
		You just want to survive, make a living, and get through the day. You shouldn't try to be a hero, or throw your life away for a cause. Nor should you hold any loyalties. Civilians should be easily corruptible, willing to take bribes to do anything someone wants and stay quiet about it."


/*datum/job/clubmanager
	title = "Club Manager"
	flag = CLUBMANAGER
	department = DEPARTMENT_CIVILIAN
	department_flag = SERVICE
	faction = "CEV Eris"
	total_positions = 0
	supervisors = "the First Officer"
	selection_color = "#dddddd"
	also_known_languages = list(LANGUAGE_CYRILLIC = 25, LANGUAGE_SERBIAN = 15, LANGUAGE_JIVE = 80)
	access = list(access_bar, access_kitchen, access_maint_tunnels, access_change_club, access_artist)
	initial_balance = 3000
	perks = list(PERK_CLUB)
	wage = WAGE_NONE // Makes his own money
	department_account_access = TRUE
	stat_modifiers = list(
		STAT_ROB = 15,
		STAT_TGH = 15,
		STAT_VIG = 15,
	)
	outfit_type = /decl/hierarchy/outfit/job/service/bartender //Re-using this.
	description = "As the Club Manager, you run the club aboard CEV Eris. Provide the crewmembers with drinks, food, and entertainment.<br>\
	<br>\
	Technically you take orders from no one, but the Captain and the First Officer are the ones who hired you and you should strive to please them. Your Club Workers help you run the place and make money. Pay them well!"

	duties = "		Run the club, provide a safe haven for food, drinks, and entertainment.<br>\
		Make money, run deals through your place, provide entertainment, trade secrets.<br>\
		Keep the bar safe, clean, and free of fights."

	loyalties = LOYALTY_CIVILIAN
*/
/obj/landmark/join/start/clubmanager
	name = "Club Manager"
	icon_state = "player-grey"
	join_tag = /datum/job/assistant

/*datum/job/clubworker
	title = "Club Worker"
	flag = CLUBWORKER
	department = DEPARTMENT_CIVILIAN
	department_flag = SERVICE
	faction = "CEV Eris"
	total_positions = 2
	supervisors = "the Club Manager"
	selection_color = "#dddddd"
	also_known_languages = list(LANGUAGE_CYRILLIC = 10, LANGUAGE_JIVE = 60)
	access = list(access_bar, access_kitchen, access_maint_tunnels)
	initial_balance = 750
	perks = list(PERK_CLUB)
	wage = WAGE_NONE //They should get paid by the club owner, otherwise you know what to do.
	department_account_access = TRUE
	stat_modifiers = list(
		STAT_ROB = 10,
		STAT_TGH = 10,
		STAT_VIG = 5,
	)
	outfit_type = /decl/hierarchy/outfit/job/service/waiter
	description = "As a Club Worker, you work for the Club Manager. Your job is to fulfill your duties in running the Club and making sure all the customers are satisfied.<br>\
	<br>\
	You can cook, clean, server, tend the bar, entertain, or even be the bouncer. You have no limits to what you can do inside the Club granted your manager requests you do it.<br>\
	<br>\
	You are paid directly by the Club Manager, he gives you your allowance. The Club Manager only makes money if the Club is ran well, so work hard!"

	duties = "		Assist the Club Manager with running the club.<br>\
		Serve customers. Feed customers. Entertain customers.<br>\
		Protect the Club. Protect the Customers.<br>\
		Make enough money to stay alive aboard CEV Eris."

	loyalties = LOYALTY_CIVILIAN
*/
/obj/landmark/join/start/clubworker
	name = "Club Worker"
	icon_state = "player-grey"
	join_tag = /datum/job/assistant

/*datum/job/artist
	title = "Club Artist"
	flag = ARTIST
	department = DEPARTMENT_CIVILIAN
	department_flag = SERVICE
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the Club Manager"
	selection_color = "#dddddd"
	also_known_languages = list(LANGUAGE_CYRILLIC = 10, LANGUAGE_JIVE = 40, LANGUAGE_MONKEY = 20)
	access = list(access_bar, access_kitchen, access_maint_tunnels, access_artist, access_theatre)
	initial_balance = 600
	outfit_type = /decl/hierarchy/outfit/job/service/artist
	wage = WAGE_NONE //They should get paid by the club owner, otherwise you know what to do.
	stat_modifiers = list(
		STAT_TGH = 30,
	)

	perks = list(PERK_ARTIST)

	description = "You are a creative soul aboard this vessel. You have been given home by the Club to create masterful works of art to be displayed or sold at mind-boggling prices... and something about the CEV Eris and it's doomed journey sparks the fire of creation within you.<br>\
	You do not gain desires like other members of the crew. Instead, you stop gaining insight once you max out at 100 points.<br>\
	You can gain desires by spending this insight at your Artist's Bench to build a work of art, this art you create vary wildly in type, quality, and value. Sell your artwork to the unwashed masses, display it in the club or give you work to the merchant to sell for a profit."

	duties = "Create works of art using your insight.<br>\
	Display your work, or sell it to the crew or Asters Guild for a profit.<br>\
	Be in the midst of action or combat to level your insight faster."

	loyalties = "You are loyal to your soul, first and foremost. You are fascinated by this cursed ship, and want to mold this interest into your works of art.<br>\
	Your second loyalty is to the manager and the Club as a whole. After all, they're the ones giving you housing, payment, and materials to create your art."
*/
/obj/landmark/join/start/artist
	name = "Club Artist"
	icon_state = "player-grey"
	join_tag = /datum/job/assistant
