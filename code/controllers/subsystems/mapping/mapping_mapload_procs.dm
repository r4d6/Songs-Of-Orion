/datum/controller/subsystem/mapping/proc/queue_map_loading(map_name as text, delayed_loading)
	if(currently_loading_map)
		map_loading_queue |= map_name
	else
		currently_loading_map = map_name
		load_map_from_name(map_name, delayed_loading)


/datum/controller/subsystem/mapping/proc/load_map_from_name(map_name as text, delayed_loading)
	var/json_file
	if(findtext(map_name, ".")) // map_name contains the entire path to .json
		json_file = file(map_name)
	else
		json_file = file("maps/json/[map_name].json")

	if(!isfile(json_file))
		on_map_loaded(is_failed_to_load = TRUE)
		return
	var/json_text = file2text(json_file)
	var/json_list = json_decode(json_text)
	var/dmm_file_path = json_list["map_file"]
	if(!dmm_file_path)
		on_map_loaded(is_failed_to_load = TRUE)
		return
	load_map(dmm_file = file(dmm_file_path), z_level_info = json_list, delayed_loading = delayed_loading)


/datum/controller/subsystem/mapping/proc/on_map_loaded(is_failed_to_load = FALSE)
	if(is_failed_to_load)
		failed_map_names |= currently_loading_map
	else
		loaded_map_names |= currently_loading_map

	var/call_proc_on_load = z_level_info_decoded[world.maxz]["call_proc_on_load"]
	if(call_proc_on_load)
		call(src, call_proc_on_load)()

	currently_loading_map = null
	if(LAZYLEN(map_loading_queue))
		currently_loading_map = map_loading_queue[1]
		map_loading_queue.Remove(currently_loading_map)
		load_map_from_name(currently_loading_map)


