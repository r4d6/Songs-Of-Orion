/datum/perk/solar
	name = "Solar Human"
	desc = "You are a Solar Human. This come with some benefit, and some drawbacks."
	var/stat_increase = 10

/datum/perk/solar/assign(mob/living/carbon/human/H)
	if(..())
		holder.stats.changeStat(STAT_MEC, stat_increase)
		holder.stats.changeStat(STAT_COG, stat_increase)
		holder.stats.changeStat(STAT_BIO, stat_increase)
		holder.stats.changeStat(STAT_ROB, -stat_increase)
		holder.stats.changeStat(STAT_TGH, -stat_increase)
		holder.stats.changeStat(STAT_VIG, -stat_increase)

/datum/perk/solar/remove()
	holder.stats.changeStat(STAT_MEC, -stat_increase)
	holder.stats.changeStat(STAT_COG, -stat_increase)
	holder.stats.changeStat(STAT_BIO, -stat_increase)
	holder.stats.changeStat(STAT_ROB, stat_increase)
	holder.stats.changeStat(STAT_TGH, stat_increase)
	holder.stats.changeStat(STAT_VIG, stat_increase)
	..()

/datum/perk/exile
	name = "Exile Human"
	desc = "You are an Exile Human. This come with some benefit, and some drawbacks."
	var/stat_increase = 10

/datum/perk/exile/assign(mob/living/carbon/human/H)
	if(..())
		holder.stats.changeStat(STAT_MEC, -stat_increase)
		holder.stats.changeStat(STAT_COG, -stat_increase)
		holder.stats.changeStat(STAT_BIO, -stat_increase)
		holder.stats.changeStat(STAT_ROB, stat_increase)
		holder.stats.changeStat(STAT_TGH, stat_increase)
		holder.stats.changeStat(STAT_VIG, stat_increase)

		if(holder.gender == FEMALE)
			holder.stats.changeStat(STAT_VIG, stat_increase)
			holder.stats.changeStat(STAT_ROB, -stat_increase)

/datum/perk/exile/remove()
	holder.stats.changeStat(STAT_MEC, stat_increase)
	holder.stats.changeStat(STAT_COG, stat_increase)
	holder.stats.changeStat(STAT_BIO, stat_increase)
	holder.stats.changeStat(STAT_ROB, -stat_increase)
	holder.stats.changeStat(STAT_TGH, -stat_increase)
	holder.stats.changeStat(STAT_VIG, -stat_increase)

	if(holder.gender == FEMALE)
		holder.stats.changeStat(STAT_VIG, -stat_increase)
		holder.stats.changeStat(STAT_ROB, stat_increase)

	..()
