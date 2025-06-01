/obj/item/clothing/head/soft
	name = "cargo cap"
	initial_name = "yellow cap"
	desc = "A peaked cap in a tasteless yellow color."
	icon_state = "cap_yl"
	item_state_slots = list(
		slot_l_hand_str = "helmet", //probably a placeholder
		slot_r_hand_str = "helmet",
		)
	siemens_coefficient = 0.9
	body_parts_covered = 0
	var/flipped = 0

/obj/item/clothing/head/soft/dropped()
	src.icon_state = initial(icon_state)
	src.flipped=0
	..()

/obj/item/clothing/head/soft/attack_self(mob/user)
	src.flipped = !src.flipped
	if(src.flipped)
		icon_state = "[icon_state]_flipped"
		to_chat(user, "You flip the hat backwards.")
	else
		src.icon_state = initial(icon_state)
		to_chat(user, "You flip the hat back in normal position.")
	update_wear_icon()	//so our mob-overlays update


/obj/item/clothing/head/soft/blue
	name = "blue cap"
	initial_name = "blue cap"
	desc = "A baseball cap in a tasteless blue color."
	icon_state = "cap_bl"

/obj/item/clothing/head/soft/orange
	name = "orange cap"
	initial_name = "orange cap"
	desc = "A baseball cap in a bleak orange color."
	icon_state = "cap_or"

/obj/item/clothing/head/soft/green
	name = "green cap"
	initial_name = "green cap"
	desc = "A baseball cap in a tasteless green color."
	icon_state = "cap_gr"

/obj/item/clothing/head/soft/brown
	name = "brown cap"
	initial_name = "brown cap"
	desc = "A baseball cap in a tasteless brown color."
	icon_state = "cap_br"

/obj/item/clothing/head/soft/grey
	name = "grey cap"
	initial_name = "grey cap"
	desc = "A baseball cap in a tasteful grey color. Reeks of welder fuel."
	icon_state = "cap_sl"

/obj/item/clothing/head/soft/mime
	name = "white cap"
	initial_name = "cap"
	desc = "A baseball cap in a tasteless white color."
	icon_state = "cap_wh"

/obj/item/clothing/head/soft/red
	name = "red cap"
	initial_name = "red cap"
	desc = "A baseball hat in a tasteful crimson color."
	icon_state = "cap_rd"

/obj/item/clothing/head/soft/black
	name = "black cap"
	initial_name = "black cap"
	desc = "A simple baseball cap in a tasteful black color."
	icon_state = "cap_bk"

/obj/item/clothing/head/soft/yellow
	name = "yellow cap"
	initial_name = "yellow cap"
	desc = "A baseball cap in a tasteless yellow color."
	icon_state = "cap_yl"

/obj/item/clothing/head/soft/purple
	name = "purple cap"
	initial_name = "violet cap"
	desc = "A peaked cap in a tasteless purple color."
	icon_state = "cap_vi"

/obj/item/clothing/head/soft/rose
	name = "pink cap"
	initial_name = "rose cap"
	desc = "A peaked cap in a tasteless rose color."
	icon_state = "cap_rs"

/obj/item/clothing/head/soft/aqua
	name = "teal cap"
	initial_name = "aqua cap"
	desc = "A peaked cap in a tasteless teal color."
	icon_state = "cap_aq"

/obj/item/clothing/head/soft/rainbow
	name = "rainbow cap"
	initial_name = "rainbow cap"
	desc = "A flimsy cap in a bright rainbow of colors."
	icon_state = "cap_rainbow"

/obj/item/clothing/head/soft/sec
	name = "security cap"
	initial_name = "security cap"
	desc = "A ballcap with the badge of station security."
	icon_state = "cap_sec"

/obj/item/clothing/head/soft/sar
	name = "SAR cap"
	initial_name = "SAR cap"
	desc = "A ballcap with the badge of a Search And Rescue Specialist."
	icon_state = "cap_sar"

/obj/item/clothing/head/soft/synd
	name = "Syndicate cap"
	initial name = "ancient syndicate cap"
	desc = "A branded ballcap of the Starboard Freight Syndicate."
	icon_state = "cap_syndicate"

/obj/item/clothing/head/soft/sec/corp
	name = "corporate security cap"
	initial_name = "corporate security cap"
	desc = "An old cap for station security forces. Popular fashion statement recently."
	icon_state = "cap_seccorp"

/obj/item/clothing/head/soft/green2soft
	name = "green military cap"
	initial_name = "green military cap"
	desc = "A field cap in tasteful green color."
	icon_state = "cap_od"

/obj/item/clothing/head/soft/tan2soft
	name = "tan military cap"
	initial_name = "tan military cap"
	desc = "A field cap in tasteful tan color."
	icon_state = "cap_tan"

/obj/item/clothing/head/soft/sec2soft
	name = "NT security cap"
	initial_name = "NT security cap"
	desc = "An old, washed out ballcap with the logo of NanoTrassen internal security on its front."
	icon_state = "cap_secred"

/obj/item/clothing/head/soft/sarge2soft //unused
	name = "IH sergeant cap"
	initial_name = "IH sergeant cap"
	desc = "A field cap for officers."
	icon_state = "sargesoft"

// M O E B I U S //

