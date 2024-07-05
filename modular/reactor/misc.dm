/obj/machinery/multistructure/nuclear_reactor_part
	icon = './placeholders.dmi'
	MS_type = /datum/multistructure/nuclear_reactor
	anchored = TRUE

/obj/machinery/multistructure/nuclear_reactor_part/wall
	name = "containement wall"
	icon_state = "wall"

/obj/machinery/multistructure/nuclear_reactor_part/wall_input
	name = "reactor gas input"
	icon_state = "wall_input"

/obj/machinery/multistructure/nuclear_reactor_part/wall_output
	name = "reactor gas output"
	icon_state = "wall_output"

/obj/item/control_rod
	name = "control rod"
	desc = "A rod made of graphite, designed to moderate nuclear reactions by its presence."
	icon = 'placeholders.dmi'
	icon_state = "control_rod"
	var/durability = 100

/obj/item/fuel_rod
	name = "aetherium fuel rod"
	desc = "A rod made of aetherium, acting as a suitable substitute for proper nuclear fuel. It is contained within a lead casing."
	icon = 'placeholders.dmi'
	icon_state = "fuel_rod"
	var/durability = 100
	var/consumption_rate = 0.1
	var/heat_production = 100 // How much does the fuel rod increase the temperature of the reactor, in celcius

/obj/item/fuel_rod/thorium
	name = "thorium fuel rod"
	desc = "A rod made of thorium, acting as a suitable substitute for proper nuclear fuel. It is contained within a lead casing."
	heat_production = 50

/obj/item/fuel_rod/uranium
	name = "uranium fuel rod"
	desc = "A rod made of uranium, acting as a suitable substitute for proper nuclear fuel. It is contained within a lead casing."
	heat_production = 25

/obj/item/fuel_rod/low_uranium
	name = "low uranium fuel rod"
	desc = "A rod made of low-quality uranium, acting as a barely suitable substitute for proper nuclear fuel. It is contained within a lead casing."
	heat_production = 10
