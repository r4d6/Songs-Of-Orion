/obj/machinery/computer/sensors
	name = "sensors console"
	icon_state = "thick"
	icon_keyboard = "teleport_key"
	icon_screen = "teleport"
	light_color = COLOR_LIGHTING_CYAN_MACHINERY
	//circuit = /obj/item/electronics/circuitboard/sensors
	var/obj/effect/overmap/ship/linked
	var/obj/machinery/shipsensors/sensors
	var/viewing = 0

/obj/machinery/computer/sensors/Initialize()
	. = ..()
	linked = map_sectors["[z]"]
	find_sensors()

/obj/machinery/computer/sensors/Destroy()
	sensors = null
	. = ..()

/obj/machinery/computer/sensors/proc/find_sensors()
	for(var/obj/machinery/shipsensors/S in GLOB.machines)
		if(S.z in SSmapping.GetConnectedZlevels(z))
			sensors = S
			break

/obj/machinery/computer/sensors/nano_ui_interact(mob/user, ui_key = "main", datum/nanoui/ui, force_open = NANOUI_FOCUS)
	if(!linked)
		return

	var/data[0]
	data["viewing"] = viewing
	if(sensors)
		data["on"] = sensors.use_power
		data["range"] = sensors.range
		data["health"] = sensors.health
		data["maxHealth"] = sensors.maxHealth
		data["heat"] = sensors.current_heat
		data["critical_heat"] = sensors.critical_heat
		if(sensors.health == 0)
			data["status"] = "DESTROYED"
		else if(!sensors.powered())
			data["status"] = "NO POWER"
		else if(!sensors.in_vacuum())
			data["status"] = "VACUUM SEAL BROKEN"
		else
			data["status"] = "OK"
	else
		data["status"] = "MISSING"
		data["range"] = "N/A"
		data["on"] = 0

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "shipsensors.tmpl", "[linked.name] Sensors Control", 420, 530)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/computer/sensors/check_eye(mob/user)
	if(!viewing)
		return -1
	if(!get_dist(user, src) > 1 || user.blinded || !linked )
		viewing = 0
		return -1
	return 0

/obj/machinery/computer/sensors/attack_hand(mob/user)
	if(..())
		user.unset_machine()
		viewing = 0
		return

	if(!isAI(user))
		user.set_machine(src)
		if(linked)
			user.reset_view(linked)
	nano_ui_interact(user)

/obj/machinery/computer/sensors/Topic(href, href_list, state)
	if(..())
		return 1

	if(!linked)
		return

	if(href_list["viewing"])
		viewing = !viewing
		if(viewing && usr && !isAI(usr))
			usr.reset_view(linked)
		return 1

	if(href_list["link"])
		find_sensors()
		return 1

	if(sensors)
		if(href_list["range"])
			var/nrange = input("Set new sensors range", "Sensor range", sensors.range) as num|null
			if(!CanInteract(usr,state))
				return
			if(nrange)
				sensors.set_range(CLAMP(nrange, 1, world.view))
			return 1
		if(href_list["toggle"])
			sensors.toggle()
			return 1

/obj/machinery/computer/sensors/Process()
	..()
	if(!linked)
		return
	if(sensors && sensors.use_power && sensors.powered())
		linked.set_light(sensors.range+1, 5)
	else
		linked.set_light(0)

/obj/machinery/shipsensors
	name = "sensors suite"
	desc = "Long range gravity scanner with various other sensors, used to detect irregularities in surrounding space. Can only run in vacuum to protect delicate quantum BS elements."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "sensors"
	maxHealth = 200
	health = 200
	var/critical_heat = 50 // sparks and takes damage when active & above this heat
	var/heat_reduction = 1.5 // mitigates this much heat per tick
	var/current_heat = 0
	var/range = 1
	idle_power_usage = 5000

/obj/machinery/shipsensors/attackby(obj/item/W, mob/user)
	var/damage = maxHealth - health
	if(damage && (QUALITY_WELDING in W.tool_qualities))
		to_chat(user, "<span class='notice'>You start repairing the damage to [src].</span>")
		if(W.use_tool(user, src, WORKTIME_NORMAL, QUALITY_WELDING, FAILCHANCE_EASY, required_stat = STAT_ROB))
			playsound(src, 'sound/items/Welder.ogg', 100, 1)
			to_chat(user, "<span class='notice'>You finish repairing the damage to [src].</span>")
			take_damage(-damage)
		return
	..()


/obj/machinery/shipsensors/proc/in_vacuum()
	var/turf/T=get_turf(src)
	if(istype(T))
		var/datum/gas_mixture/environment = T.return_air()
		if(environment && environment.return_pressure() > MINIMUM_PRESSURE_DIFFERENCE_TO_SUSPEND)
			return 0
	return 1

/obj/machinery/shipsensors/update_icon()
	if(use_power)
		icon_state = "sensors"
	else
		icon_state = "sensors_off"

/obj/machinery/shipsensors/examine(mob/user, extra_description = "")
	if(health <= 0)
		extra_description += "\n\The [src] is wrecked."
	else if(health < maxHealth * 0.25)
		extra_description += SPAN_DANGER("\n\The [src] looks like it's about to break!")
	else if(health < maxHealth * 0.5)
		extra_description += SPAN_DANGER("\n\The [src] looks seriously damaged!")
	else if(health < maxHealth * 0.75)
		extra_description += "\nThe [src] shows signs of damage!"
	..(user, extra_description)

/obj/machinery/shipsensors/bullet_act(obj/item/projectile/Proj)
	take_damage(Proj.get_structure_damage())
	..()

/obj/machinery/shipsensors/proc/toggle()
	if(!use_power && health == 0)
		return
	if(!use_power) //need some juice to kickstart
		use_power(idle_power_usage*5)
	set_power_use(use_power ? IDLE_POWER_USE : NO_POWER_USE)
	update_icon()

/obj/machinery/shipsensors/Process()
	..()
	if(use_power) //can't run in non-vacuum
		if(!in_vacuum())
			toggle()
		if(current_heat > critical_heat)
			src.visible_message("<span class='danger'>\The [src] violently spews out sparks!</span>")
			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
			s.set_up(3, 1, src)
			s.start()

			take_damage(rand(10,50))
			toggle()
		current_heat += idle_power_usage/15000

	if(current_heat > 0)
		current_heat = max(0, current_heat - heat_reduction)

/obj/machinery/shipsensors/power_change()
	if(use_power && !powered())
		toggle()

/obj/machinery/shipsensors/proc/set_range(nrange)
	range = nrange
	idle_power_usage = 1500 * (range**2) // Exponential increase, also affects speed of overheating

/obj/machinery/shipsensors/emp_act(severity)
	if(!use_power)
		return
	take_damage(20/severity)
	toggle()

/obj/machinery/shipsensors/take_damage(value)
	health = min(max(health - value, 0),maxHealth)
	if(use_power && health == 0)
		toggle()
