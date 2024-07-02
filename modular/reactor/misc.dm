/obj/machinery/multistructure/nuclear_reactor_part
	icon = './placeholders.dmi'
	MS_type = /datum/multistructure/nuclear_reactor

/obj/machinery/multistructure/nuclear_reactor_part/wall
	icon_state = "wall"

/obj/machinery/multistructure/nuclear_reactor_part/wall_input
	icon_state = "wall_input"

/obj/machinery/multistructure/nuclear_reactor_part/wall_output
	icon_state = "wall_output"

/obj/item/control_rod
	name = "control rod"
	desc = "A rod made of graphite, designed to moderate nuclear reactions by its presence."
	icon = './placeholders.dmi'
	icon_state = "control_rod"
	var/durability = 100

/obj/item/fuel_rod
	name = "aetherium fuel rod"
	desc = "A rod made of aetherium, acting as a suitable substitute for proper nuclear fuel. It is contained within a lead casing."
	icon = './placeholders.dmi'
	icon_state = "fuel_rod"
	var/durability = 100
	var/consumption_rate = 1
	var/heat_production = 100 // How much does the fuel rod increase the temperature of the reactor, in celcius
