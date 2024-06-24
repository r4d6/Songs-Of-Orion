

///////////////////
// LORE CONSOLES //
///////////////////

/obj/structure/salvageable/lore
	name = "old personal terminal"
	icon_state = "personal"
	spawn_blacklisted = TRUE
	var/datalog_name = "Old Data Log"
	var/message = {"
		<HTML><HEAD><TITLE>Old Data Log</TITLE></HEAD>
		<BODY bgcolor='#000000'> <FONT COLOR="#32CD32"><center><large><b>ERROR DATA LOSS</b></large></br>
		</br>
		Issued under the ERROR</br>
		Please contact Support</br>
		</br>
		<b>ERROR</b></center></br>
		</BODY></HTML>
		"}


/obj/structure/salvageable/lore/tester
	datalog_name = "Mew Mew Kitten Delux"
	message = {"
		<HTML><HEAD><TITLE>HELLO, Mew Mew Kitten Enjoyers</TITLE></HEAD>
		<BODY bgcolor='#000000'> <FONT COLOR="#32CD32"><center><large><b>THE LONG AWAITED MEW MEW KITTEN DELUX IS FINALLY HERE BUY IT AT</b></large></br>
		</br>
		ERROR HYPERLINK BLOCED</br>
		Please contact Support</br>
		</br>
		<b>ENJOY YOUR GAME!</b></center></br>
		</BODY></HTML>
		"}

/obj/structure/salvageable/lore/Initialize()
	. = ..()
	icon_state = "personal[rand(0,12)]"

/obj/structure/salvageable/lore/interact(mob/user)
	..()
	show_browser(user, message, "window=[datalog_name]")

/obj/structure/salvageable/lore/attack_hand(mob/user)
	..()
	show_browser(user, message, "window=[datalog_name]")