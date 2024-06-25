/* Radiation Subsystem by r4d6#9842
	The radiation subsystem handles objects emitting radiation, and also update any nearby geiger counters.
	It work off the rad_producers list, which is actually a list of list with the following format :
		list("Source" = [Object], "Power" = [Number], "Range" = [TileNumber])
	The actual received radiation is dependent on the distance, as it decrease proportionally. The 'power' value represent the radiation damage one would get while standing on top of the source.
	This subsystem also clean its references, preventing radiation-producing objects from being stuck in limbo forever and without relying on the rad-producing item from cleaning itself
*/

#define AddRadDetector(X) \
	rad_detectors += (X)

#define PulseRadiation(Source, Power, Range) \
	produce_radiation((Source), (Power), (Range))

// List of items that produce radiation.
var/list/global/rad_producers = list()
// List of all the geiger counters that exist in the world for easy referencing
var/list/global/rad_detectors = list()

SUBSYSTEM_DEF(radiation)
	name = "Radiation"
	init_order = INIT_ORDER_LATELOAD
	flags = SS_POST_FIRE_TIMING
	wait = 2 SECONDS
	var/list/rad_sources = list()
	var/list/rad_sinks = list()

/datum/controller/subsystem/radiation/Initialize()
	. = ..()
	clear_garbage()

/datum/controller/subsystem/radiation/fire()
	clear_garbage()
	reset_geigers()
	handle_radiation()

// Handle all of the radiation stuff
/datum/controller/subsystem/radiation/proc/handle_radiation()
	for(var/list/L in rad_producers) // Loop through all the items emitting radiation
		// Run through all the mobs in range and irradiate them.
		for(var/mob/living/M in range(L["Range"], L["Source"]))
			var/actual_rad = calculate_rad_amount(L["Source"], M, L["Power"])
			M.apply_effect(actual_rad, IRRADIATE)
			M.updatehealth()
			// We run though geiger counters a second time because [range()] doesn't check the contents of mobs.
			for(var/obj/item/device/geiger/G in M.contents)
				G.add_rads(actual_rad)

		// Run through all the geiger counters in range and update their radiation levels
		for(var/obj/item/device/geiger/G in range(L["Range"], L["Source"]))
			var/actual_rad = calculate_rad_amount(L["Source"], G, L["Power"])
			G.add_rads(actual_rad)

// Reset all of the geigers counters that ever existed
/datum/controller/subsystem/radiation/proc/reset_geigers()
	for(var/obj/item/device/geiger/G in rad_detectors)
		G.reset_rads() // Clear the rads

// Check both global lists and remove null/qdel items
/datum/controller/subsystem/radiation/proc/clear_garbage()
	for(var/list/L in rad_producers) // Loop through all the items emitting radiation
		if(!L["Source"] || L["Source"]:loc == null) // The source was qdel'ed
			L["Source"] = null // Clear the reference
			rad_producers -= list(L) // Remove the list, we need to do list(L) despite L being a list, because otherwise it wouldn't work.
			continue // Move to the next one

	for(var/obj/item/device/geiger/G in rad_detectors)
		if(G.loc == null) // The geiger counter was qdel'ed
			rad_detectors -= G // Remove the reference
			continue // Move to the next one

	update_internal_list() // Update the internal list

// For testing/tracking purposes, because we can't directly see the global list in-game
/datum/controller/subsystem/radiation/proc/update_internal_list()
	rad_sources = rad_producers
	rad_sinks = rad_detectors

// Calculate how much radiation damage someone should receive
proc/calculate_rad_amount(var/atom/movable/source, var/atom/movable/target, var/power)
	if(!source || !target || !power)
		return 0

	var/received_power = round(power * ((100 / max(get_dist(source, target), 1)) / 100), 0.01)

	return received_power

// "Manually" irradiate nearby people.
proc/produce_radiation(var/Source, var/Power, var/Range)
	if(!Source || !Power || !Range)
		return

	for(var/mob/living/M in range(Range, Source))
		var/actual_rad = calculate_rad_amount(Source, M, Power)
		M.apply_effect(actual_rad, IRRADIATE)
		M.updatehealth()
		for(var/obj/item/device/geiger/G in M.contents)
			G.add_rads(actual_rad)

	for(var/obj/item/device/geiger/G in range(Range, Source))
		var/actual_rad = calculate_rad_amount(Source, G, Power)
		G.add_rads(actual_rad)

proc/AddRadSource(var/Source, var/Power, var/Range = world.view)
	if(!Source || !Power || !Range)
		return
	rad_producers += list(list("Source" = (Source), "Power" = (Power), "Range" = (Range))) // We need to do list(list()) because otherwise each element is individually added instead of as a list

