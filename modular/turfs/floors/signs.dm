

/obj/structure/sign/semiotic
	name = "semiotic standard signage"
	icon = 'modular/turfs/floors/icon/decals_small.dmi'
	description_info = "The Semiotic Standard is a pictographic system older than recorded history and known by everyone."

/obj/structure/sign/semiotic/attackby(obj/item/tool as obj, mob/user as mob)	//construction
	if(istype(tool, /obj/item/tool/screwdriver) && isturf(user.loc))
		to_chat(user, "You somehow destroy the sign with your [tool].")
		qdel(src)
	else ..()


/obj/structure/sign/semiotic/pressgrav
	name = "pressurized area"
	icon_state = "pressgrav"
	desc = "Pressurized area with gravity."

/obj/structure/sign/semiotic/nograv
	name = "no gravity"
	icon_state = "nograv"
	desc = "Pressurized area that frequently lacks gravity."

/obj/structure/sign/semiotic/cryo
	name = "cryogenic vault"
	icon_state = "cryo"
	desc = "Cryogenic personnel storage."

/obj/structure/sign/semiotic/airlock
	name = "airlock"
	icon_state = "airlock"
	desc = "Airlock or airlock staging area."

/obj/structure/sign/semiotic/bulkhead
	name = "bulkhead door"
	icon_state = "bulkhead"
	desc = "Outer airlock, leading directly to vacuum."

/obj/structure/sign/semiotic/vac
	name = "vacuum area"
	icon_state = "vac"
	desc = "Area may be or become depressurized or be exposed to vacuum intentionally as part of normal operations."

/obj/structure/sign/semiotic/eva
	name = "EVA equipment"
	icon_state = "eva"
	desc = "Extra-Vehicular preparation or storage, space suits and vacuum equipment."

/obj/structure/sign/semiotic/telecom
	name = "telecommunications"
	icon_state = "telecom"
	desc = "Telecommunications infrastructure, wireless or fiber optic distribution points."

/obj/structure/sign/semiotic/laser
	name = "laser radiation"
	icon_state = "laser"
	desc = "Laser equipment in use, multispectral or high-energy hazard."

/obj/structure/sign/semiotic/warning
	name = "WARNING"
	icon_state = "warning"
	desc = "Warning: significant hazard area, check other signage for details."

/obj/structure/sign/semiotic/spacegrav
	name = "EVA area"
	icon_state = "spacegrav"
	desc = "Vacuum exposed area with artifical gravity, suit required."

/obj/structure/sign/semiotic/space
	name = "space"
	icon_state = "space"
	desc = "Open space beyond, no gravity and hard vacuum: suit required."

/obj/structure/sign/semiotic/exhaust
	name = "exhaust"
	icon_state = "exhaust"
	desc = "Reactor or life support exhaust hazards present."

/obj/structure/sign/semiotic/radshield
	name = "radiation shielded area"
	icon_state = "radshield"
	desc = "Area hardened against radiation hazards, storm shelter."

/obj/structure/sign/semiotic/rad
	name = "radiation"
	icon_state = "radhaz"
	desc = "Radiation hazards present."

/obj/structure/sign/semiotic/radhigh
	name = "high radiation area"
	icon_state = "radhigh"
	desc = "High radiation hazard area, trained personnel with appropriate protective equipment only."

/obj/structure/sign/semiotic/cold
	name = "low temperature area"
	icon_state = "cold"
	desc = "Low temperatures/active refrigeration present."

/obj/structure/sign/semiotic/galley
	name = "galley"
	icon_state = "galley"
	desc = "Galley or food services."

/obj/structure/sign/semiotic/coffee
	name = "coffee"
	icon_state = "coffee"
	desc = "Coffee available, other hot drinks or stimulants possible."

/obj/structure/sign/semiotic/bridge
	name = "bridge"
	icon_state = "bridge"
	desc = "Bridge or Command And Control, authorized personnel only."

/obj/structure/sign/semiotic/bridge2
	name = "bridge"
	icon_state = "bridge2"
	desc = "Bridge or Command And Control, authorized personnel only."

/obj/structure/sign/semiotic/medical
	name = "medical"
	icon_state = "med"
	desc = "Medical services or first aid station."

/obj/structure/sign/semiotic/medical2
	name = "medical"
	icon_state = "med2"
	desc = "Medical services or first aid station."

/obj/structure/sign/semiotic/medical3
	name = "medical"
	icon_state = "med3"
	desc = "Medical services or first aid station."

