// Placeholder name
/mob/living/carbon/superior_animal/aetherium_golem/aetherium_shooter
	name = "aetherium shooter"
	desc = "A weird creature made of aetherium. It is quadruped and seems to shoot aetherium shards."
	health = 150
	maxHealth = 150
	armor = list(melee = 10, bullet = 40, energy = 45, bomb = 30, bio = 100, rad = 100) //We want to be rushed in melee, not shot.
	ranged = TRUE
	rapid = TRUE
	projectiletype = /obj/item/projectile/aetherium_shard/weak
	melee_damage_lower = 10
	melee_damage_upper = 15

