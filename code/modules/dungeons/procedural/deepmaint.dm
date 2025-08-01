/*
	For the sake of dungeon generator being modular and not tied exclusively to deepmaint,
	most of the objects and modifications required exclusively for it will be kept here.
*/

var/global/list/free_deepmaint_ladders = list()

var/global/list/small_deepmaint_room_templates = list()

var/global/list/big_deepmaint_room_templates = list()

/proc/populateDeepMaintMapLists()
	if(big_deepmaint_room_templates.len || small_deepmaint_room_templates.len)
		return
	for(var/item in subtypesof(/datum/map_template/deepmaint_template/room))
		var/datum/map_template/deepmaint_template/submap = item
		var/datum/map_template/deepmaint_template/S = new submap()
		small_deepmaint_room_templates += S

	for(var/item in subtypesof(/datum/map_template/deepmaint_template/big))
		var/datum/map_template/deepmaint_template/submap = item
		var/datum/map_template/deepmaint_template/S = new submap()
		big_deepmaint_room_templates += S

/obj/procedural/jp_DungeonRoom/preexist/square/submap/deepmaint
	name = "deepmaint room"

/obj/procedural/jp_DungeonRoom/preexist/square/submap/deepmaint/New()
	..()
	my_map = pick(small_deepmaint_room_templates)

/obj/procedural/jp_DungeonRoom/preexist/square/submap/deepmaint/big
	name = "deepmaint core room"

/obj/procedural/jp_DungeonRoom/preexist/square/submap/deepmaint/big/New()
	..()
	my_map = pick(big_deepmaint_room_templates)

/obj/procedural/jp_DungeonGenerator/deepmaint
	name = "Deep Maintenance Procedural Generator"
/*
	Finds a line of walls adjacent to the line of turfs given
*/

/obj/procedural/jp_DungeonGenerator/deepmaint/proc/checkForWalls(list/line)
	var/turf/t1 = line[1]
	var/turf/t2 = line[2]
	var/direction = get_dir(t1, t2)
	var/list/walls = list()
	for(var/turf/A in getAdjacent(t1)) //Interates through all 4 turf tiles adjacent to the second turf tile in the list generated before this in makeNiche
		var/length = line.len
		var/turf/T = A
		walls += T //Does not check if the adjacent tile in question is a wall, but includes it in the returned list anyways.
		while(length > 0) //Iterates from the current adjacent tile through direction chosen in makeNiche to check if the next 4 tiles are walls. If they are, they are returned, otherwise the list is reset and returned.
			length = length - 1
			T = get_step(T, direction)
			if(T.is_wall)
				walls += T
				if(walls.len == line.len)
					return walls
			else
				walls = list()
				break


	return list()

/*
	Generates burrow-linked ladders
*/

/obj/procedural/jp_DungeonGenerator/deepmaint/proc/makeLadders()
	var/ladders_to_place = 6
	if(numRooms < ladders_to_place)
		return
	var/list/obj/procedural/jp_DungeonRoom/done_rooms = list()
	while(ladders_to_place > 0)
		if(numRooms > 1)
			if(done_rooms.len == out_rooms.len)
				testing("Deepmaint generator went through all rooms, but couldn't place all ladders! Ladders left - [ladders_to_place]")
				break
		var/obj/procedural/jp_DungeonRoom/picked_room = pick(out_rooms)
		if(picked_room in done_rooms)
			continue
		var/list/turf/viable_turfs = list()
		for(var/turf/floor/F in range(roomMinSize + 1, picked_room.centre))
			//not under walls
			if(F.is_wall)
				continue

			if(F.contents.len > 1) //There's a lot of things rangine from tables to mechs or closets that can be on the chosen turf, so we'll ignore all turfs that have something aside lighting overlay
				continue


			//No turfs in space
			if(turf_is_external(F))
				continue

			//To be valid, the floor needs to have a wall in a cardinal direction
			for(var/d in cardinal)
				var/turf/T = get_step(F, d)
				if(T.is_wall)
					//Its got a wall!
					viable_turfs[F] = T //We put this floor and its wall into the possible turfs list
					break

		if(viable_turfs.len == 0)
			done_rooms += picked_room
			continue

		var/turf/ladder_turf = pick(viable_turfs)
		var/obj/structure/multiz/ladder/up/deepmaint/newladder = new/obj/structure/multiz/ladder/up/deepmaint(ladder_turf)
		free_deepmaint_ladders += newladder
		ladders_to_place--
		done_rooms += picked_room



/*
	Exactly what it says in the procname - makes a niche
*/

/obj/procedural/jp_DungeonGenerator/deepmaint/proc/makeNiche(turf/T)
	var/list/nicheline = list()
	for(var/i in list(NORTH,EAST,SOUTH,WEST)) //Checks range of 5 tiles in all 4 directions from the turf tile being passed
		switch(i)
			if(NORTH)
				nicheline = findNicheTurfs(block(T, locate(T.x, T.y + 4, T.z)))
			if(EAST)
				nicheline = findNicheTurfs(block(T, locate(T.x + 4, T.y, T.z)))
			if(SOUTH)
				nicheline = findNicheTurfs(block(T, locate(T.x, T.y - 4, T.z)))
			if(WEST)
				nicheline = findNicheTurfs(block(T, locate(T.x - 4, T.y, T.z)))
		if(nicheline.len > 3) //If all 5 turf tiles in the chosen diretion were not walls or nonexistant, continue with said list. Otherwise, check a different direction
			break