/datum/controller/subsystem/mapping/proc/load_map(dmm_file, x_offset, y_offset, z_offset, cropMap, measureOnly, no_changeturf, orientation, z_level_info, delayed_loading)
	#ifdef TESTING
	turfsSkipped = 0
	#endif
	space_key = null
	var/tfile = dmm_file//the map file we're creating
	if(isfile(tfile))
		tfile = file2text(tfile)

	if(!x_offset)
		x_offset = 1
	if(!y_offset)
		y_offset = 1
	if(!z_offset)
		z_offset = world.maxz + 1

	// If it's not a single dir, default to north (Default orientation)
	if(!(orientation in cardinal))
		orientation = SOUTH

	var/list/bounds = list(1.#INF, 1.#INF, 1.#INF, -1.#INF, -1.#INF, -1.#INF)
	var/list/grid_models = list()
	var/key_len = 0

	var/stored_index = 1
	var/regex/localRegex = regex(dmmRegex)
	while(localRegex.Find(tfile, stored_index))
		stored_index = localRegex.next

		// "aa" = (/type{vars=blah})
		if(localRegex.group[1]) // Model
			var/key = localRegex.group[1]
			if(grid_models[key]) // Duplicate model keys are ignored in DMMs
				continue
			if(key_len != length(key))
				if(!key_len)
					key_len = length(key)
				else
					throw EXCEPTION("Inconsistant key length in DMM")
			if(!measureOnly)
				grid_models[key] = localRegex.group[2]

		// (1,1,1) = {"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"}
		else if(localRegex.group[3]) // Coords
			if(!key_len)
				testing("[localRegex.group[3]]")
				throw EXCEPTION("Coords before model definition in DMM - [dmm_file]")

			var/xcrdStart = text2num(localRegex.group[3]) + x_offset - 1
			//position of the currently processed square
			var/xcrd
			var/ycrd = text2num(localRegex.group[4]) + y_offset - 1
			var/zcrd = text2num(localRegex.group[5]) + z_offset - 1

			if(orientation & (EAST | WEST)) //VOREStation edit we just have to pray the upstream spacebrains take into consideration before their refator is done.
				xcrd = ycrd // temp variable
				ycrd = xcrdStart
				xcrdStart = xcrd

			var/zexpansion = zcrd > world.maxz
			if(zexpansion && !measureOnly)
				if(cropMap)
					continue
				else
					while(world.maxz < zcrd) //create a new z_level if needed
						world.incrementMaxZ(z_level_info)
				if(!no_changeturf)
					WARNING("Z-level expansion occurred without no_changeturf set, this may cause problems")

			bounds[MAP_MINX] = min(bounds[MAP_MINX], xcrdStart)
			bounds[MAP_MINZ] = min(bounds[MAP_MINZ], zcrd)
			bounds[MAP_MAXZ] = max(bounds[MAP_MAXZ], zcrd)

			var/list/gridLines = splittext(localRegex.group[6], "\n")

			var/leadingBlanks = 0
			while(leadingBlanks < gridLines.len && gridLines[++leadingBlanks] == "")
			if(leadingBlanks > 1)
				gridLines.Cut(1, leadingBlanks) // Remove all leading blank lines.

			if(!gridLines.len) // Skip it if only blank lines exist.
				continue

			if(gridLines.len && gridLines[gridLines.len] == "")
				gridLines.Cut(gridLines.len) // Remove only one blank line at the end.

			bounds[MAP_MINY] = min(bounds[MAP_MINY], ycrd)
			if(orientation == SOUTH || orientation == NORTH) // Fix to avoid improper loading with EAST and WEST orientation
				ycrd += gridLines.len - 1 // Start at the top and work down

			if(!cropMap && ycrd > world.maxy)
				if(!measureOnly)
					world.maxy = ycrd // Expand Y here.  X is expanded in the loop below
				bounds[MAP_MAXY] = max(bounds[MAP_MAXY], ycrd)
			else
				bounds[MAP_MAXY] = max(bounds[MAP_MAXY], min(ycrd, world.maxy))

			var/maxx = xcrdStart

			// Assemble the grid of keys
			var/list/list/key_list = list()
			for(var/line in gridLines)
				var/list/line_keys = list()
				xcrd = 1
				for(var/tpos = 1 to length(line) - key_len + 1 step key_len)
					if(xcrd > world.maxx)
						if(cropMap)
							break
						else
							world.maxx = xcrd

					if(xcrd >= 1)
						var/model_key = copytext(line, tpos, tpos + key_len)
						line_keys[++line_keys.len] = model_key
						//CHECK_TICK
					maxx = max(maxx, xcrd++)
				key_list[++key_list.len] = line_keys

			// Rotate the list according to orientation
			if(orientation != SOUTH)
				var/num_cols = key_list[1].len
				var/num_rows = key_list.len
				var/list/list/new_key_list = list()
				// If it's rotated 180 degrees, the dimensions are the same
				if(orientation == NORTH)
					new_key_list.len = num_rows
					for(var/i = 1 to new_key_list.len)
						new_key_list[i] = list()
						new_key_list[i].len = num_cols
				// Else, the dimensions are swapped
				else
					new_key_list.len = num_cols
					for(var/i = 1 to new_key_list.len)
						new_key_list[i] = list()
						new_key_list[i].len = num_rows

				num_rows++ // Buffering against the base index of 1
				num_cols++
				// Populate the new list
				for(var/i = 1 to new_key_list.len)
					for(var/j = 1 to new_key_list[i].len)
						switch(orientation)
							if(NORTH)
								new_key_list[i][j] = key_list[num_rows - i][num_cols - j]
							if(EAST)
								new_key_list[i][j] = key_list[num_rows - j][i]
							if(WEST)
								new_key_list[i][j] = key_list[j][num_cols - i]

				key_list = new_key_list

			if(measureOnly)
				for(var/list/line in key_list)
					maxx = max(maxx, line.len)
			else
				for(var/i = 1 to key_list.len)
					if(ycrd <= world.maxy && ycrd >= 1)
						xcrd = xcrdStart
						for(var/j = 1 to key_list[1].len)
							if(xcrd > world.maxx)
								if(cropMap)
									break
								else
									world.maxx = xcrd

							if(xcrd >= 1)
								var/no_afterchange = no_changeturf || zexpansion
								if(!no_afterchange || (key_list[i][j] != space_key))
									if(!grid_models[key_list[i][j]])
										throw EXCEPTION("Undefined model key in DMM: [dmm_file], [key_list[i][j]]")
									parse_grid(grid_models[key_list[i][j]], key_list[i][j], xcrd, ycrd, zcrd, no_afterchange, orientation)
								//CHECK_TICK
							maxx = max(maxx, xcrd)
							++xcrd
					--ycrd

			bounds[MAP_MAXX] = max(bounds[MAP_MAXX], cropMap ? min(maxx, world.maxx) : maxx)

		CHECK_TICK

	if(bounds[1] == 1.#INF) // Shouldn't need to check every item
		return null

	#ifdef TESTING
	if(turfsSkipped)
		testing("Skipped loading [turfsSkipped] default turfs")
	#endif

	// If delayed_loading is true, then we'just loaded procedurally generating map that needs time to process itself
	// It must call on_map_loaded() manually when done generating
	if(!measureOnly && !delayed_loading)
		SSmapping.on_map_loaded()
		SSair.on_map_loaded()

	return bounds

/**
 * Fill a given tile with its area/turf/objects/mobs
 * Variable model is one full map line (e.g /turf/wall/dummy{icon_state = "rock"}, /area/mine/explored)
 *
 * WORKING :
 *
 * 1) Read the model string, member by member (delimiter is ',')
 *
 * 2) Get the path of the atom and store it into a list
 *
 * 3) a) Check if the member has variables (text within '{' and '}')
 *
 * 3) b) Construct an associative list with found variables, if any (the atom index in members is the same as its variables in members_attributes)
 *
 * 4) Instanciates the atom with its variables
 *
 */
/datum/controller/subsystem/mapping/proc/parse_grid(model as text, model_key as text, xcrd as num,ycrd as num,zcrd as num, no_changeturf as num, orientation as num)
	/*Method parse_grid()
	- Accepts a text string containing a comma separated list of type paths of the
		same construction as those contained in a .dmm file, and instantiates them.
	*/

	var/list/members //will contain all members (paths) in model (in our example : /turf/wall/dummy and /area/mine/explored)
	var/list/members_attributes //will contain lists filled with corresponding variables, if any (in our example : list(icon_state = "rock") and list())
	var/list/cached = modelCache[model]
	var/index

	if(cached)
		members = cached[1]
		members_attributes = cached[2]
	else

		/////////////////////////////////////////////////////////
		//Constructing members and corresponding variables lists
		////////////////////////////////////////////////////////

		members = list()
		members_attributes = list()
		index = 1

		var/old_position = 1
		var/dpos

		do
			//finding next member (e.g /turf/wall/dummy{icon_state = "rock"} or /area/mine/explored)
			dpos = find_next_delimiter_position(model, old_position, ",", "{", "}") //find next delimiter (comma here) that's not within {...}

			var/full_def = trim_text(copytext(model, old_position, dpos)) //full definition, e.g : /obj/foo/bar{variables=derp}
			var/variables_start = findtext(full_def, "{")
			var/atom_def = text2path(trim_text(copytext(full_def, 1, variables_start))) //path definition, e.g /obj/foo/bar

			if(dpos)
				old_position = dpos + length(model[dpos])

			if(!atom_def) // Skip the item if the path does not exist.  Fix your crap, mappers!
				continue
			members.Add(atom_def)

			//transform the variables in text format into a list (e.g {var1="derp"; var2; var3=7} => list(var1="derp", var2, var3=7))
			var/list/fields = list()

			if(variables_start)//if there's any variable
				full_def = copytext(full_def, variables_start + length(full_def[variables_start]), -length(copytext_char(full_def, -1))) //removing the last '}'
				fields = readlist(full_def, ";", TRUE)
				if(fields.len)
					if(!trim(fields[fields.len]))
						--fields.len
					for(var/I in fields)
						var/value = fields[I]
						if(istext(value))
							fields[I] = apply_text_macros(value)

			// Rotate dir if orientation isn't south (default)
			// if(fields["dir"])
				// fields["dir"] = turn(fields["dir"], dir2angle(orientation) + 180)
			// else
				// fields["dir"] = turn(SOUTH, dir2angle(orientation) + 180)

			//then fill the members_attributes list with the corresponding variables
			members_attributes.len++
			members_attributes[index++] = fields

			//CHECK_TICK
		while(dpos != 0)

		//check and see if we can just skip this turf
		//So you don't have to understand this horrid statement, we can do this if
		// 1. no_changeturf is set
		// 2. the space_key isn't set yet
		// 3. there are exactly 2 members
		// 4. with no attributes
		// 5. and the members are world.turf and world.area
		// Basically, if we find an entry like this: "XXX" = (/turf/default, /area/default)
		// We can skip calling this proc every time we see XXX
		if(no_changeturf && !space_key && members.len == 2 && members_attributes.len == 2 && length(members_attributes[1]) == 0 && length(members_attributes[2]) == 0 && (world.area in members) && (world.turf in members))
			space_key = model_key
			return


		modelCache[model] = list(members, members_attributes)


	////////////////
	//Instanciation
	////////////////

	//The next part of the code assumes there's ALWAYS an /area AND a /turf on a given tile
	var/turf/crds = locate(xcrd,ycrd,zcrd)

	//first instance the /area and remove it from the members list
	index = LAZYLEN(members)
	if(members[index] != /area/template_noop)
		var/atom/instance

		var/atype = members[index]
		for(var/area/A as anything in all_areas)
			if(A.type == atype)
				instance = A
				break
		if(!instance)
			instance = new atype(null)

		if(crds)
			instance.contents.Add(crds)

		if(LAZYLEN(members_attributes[index]))
			for(var/attribute in members_attributes[index])
				var/value = members_attributes[index][attribute]
				if(islist(value))
					value = deepCopyList(value)
				instance.vars[attribute] = value


	//then instance the /turf and, if multiple tiles are presents, simulates the DMM underlays piling effect

	var/first_turf_index = 1
	while(!ispath(members[first_turf_index], /turf)) //find first /turf object in members
		first_turf_index++

	//turn off base new Initialization until the whole thing is loaded
	// SSatoms.map_loader_begin()
	//instanciate the first /turf
	var/turf/T
	if(members[first_turf_index] != /turf/template_noop)
		T = instance_atom(members[first_turf_index],members_attributes[first_turf_index],crds,no_changeturf)

	if(T)
		//if others /turf are presents, simulates the underlays piling effect
		index = first_turf_index + 1
		while(index <= members.len - 1) // Last item is an /area
			var/underlay = T.appearance
			T = instance_atom(members[index],members_attributes[index],crds,no_changeturf)//instance new turf
			T.underlays += underlay
			index++

	//finally instance all remainings objects/mobs
	for(index in 1 to first_turf_index-1)
		instance_atom(members[index],members_attributes[index],crds,no_changeturf)
	//Restore initialization to the previous value
	// SSatoms.map_loader_stop()

////////////////
//Helpers procs
////////////////

//Instance an atom at (x,y,z) and gives it the variables in attributes
/datum/controller/subsystem/mapping/proc/instance_atom(path, list/attributes, turf/crds, no_changeturf)
	var/atom/atom
	if(crds)
		if(!no_changeturf && ispath(path, /turf))
			atom = crds.ChangeTurf(path, FALSE, TRUE)
		else
			atom = new path (crds)//first preloader pass

//	if(use_preloader && .)//second preloader pass, for those atoms that don't ..() in New()

	for(var/attribute in attributes)
		var/value = attributes[attribute]
		if(islist(value))
			value = deepCopyList(value)
		if(value == "Waste to Wasting")
			value = value
		atom.vars[attribute] = value

	return atom

	// Custom CHECK_TICK here because we don't want things created while we're sleeping to not initialize
	// if(TICK_CHECK)
	// 	SSatoms.map_loader_stop()
	// 	stoplag()
	// 	SSatoms.map_loader_begin()


//text trimming (both directions) helper proc
//optionally removes quotes before and after the text (for variable name)
/datum/controller/subsystem/mapping/proc/trim_text(what as text,trim_quotes=0)
	if(trim_quotes)
		return trimQuotesRegex.Replace(what, "")
	else
		return trimRegex.Replace(what, "")


//find the position of the next delimiter,skipping whatever is comprised between opening_escape and closing_escape
//returns 0 if reached the last delimiter
/datum/controller/subsystem/mapping/proc/find_next_delimiter_position(text as text,initial_position as num, delimiter=",",opening_escape="\"",closing_escape="\"")
	var/position = initial_position
	var/next_delimiter = findtext(text,delimiter,position,0)
	var/next_opening = findtext(text,opening_escape,position,0)

	while((next_opening != 0) && (next_opening < next_delimiter))
		position = findtext(text,closing_escape,next_opening + 1,0)+1
		next_delimiter = findtext(text,delimiter,position,0)
		next_opening = findtext(text,opening_escape,position,0)

	return next_delimiter


//build a list from variables in text form (e.g {var1="derp"; var2; var3=7} => list(var1="derp", var2, var3=7))
// text - variables in text form.  Not including surrounding {} or list()
// delimiter - Delimiter between list entries
// keys_only_string - If true, text that looks like an associative list has its keys treated as var names,
//                    otherwise they are parsed as valid associative list keys.
//return the filled list
/datum/controller/subsystem/mapping/proc/readlist(text as text, delimiter=",", keys_only_string = FALSE)

	var/list/to_return = list()
	if(text == "")
		return to_return // Fast bail-out

	var/position
	var/old_position = 1

	do
		//find next delimiter that is not within  "..."
		position = find_next_delimiter_position(text,old_position,delimiter)

		//check if this is a simple variable (as in list(var1, var2)) or an associative one (as in list(var1="foo",var2=7))
		var/equal_position = findtext(text,"=",old_position, position)

		// part to the left of = (the key/var name), or the entire value. If treating it as a var name, strip quotes at the same time.
		var/trim_left = trim_text(copytext(text,old_position,(equal_position ? equal_position : position)), keys_only_string)
		if(position)
			old_position = position + length(text[position])

		var/trim_right = trim_left
		if(equal_position)//associative var, so do the association
			trim_right = trim_text(copytext(text, equal_position + length(text[equal_position]), position))//the content of the variable
			if(!keys_only_string) // We also need to evaluate the key for the types it is permitted to be
				if(findtext(trim_left,"\"",1,2)) //Check for string
					trim_left = copytext(trim_left,2,findtext(trim_left,"\"",3,0))
				else if(isnum(text2num(trim_left))) //Check for number
					trim_left = text2num(trim_left)
				else if(ispath(text2path(trim_left))) //Check for path
					trim_left = text2path(trim_left)

		// Parse the value in trim_right
		//Check for string
		if(findtext(trim_right,"\"",1,2))
			trim_right = copytext(trim_right,2,findtext(trim_right,"\"",3,0))
		//Check for number
		else if(isnum(text2num(trim_right)))
			trim_right = text2num(trim_right)
		//Check for null
		else if(trim_right == "null")
			trim_right = null
		//Check for list
		else if(copytext(trim_right,1,5) == "list")
			trim_right = readlist(copytext(trim_right,6,length(trim_right)))
		//Check for file
		else if(copytext(trim_right,1,2) == "'")
			trim_right = file(copytext(trim_right,2,length(trim_right)))
		//Check for path
		else if(ispath(text2path(trim_right)))
			trim_right = text2path(trim_right)

		// Now put the trim_right into the result.  Method by which we do so varies on if its assoc or not
		if(equal_position)
			to_return[trim_left] = trim_right
		else
			to_return += trim_right

	while(position != 0)

	return to_return
