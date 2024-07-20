// Special projectile that one-shot aetherium-related stuff
/obj/item/projectile/sonic_bolt
	name = "sonic bolt"
	icon_state = "energy2"
	damage_types = list(BRUTE = 10)
	//armor_penetration = 30 // It is a sound-wave liquifing organs I guess
	kill_count = 7
	check_armour = ARMOR_ENERGY
	var/golem_damage_bonus = 20 // Damage multiplier against aetheriums.
	recoil = 7

/obj/item/projectile/sonic_bolt/heavy
	damage_types = list(BRUTE = 30)
	kill_count = 14
	recoil = 10

/obj/item/projectile/beam/aetherium
	name = "aetherium"
	icon_state = "xray"
	mob_hit_sound = list('sound/effects/gore/sear.ogg')
	hitsound_wall = 'sound/weapons/guns/misc/laser_searwall.ogg'
	damage_types = list(BURN  = 30) // 10 more damage than the Cog
	//irradiate = 25
	//armor_penetration = 15 // 5 less AP than the Cog
	check_armour = ARMOR_ENERGY
	hitscan = TRUE
	invisibility = 101	//beam projectiles are invisible as they are rendered by the effect engine
	muzzle_type = /obj/effect/projectile/aetherium/muzzle
	tracer_type = /obj/effect/projectile/aetherium/tracer
	impact_type = /obj/effect/projectile/aetherium/impact
	kill_count = 15 // How long until they disapear

/obj/item/projectile/aetherium_shard
	name = "aetherium shard"
	damage_types = list(BRUTE = 40)
	//irradiate = 10 No radiation in hammerfall
	//armor_penetration = 25
	check_armour = ARMOR_BULLET
	embed = TRUE
	//shrapnel_type = /obj/item/material/shard/aetherium
	friendly_fire_faction = list("aetherium") // We pass through mobs with this faction

// Less damage
/obj/item/projectile/aetherium_shard/weak
	damage_types = list(BRUTE = 20)

// Human-created projectile that DOESN'T pass through aetherium mobs
/obj/item/projectile/aetherium_shard/weak/human
	friendly_fire_faction = list()