// If nothing ever fulfills the above requirements, functionally, nothing will happen for the rest of the function
	var/list/wall_line = list()
	if(nicheline.len > 3)
		wall_line = checkForWalls(nicheline) //Checks whether 4 turf tiles are walls in the chosen direction from tiles adjacent to the second tile. If this is not met in any direction, the function is functionally done
	if(wall_line.len)
		for(var/turf/W in nicheline) //Every turf in the path returned by findNicheTurfs has a 30% chance of becoming a random deepmaint machine
			if(prob(30))
				new /obj/spawner/pack/deep_machine(W)
		for(var/turf/W in wall_line) //Every turf in the path returned by checkForWalls is turned into a floor tile, and has a 70% chance of becoming a random deepmaint machine
			if(locate(/obj/machinery/light/small/autoattach, W))
				var/obj/machinery/light/small/autoattach/L = locate(/obj/machinery/light/small/autoattach, W)
				qdel(L)
			W.ChangeTurf(/turf/floor/tiled/techmaint_perforated)
			for(var/turf/wall/A in getAdjacent(W))
				A.update_connections(1)
			if(prob(70))
				new /obj/spawner/pack/deep_machine(W)
		return TRUE
	else
		return FALSE

/obj/procedural/jp_DungeonGenerator/deepmaint/proc/findNicheTurfs(list/turfs) //Checks turf type of turf list passed to it to make sure none of them are walls or nonexistant.
	var/list/L = list()
	for(var/turf/F in turfs)
		if(F.is_wall || !(F in path_turfs))
			if(L.len < 3)  //Why is this check here? The function this list being returned to will discard any list that isn't length 5. Is the < operator meant to be an > operator? But if that was the case, the for loop would have ended before reaching this anyways?
				L = list() //Resets the list to 0 and returns it if a tile in this direction was a wall or nonexistant, so that the makeNiche function will check another direction
			break
		else
			L += F

	return L //Returns entire list of tiles if none of them were walls or nonexistant.


/obj/procedural/jp_DungeonGenerator/deepmaint/proc/populateCorridors()
	var/niche_count = 20
	var/try_count = niche_count * 7 //In case it somehow zig-zags all of the corridors and stucks in a loop
	var/trap_count = 100
	var/list/path_turfs_copy = path_turfs.Copy()
	while(niche_count > 0 && try_count > 0)
		try_count = try_count - 1
		var/turf/N = pick(path_turfs_copy)
		path_turfs_copy -= N
		if(makeNiche(N))
			niche_count = niche_count - 1
	while(trap_count > 0)
		trap_count = trap_count - 1
		var/turf/N = pick(path_turfs_copy)
		path_turfs_copy -= N
		new /obj/spawner/traps(N)
	for(var/turf/T in path_turfs)
		if(prob(30))
			new /obj/effect/decal/cleanable/dirt(T) //Wanted to put rust on the floors in deep maint, but by god, the overlay looks like ASS



/obj/procedural/dungenerator/deepmaint
	name = "Deep Maint Gen"

/obj/procedural/dungenerator/deepmaint/New()
	populateDeepMaintMapLists()
	testing_variable(start, REALTIMEOFDAY)
	var/obj/procedural/jp_DungeonGenerator/deepmaint/generate = new /obj/procedural/jp_DungeonGenerator/deepmaint(src)
	testing("Beginning procedural generation of [name] -  Z-level [z].")
	generate.name = name
	generate.setArea(locate(50, 50, z), locate(110, 110, z))
	generate.setWallType(/turf/wall)
	generate.setLightChance(2)
	generate.setFloorType(/turf/floor/tiled/techmaint_perforated)
	generate.setAllowedRooms(list(/obj/procedural/jp_DungeonRoom/preexist/square/submap/deepmaint/big))
	generate.setNumRooms(1)
	generate.setExtraPaths(0)
	generate.setMinPathLength(0)
	generate.setMaxPathLength(0)
	generate.setMinLongPathLength(0)
	generate.setLongPathChance(0)
	generate.setPathEndChance(100)
	generate.setRoomMinSize(10)
	generate.setRoomMaxSize(10)
	generate.setPathWidth(1)
	generate.generate()

	generate.setArea(locate(20, 20, z), locate(150, 150, z))
	generate.setAllowedRooms(list(/obj/procedural/jp_DungeonRoom/preexist/square/submap/deepmaint))
	generate.setNumRooms(15)
	generate.setExtraPaths(5)
	generate.setMinPathLength(0)
	generate.setMaxPathLength(120)
	generate.setMinLongPathLength(0)
	generate.setLongPathChance(0)
	generate.setPathEndChance(100)
	generate.setRoomMinSize(5)
	generate.setRoomMaxSize(5)
	generate.setPathWidth(2)
	generate.setUsePreexistingRegions(TRUE)
	generate.setDoAccurateRoomPlacementCheck(TRUE)
	generate.generate()
	generate.populateCorridors()
	generate.makeLadders()

	// We've skipped these procs when loading Z-level to allow this map to fully generate
	SSmapping.on_map_loaded()
	SSair.on_map_loaded()
	testing("Finished procedural generation of [name]. [generate.errString(generate.out_error)] -  Z-level [z], in [(REALTIMEOFDAY - start) / 10] seconds.")
