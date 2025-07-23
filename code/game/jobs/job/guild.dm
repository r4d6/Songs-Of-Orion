//Cargo
/datum/job/merchant
	title = "Syndicate Logistics Officer"
	flag = MERCHANT
	department = DEPARTMENT_GUILD
	head_position = TRUE
	aster_guild_member = TRUE
	department_flag = GUILD | COMMAND
	faction = "CEV Eris"
	total_positions = 1
	supervisors = "the Syndicate"
	selection_color = "#b74938"
	wage = WAGE_NONE	//Guild merchant draws a salary from the guild account
	also_known_languages = list(LANGUAGE_JIVE = 100)
	alt_titles = list("Syndicate Quartermaster")
	access = list(
		access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_merchant, access_mining,
		access_heads, access_mining_station, access_RC_announce, access_keycard_auth, access_sec_doors,
		access_eva, access_external_airlocks, access_change_cargo
	)
	ideal_character_age = 40
	stat_modifiers = list(
		STAT_ROB = 10,
		STAT_COG = 20,
		STAT_MEC = 15,
		STAT_VIG = 10
	)

	perks = list(/datum/perk/merchant, /datum/perk/deep_connection, /datum/perk/oddity/market_prof)

	description = "You are the managing officer for the local branch of the Starboard Freight Syndicate.<br>\
	A staunch entrepreneur, you are motivated by profit, for the guild and especially for yourself. You are here firstly to make as much money as you can, and secondly to keep the crew supplied. You can order things at cargo using the local branch funds, these will not magically replenish so you will run out of money quickly if you don't charge. Take payments by card or cash, and deposit them into the branch's account to enable more purchases.<br>\
	<br>\
	The Syndicate also operates all the vendors on the ship, every credit paid into them goes to your guild account. Naturally operating is a two way street, you are expected, when necessary, to refill those vendors. Or send a technician to do it<br>\
	<br>\
	You do not recieve a salary, but the local branch funds are yours to use. You may pay yourself as much as you like from that account, take the funds and use them for any purpose.  Bribery is a good one, you can get people to do a lot of things if you flash some cash, and its a good idea to keep a few thousand credits on hand in-cash to bribe your way through potentially difficult situations.<br>\
	<br>\
	Things to bear in mind:<br>\
	-Nobody has a right to free stuff. You are well within your rights to charge for anything you distribute, and you won't make a penny if you don't.<br>\
	-Loyalty is a priceless resource, yet cheap to maintain. Don't screw over the hackers and technicians working under you. <br>\
	-Charity is a weapon. Used correctly, it can do wonders for your public image.  A few gifts spread around makes for good returning customers"

	duties = "Keep the crew supplied with anything they might need, at a healthy profit to you of course<br>\
	Buy up valueable items from scavengers, and make a profit reselling them<br>\
	Deploy your hackers and agents to produce and distribute advanced technologies- or basic tools.<br>\
	Counsel the captain on directing the station towards profitable opportunities."

	loyalties = "As a Syndicate officer, your first loyalty is to money- and the Syndicate, of course! You should be unscrupulous, willing to sell anything to anyone if they can pay your prices.br>\
	Your second loyalty is to your underlings, they'll do quite a bit if it means a chance at profit or advancement within the organization. If you make an enemy of everyone, it may prove a costly mistake"

	software_on_spawn = list(///datum/computer_file/program/supply,
							 ///datum/computer_file/program/deck_management,
							 /datum/computer_file/program/trade,
							 /datum/computer_file/program/scanner,
							 /datum/computer_file/program/wordprocessor,
							 /datum/computer_file/program/reports)

	outfit_type = /decl/hierarchy/outfit/job/cargo/merchant

/obj/landmark/join/start/merchant
	name = "Syndicate Officer"
	icon_state = "player-beige-officer"
	join_tag = /datum/job/merchant

/datum/job/roboticist
	title = "Syndicate Hacker"
	flag = ROBOTICIST
	department = DEPARTMENT_GUILD
	department_flag = GUILD
	faction = "CEV Eris"
	total_positions = 2
	supervisors = "the Logistics Officer"
	selection_color = "#60616a"
	wage = WAGE_PROFESSIONAL
	alt_titles = list("Syndicate Cybernetics Technician", "Syndicate Technical Specialist", "Syndicate Cryptography Analyst", "Syndicate Research Specialist", "Syndicate Technical Analyst")
	also_known_languages = list(LANGUAGE_CYRILLIC = 10)

	outfit_type = /decl/hierarchy/outfit/job/cargo/hacker

	access = list(
		access_robotics, access_tox, access_maint_tunnels, access_tox_storage, access_morgue, , access_research_equipment, access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot
	)
	software_on_spawn = list(/datum/computer_file/program/chem_catalog)

	stat_modifiers = list(
		STAT_MEC = 30,
		STAT_COG = 20,
		STAT_BIO = 25,
	)

	perks = list(/datum/perk/selfmedicated, PERK_ARTIST)

	description = "As Hacker, you job is to take things apart and put them together better. And nothing else.<br>\
	As the brains behind the production and procurement of new products, Hackers are skilled at unorthodox applications of technology."

	duties = "	'Research' technologies to create new and absolutely legally distinct versions of common items.<br>\
	Maintain and implant new bionics in crewmembers.<br>\
	Advertise bionics for sale and run a commercial cybernetic clinic<br>\
	Construct or reactivate various forms of machinery, from computers to cyborgs and drones."

/obj/landmark/join/start/roboticist
	name = "Hacker"
	icon_state = "player-purple"
	join_tag = /datum/job/roboticist

/datum/job/cargo_tech
	title = "Syndicate Agent"
	flag = GUILDTECH
	department = DEPARTMENT_GUILD
	department_flag = GUILD
	faction = "CEV Eris"
	total_positions = 4
	supervisors = "the Logistics Officer"
	selection_color = "#60616a"
	also_known_languages = list(LANGUAGE_JIVE = 100)
	wage = WAGE_LABOUR_DUMB
	department_account_access = TRUE
	outfit_type = /decl/hierarchy/outfit/job/cargo/cargo_tech
	alt_titles = list("Cargo Technician", "Syndicate Supply Specialist")

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


	description = "You are the lowest level Syndicate 'Agent' possible. A mover of goods and cargo. Welcome to retail.<br>\
<br>\
Your main duties are to keep the local Syndicate branch operational and profitable. If you're lucky, you might be able to work your way out of debt-slavery."

	duties = "Your primary tasks are as follows: <br>\
	-Delivering goods to persons or departments that ordered them<br>\
	-Staffing the front desk, taking payments and orders, buying up items from scavengers that come to sell things.<br>\
	-Visiting departments to take orders in person, ask if there's anything they need, and try to sell them unusual items that may aid their efforts.<br>\
	-Providing lesser services. Busted lights? Broken vendors? The guild can be there to help, for a small fee.<br>\
	-In quieter times, head into maintenance areas and scavenge for useful goods to resell"

	loyalties = "		Your first loyalty is to yourself and survival. This ship is mostly just a paycheck to you<br>\
		Your second loyalty is to the Syndicate, they might just ensure you're well paid and respected, in a universe where workers are often treated as interchangeable parts."

/obj/landmark/join/start/cargo_tech
	name = "Syndicate Agent"
	icon_state = "player-beige"
	join_tag = /datum/job/cargo_tech