/obj/structure/sign/semiotic/medical4
	name = "medical"
	icon_state = "med4"
	desc = "Medical services or first aid station."

/obj/structure/sign/semiotic/terminal
	name = "computer terminal"
	icon_state = "terminal"
	desc = "Computer terminal access."

/obj/structure/sign/semiotic/power
	name = "power systems"
	icon_state = "power"
	desc = "Electrical storage and distribution."

/obj/structure/sign/semiotic/life
	name = "life support"
	icon_state = "lifesup"
	desc = "Life support and atmospherics distribution, storage, or control."

/obj/structure/sign/semiotic/medlife
	name = "medical life support"
	icon_state = "medlife"
	desc = "Medical life support systems"

/obj/structure/sign/semiotic/medlife
	name = "medical life support"
	icon_state = "medlife2"
	desc = "Medical life support systems"

/obj/structure/sign/semiotic/maint
	name = "maintenance access"
	icon_state = "maint"
	desc = "Maintenance area access, infrastructure, etc."

/obj/structure/sign/semiotic/ladder
	name = "ladderway"
	icon_state = "ladder"
	desc = "Ladder access."

/obj/structure/sign/semiotic/stairs
	name = "stairway"
	icon_state = "stairs"
	desc = "Stairway access."

/obj/structure/sign/semiotic/comms
	name = "communications station"
	icon_state = "comms"
	desc = "Communications or command terminals."

/obj/structure/sign/semiotic/fire
	name = "fire hazard"
	icon_state = "fire"
	desc = "Flammable materials or high fire risk area. No smoking."

/obj/structure/sign/semiotic/damage
	name = "damage control"
	icon_state = "damage"
	desc = "Damage control or fire suppression equipment and systems."

/obj/structure/sign/semiotic/damage2
	name = "damage control"
	icon_state = "damage2"
	desc = "Damage control or fire suppression equipment and systems."

/obj/structure/sign/semiotic/damage3
	name = "damage control"
	icon_state = "damage3"
	desc = "Damage control or fire suppression equipment and systems."

/obj/structure/sign/semiotic/sec
	name = "security"
	icon_state = "sec"
	desc = "Security station or checkpoint."

/obj/structure/sign/semiotic/marshal
	name = "Mashals"
	icon_state = "marshal"
	desc = "Solar Marshal office."

/obj/structure/sign/semiotic/armory
	name = "armory"
	icon_state = "armory"
	desc = "Armory and tactical/defensive equipment storage."

/obj/structure/sign/semiotic/dock
	name = "dock"
	icon_state = "dock"
	desc = "Docking port, not to be confused with an airlock."

/obj/structure/sign/semiotic/fridge
	name = "cold organic storage"
	icon_state = "foodfridge"
	desc = "Cold organic storage, food or other biomatter."

/obj/structure/sign/semiotic/food
	name = "food storage"
	icon_state = "food"
	desc = "Dry or perishable food, fresh or rations."

/obj/structure/sign/semiotic/storage
	name = "storage"
	icon_state = "storage"
	desc = "Cargo or other goods, materials, or consumables."

/obj/structure/sign/semiotic/reactor
	name = "reactor"
	icon_state = "reactor"
	desc = "Primary nuclear power systems, extreme radiation hazards possible."

/obj/structure/sign/semiotic/evac
	name = "evac"
	icon_state = "evac"
	desc = "Evacuation staging area/escape pods."

/obj/structure/sign/semiotic/dejavu
	name = "deja vu"
	icon_state = "dejavu"
	desc = "Cognition/Recognition hazard area, double-think risk elevated."

/obj/structure/sign/semiotic/directional
	name = "fore"
	icon_state = "fore"
	desc = "A directional arrow."

/obj/structure/sign/semiotic/directional/aft
	name = "aft"
	icon_state = "aft"

/obj/structure/sign/semiotic/directional/port
	name = "port"
	icon_state = "port"

/obj/structure/sign/semiotic/directional/starboard
	name = "starboard"
	icon_state = "starboard"

/obj/structure/sign/semiotic/directional/fore2
	name = "fore2"
	icon_state = "fore2"

/obj/structure/sign/semiotic/directional/aft2
	name = "aft2"
	icon_state = "aft2"

/obj/structure/sign/semiotic/directional/port2
	name = "port2"
	icon_state = "port2"

/obj/structure/sign/semiotic/directional/starboard2
	name = "starboard2"
	icon_state = "starboard2"