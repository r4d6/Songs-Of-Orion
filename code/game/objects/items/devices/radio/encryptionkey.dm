
/obj/item/device/encryptionkey
	name = "standard encryption key"
	desc = "An encryption key for a radio headset. Contains cypherkeys."
	icon = 'icons/obj/radio.dmi'
	icon_state = "cypherkey"
	item_state = ""
	w_class = ITEM_SIZE_TINY
	slot_flags = SLOT_EARS
	spawn_blacklisted = TRUE
	description_antag = "This is a special key with acces to restricted channels"
	matter = list(MATERIAL_STEEL = 0.5, MATERIAL_SILVER = 0.5)
	var/translate_binary = FALSE
	var/translate_hive = FALSE
	var/syndie = FALSE
	var/merc = FALSE
	var/pirate = FALSE
	var/list/channels = list()

/obj/item/device/encryptionkey/attackby(obj/item/W, mob/user)

/obj/item/device/encryptionkey/syndicate
	icon_state = "cypherkey"
	channels = list("Mercenary" = 1)
	origin_tech = list(TECH_COVERT = 3)
	syndie = TRUE//Signifies that it de-crypts Syndicate transmissions

/obj/item/device/encryptionkey/mercenaries
	icon_state = "cypherkey"
	channels = list("Mercenary" = 1)
	merc = TRUE

/obj/item/device/encryptionkey/pirates
	icon_state = "cypherkey"
	channels = list("Pirate" = 1)
	pirate = TRUE

/obj/item/device/encryptionkey/binary
	icon_state = "cypherkey"
	translate_binary = TRUE
	origin_tech = list(TECH_COVERT = 3)

/obj/item/device/encryptionkey/headset_sec
	name = "security radio encryption key"
	icon_state = "sec_cypherkey"
	channels = list("Security" = 1)

/obj/item/device/encryptionkey/headset_eng
	name = "engineering radio encryption key"
	icon_state = "eng_cypherkey"
	channels = list("Engineering" = 1)

/obj/item/device/encryptionkey/headset_rob
	name = "moebius robotics radio encryption key"
	icon_state = "rob_cypherkey"
	channels = list("Engineering" = 1, "Science" = 1)

/obj/item/device/encryptionkey/headset_med
	name = "Brotherhood radio encryption key"
	icon_state = "med_cypherkey"
	channels = list("Medical" = 1)

/obj/item/device/encryptionkey/headset_sar
	name = "SAR radio encryption key"
	icon_state = "sec_cypherkey"
	channels = list("Security" = 1, "Medical" = 1)

/obj/item/device/encryptionkey/headset_church
	name = "neotheology radio encryption key"
	icon_state = "nt_cypherkey"
	channels = list("NT Voice" = 1)

/obj/item/device/encryptionkey/headset_sci
	name = "moebius science radio encryption key"
	icon_state = "sci_cypherkey"
	channels = list("Science" = 1)

/obj/item/device/encryptionkey/headset_moebius
	name = "Moebius laboratories encryption key"
	icon_state = "sci_cypherkey"
	channels = list("Science" = 1, "Medical" = 1)

/obj/item/device/encryptionkey/headset_com
	name = "Eris command radio encryption key"
	icon_state = "com_cypherkey"
	channels = list("Command" = 1)

/obj/item/device/encryptionkey/heads/captain
	name = "Eris captain's encryption key"
	icon_state = "cap_cypherkey"
	channels = list("Command" = 1, "Security" = 1, "Engineering" = 1, "Science" = 1, "Medical" = 1, "Supply" = 1, "Service" = 1)

/obj/item/device/encryptionkey/heads/ai_integrated
	name = "ai integrated encryption key"
	desc = "Integrated encryption key"
	icon_state = "cap_cypherkey"
	channels = list("Command" = 1, "Security" = 1, "Engineering" = 1, "Science" = 1, "Medical" = 1, "Supply" = 1, "Service" = 1, "AI Private" = 1)

/obj/item/device/encryptionkey/heads/rd
	name = "expedition overseer's encryption key"
	icon_state = "rd_cypherkey"
	channels = list("Science" = 1, "Command" = 1)

/obj/item/device/encryptionkey/heads/moebius
	name = "Moebius command encryption key"
	icon_state = "rd_cypherkey"
	channels = list("Science" = 1, "Medical" = 1, "Command" = 1)

/obj/item/device/encryptionkey/heads/hos
	name = "Ironhammer commander's encryption key"
	icon_state = "hos_cypherkey"
	channels = list("Security" = 1, "Command" = 1)

/obj/item/device/encryptionkey/heads/ce
	name = "exultant's encryption key"
	icon_state = "ce_cypherkey"
	channels = list("Engineering" = 1, "Command" = 1)

/obj/item/device/encryptionkey/heads/cmo
	name = "Biolab officer's encryption key"
	icon_state = "cmo_cypherkey"
	channels = list("Medical" = 1, "Command" = 1)

/obj/item/device/encryptionkey/heads/hop
	name = "First Officer's encryption key"
	icon_state = "hop_cypherkey"
	channels = list("Command" = 1, "Security" = 1, "Engineering" = 1, "Science" = 1, "Medical" = 1, "Supply" = 1, "Service" = 1)

/obj/item/device/encryptionkey/heads/merchant
	name = "Asters Merchant radio encryption key"
	icon_state = "qm_cypherkey"
	channels = list("Supply" = 1, "Command" = 1)

/obj/item/device/encryptionkey/heads/preacher
	name = "NeoTheology Preacher radio encryption key"
	icon_state = "preach_cypherkey"
	channels = list("NT Voice" = 1, "Command" = 1)

/obj/item/device/encryptionkey/headset_cargo
	name = "Asters Guild radio encryption key"
	icon_state = "cargo_cypherkey"
	channels = list("Supply" = 1)

/obj/item/device/encryptionkey/headset_service
	name = "service radio encryption key"
	icon_state = "srv_cypherkey"
	channels = list("Service" = 1)

/obj/item/device/encryptionkey/entertainment
	name = "entertainment radio key"
	channels = list("Entertainment" = 1)

//addition to /obj/item/card/id/all_access
/obj/item/device/encryptionkey/heads/admin
	name = "Admin encryption key"
	desc = "Full powers encryption key"
	icon_state = "cap_cypherkey"
	channels = list("Command" = 1, "Security" = 1, "Engineering" = 1, "Science" = 1, "Medical" = 1, "Supply" = 1, "Service" = 1, "AI Private" = 1, "Mercenary" = 1)

/obj/item/device/encryptionkey/heads/military
	name = "Military command encryption key"
	icon_state = "cap_cypherkey"
	channels = list("Special Ops" = 1, "Command" = 1, "Security" = 1, "Engineering" = 1, "Science" = 1, "Medical" = 1, "Supply" = 1, "Service" = 1)

/obj/item/device/encryptionkey/military
	name = "Military encryption key"
	icon_state = "cap_cypherkey"
	channels = list("Special Ops" = 1, "Security" = 1, "Engineering" = 1, "Medical" = 1)
