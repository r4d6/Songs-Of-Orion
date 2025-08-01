/datum/extension
	var/datum/holder = null // The holder
	var/list/host_predicates
	var/list/user_predicates
	var/expected_type = /datum

/datum/extension/New(datum/holder, host_predicates = list(), user_predicates = list(), additional_arguments = list())
	if(!istype(holder, expected_type))
		CRASH("Invalid holder type. Expected [expected_type], was [holder.type]")
	src.holder = holder
	..()

	src.host_predicates = host_predicates ? host_predicates : list()
	src.user_predicates = user_predicates ? user_predicates : list()

/datum/extension/Destroy()
	holder = null
	host_predicates.Cut()
	user_predicates.Cut()
	return ..()

/datum/extension/proc/extension_status(mob/user)
	if(!holder || !user)
		return STATUS_CLOSE
	if(!all_predicates_true(list(holder), host_predicates))
		return STATUS_CLOSE
	if(!all_predicates_true(list(user), user_predicates))
		return STATUS_CLOSE
	if(holder.CanUseTopic(usr,GLOB.default_state) != STATUS_INTERACTIVE)
		return STATUS_CLOSE
	return STATUS_INTERACTIVE

/datum/extension/proc/extension_act(href, list/href_list, mob/user)
	return extension_status(user) == STATUS_CLOSE

/datum/extension/Topic(href, list/href_list)
	if(..())
		return TRUE
	return extension_act(href, href_list, usr)

/datum
	var/list/datum/extension/extensions

/proc/set_extension(datum/source, base_type, expansion_type, host_predicates, user_predicates, list/additional_argments)
	if(!source.extensions)
		source.extensions = list()
	source.extensions[base_type] = list(expansion_type, host_predicates, user_predicates, additional_argments)

/proc/get_extension(datum/source, base_type)
	if(!source.extensions)
		return
	var/list/expansion = source.extensions[base_type]
	if(!expansion)
		return
	if(istype(expansion))
		var/expansion_type = expansion[1]
		expansion = new expansion_type(source, expansion[2], expansion[3], expansion[4])
		source.extensions[base_type] = expansion
	return expansion

/proc/get_or_create_extension(datum/source, base_type, extension_type)
	if(!has_extension(source, base_type))
		set_extension(arglist(args))
	return get_extension(source, base_type)

//Fast way to check if it has an extension, also doesn't trigger instantiation of lazy loaded extensions
/proc/has_extension(datum/source, base_type)
	return (source.extensions && source.extensions[base_type])
