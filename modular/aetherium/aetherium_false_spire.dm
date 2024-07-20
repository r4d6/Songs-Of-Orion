// False Spires have a limit to how far their crystals can spread.
// Unlike True Spires, False Spires are destructible.
/obj/structure/aetherium_crystal/spire/false
	name = "false aetherium spire"
	desc = "A strange crystal formation that seems to grow on its own..."
	icon_state = "aetherium_crystal_purple"
	shooter = TRUE // They can shoot at you
	recharge_delay = 90 SECONDS // 1.5 minutes before it gain a shot
	max_projectiles = 20 // 30 minutes to fully recharge
	is_fake = TRUE
	growth = 25 // False Spires are worth a lot of shards.
	spread_range = 3

/obj/structure/aetherium_crystal/spire/false/update_icon()
	transform = initial(transform)
	transform *= 1.25 // 25% bigger