/obj/item/clothing/head/soft/medical //unused
	name = "Moebius medical cap"
	desc = "Cap worn by moebius medical personnel, usually outside spacecraft."
	icon_state = "medcap"
	item_state = "medcap"

///obj/item/clothing/head/soft/science
	//name = "moebius research cap"
	//desc = "Cap worn by moebius research personnel."
	//icon_state = "scicap"
	//item_state = "scicap"

// P A T R O L //

/obj/item/clothing/head/patrol
	name = "patrol cap"
	initial_name = "patrol cap"
	desc = "A generic military style patrol cap in olive green."
	icon_state = "patrol"
	item_state_slots = list(
		slot_l_hand_str = "helmet", //probably a placeholder
		slot_r_hand_str = "helmet",
		)
	siemens_coefficient = 0.9
	body_parts_covered = 0

/obj/item/clothing/head/patrol/brown
	name = "tan patrol cap"
	initial_name = "tan cap"
	desc = "A patrol cap in tasteful tan."
	icon_state = "patrol_br"

/obj/item/clothing/head/patrol/black
	name = "black patrol cap"
	initial_name = "green cap"
	desc = "A patrol cap in tasteful black."
	icon_state = "patrol_bk"

/obj/item/clothing/head/patrol/sec
	name = "security patrol cap"
	initial_name = "corporate security cap"
	desc = "A patrol cap with the badge of PCRC security."
	icon_state = "patrol_sec"

/obj/item/clothing/head/patrol/sec/red
	name = "red patrol cap"
	initial_name = "red patrol cap"
	desc = "A washed out patrol cap bearing logo of NanoTrassen internal security."
	icon_state = "patrol_secred"

/obj/item/clothing/head/patrol/sec/corp
	name = "corporate security patrol cap"
	initial_name = "corporate security patrol cap"
	desc = "An old patrol cap for station security forces. Popular fashion statement recently."
	icon_state = "patrol_seccorp"

/obj/item/clothing/head/patrol/nt
	name = "NT patrol cap"
	initial_name = "NT patrol cap"
	desc = "A patrol cap with a large NanoTrassen brand logo. Merch."
	icon_state = "patrol_nt"

/obj/item/clothing/head/patrol/centcom
	name = "CENTCOM patrol cap"
	initial_name = "CENTCOM patrol cap"
	desc = "A patrol cap with a large CENTCOM badge."
	icon_state = "patrol_centcom"

/obj/item/clothing/head/patrol/sar
	name = "SAR patrol cap"
	initial_name = "SAR patrol cap"
	desc = "A patrol cap with a Search And Rescue tape across its front. Very official."
	icon_state = "patrol_sar"

/obj/item/clothing/head/patrol/pcrc
	name = "PCRC patrol cap"
	initial_name = "PCRC cap"
	desc = "A patrol cap with the reflective tape and lettering of the Proxima Centauri Risk Control Group."
	icon_state = "patrol_pcrc"

// T R U C K E R //

/obj/item/clothing/head/trucker
	name = "blue trucker hat"
	initial_name = "blue trucker hat"
	desc = "An oversized mesh-back hat with plenty of space for branding."
	icon_state = "trucker_bl"
	item_state_slots = list(
		slot_l_hand_str = "helmet", //probably a placeholder
		slot_r_hand_str = "helmet",
		)
	siemens_coefficient = 0.9
	body_parts_covered = 0

/obj/item/clothing/head/trucker/orange
	name = "orange trucker hat"
	initial_name = "orange trucker hat"
	icon_state = "trucker_or"

/obj/item/clothing/head/trucker/green
	name = "green trucker hat"
	initial_name = "green trucker hat"
	icon_state = "trucker_gr"

/obj/item/clothing/head/trucker/brown
	name = "brown trucker hat"
	initial_name = "brown trucker hat"
	icon_state = "trucker_br"

/obj/item/clothing/head/trucker/slate
	name = "slate trucker hat"
	initial_name = "slate trucker hat"
	icon_state = "trucker_sl"

/obj/item/clothing/head/trucker/white
	name = "white trucker hat"
	initial_name = " trucker hat"
	icon_state = "trucker_wh"

/obj/item/clothing/head/trucker/red
	name = "red trucker hat"
	initial_name = "red trucker hat"
	icon_state = "trucker_rd"

/obj/item/clothing/head/trucker/black
	name = "black trucker hat"
	initial_name = "black trucker hat"
	icon_state = "trucker_bk"

/obj/item/clothing/head/trucker/yellow
	name = "yellow trucker hat"
	initial_name = "yellow trucker hat"
	icon_state = "trucker_yl"

/obj/item/clothing/head/trucker/violet
	name = "violet trucker hat"
	initial_name = "violet trucker hat"
	icon_state = "trucker_vi"

/obj/item/clothing/head/trucker/rose
	name = "rose trucker hat"
	initial_name = "rose trucker hat"
	icon_state = "trucker_rs"

/obj/item/clothing/head/trucker/aqua
	name = "aqual trucker hat"
	initial_name = "aqua trucker hat"
	icon_state = "trucker_aq"

/obj/item/clothing/head/trucker/serious
	name = "normal hat"
	desc = "A normal hat for normal people."
	initial_name = "hat"
	icon_state = "cap"