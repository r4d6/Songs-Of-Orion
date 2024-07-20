// Aetherium-based Weaponry require an aetherium gem to be usable and consume liquid aetherium as ammo.

/obj/item/gun/aetherium
	name = "aetherium gemlight rifle"
	desc = "A gun using liquid aetherium to shoot a beam of deadly radiation. It require an aetherium gem & liquid aetherium to work."
	icon = 'icons/obj/guns/aetherium/aetherium_cog.dmi'
	icon_state = "aetherium_cog"
	item_state = "aetherium_cog"
	fire_delay = 25
	slot_flags = SLOT_BACK // Can only fit in the back
	twohanded = FALSE
	max_upgrades = 3
	fire_sound = 'sound/weapons/wave.ogg'
	init_firemodes = list(
		WEAPON_NORMAL,
		BURST_3_ROUND
	)
	reagent_flags = REFILLABLE |  DRAINABLE | TRANSPARENT
	var/projectile_type = /obj/item/projectile/beam/aetherium // What does it shoot
	var/internal_tank_size = 250 // How many reagents can the gun hold.
	var/use_amount = 10 // How much fuel is used per shot
	var/ammo_type = MATERIAL_AETHERIUM // What kind of chem do we use?
	var/obj/item/aetherium_gem/core // The aetherium gem the gun need to work
	serial_type = "GP" //Cog?

/obj/item/gun/aetherium/Initialize(mapload, ...)
	..()
	create_reagents(internal_tank_size)
	if(mapload)
		core = new(src) // Give the gun a new core when mapped in.
		reagents.add_reagent(MATERIAL_AETHERIUM, reagents.maximum_volume) // Start filled with aetherium

/obj/item/gun/aetherium/examine(mob/user)
	..(user)
	if(!core)
		to_chat(user, SPAN_NOTICE("[src] has no aetherium gem."))
		return
	if(use_amount) // In case we don't use any ammo
		to_chat(user, "[src] has [round(reagents.get_reagent_amount(ammo_type) / use_amount)] shot\s remaining.")
	return

/obj/item/gun/aetherium/MouseDrop(over_object)
	if((src.loc == usr) && istype(over_object, /obj/screen/inventory/hand) && eject_item(core, usr))
		core = null
		update_icon()

/obj/item/gun/aetherium/attackby(obj/item/W as obj, mob/living/user as mob)
	if(core && istype(W, /obj/item/aetherium_gem))
		to_chat(usr, SPAN_WARNING("[src] already has a gem."))
		return

	if(istype(W, /obj/item/aetherium_gem) && insert_item(W, usr))
		core = W
		update_icon()
		return

	..()

/obj/item/gun/aetherium/consume_next_projectile()
	if(!core) // Do we have a fuel can?
		return null
	if(!ispath(projectile_type)) // Do we actually shoot something?
		return null
	if(!reagents.remove_reagent(ammo_type, use_amount)) // Do we have enough fuel? (Also consume the fuel if we have enough)
		return null
	return new projectile_type(src)

// Aetherium shard launcher. Launches solid fragment of aetherium that can embed
/obj/item/gun/matter/aetherium
	name = "aetherium shard launcher"
	desc = "A gun that fire shards of solid aetherium."
	icon = 'icons/obj/guns/aetherium/aetherium_cog.dmi'
	icon_state = "aetherium_cog"
	item_state = "aetherium_cog"
	//fire_sound = 'sound/weapons/rail.ogg'
	matter_type = MATERIAL_AETHERIUM
	projectile_type = /obj/item/projectile/aetherium_shard/weak/human

// Sonic Gun, very effective against golems.
/obj/item/gun/energy/sonic_emitter
	name = "\"Shatter\" bane pistol"
	desc = "A magi-tech weapon specifically designed to deal with natural rock golems made from aetherium. Largely harmless to anyone else but highly lethal to its intended target from which its \
	bane enchantment was designed for."
	icon = 'icons/obj/guns/energy/sonic_emitter.dmi'
	icon_state = "sonic_emitter"
	item_state = "sonic_emitter"
	charge_meter = FALSE
	matter = list(MATERIAL_IRON = 10, MATERIAL_BRASS = 5)
	price_tag = 500
	charge_cost = 1000
	fire_sound = 'sound/effects/basscannon.ogg'
	suitable_cell = /obj/item/cell/large
	cell_type = /obj/item/cell/large
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	projectile_type = /obj/item/projectile/sonic_bolt
	fire_delay = 25
	max_upgrades = 0

/obj/item/gun/energy/sonic_emitter/preloaded/New()
	cell = new /obj/item/cell/large/super(src)
	. = ..()
	update_icon()
	serial_type = "SI"
