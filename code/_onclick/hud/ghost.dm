/obj/screen/ghost
	icon = 'icons/mob/screen_ghost.dmi'

/obj/screen/ghost/MouseEntered(location,control,params)
	flick(icon_state + "_anim", src)
	openToolTip(usr, src, params, title = name, content = desc)

/obj/screen/ghost/MouseExited()
	closeToolTip(usr)

/obj/screen/ghost/Click()
	closeToolTip(usr)

/obj/screen/ghost/returntomenu
/* Bastion of Endeavor Translation
	name = "Return to menu"
	desc = "Return to the title screen menu."
	icon_state = "returntomenu"

/obj/screen/ghost/returntomenu/Click()
	..()
	var/mob/observer/dead/G = usr
	G.abandon_mob()

/obj/screen/ghost/jumptomob
	name = "Jump to mob"
	desc = "Pick a mob from a list to jump to."
	icon_state = "jumptomob"

/obj/screen/ghost/jumptomob/Click()
	..()
	var/mob/observer/dead/G = usr
	G.jumptomob()

/obj/screen/ghost/orbit
	name = "Orbit"
	desc = "Pick a mob to follow and orbit."
	icon_state = "orbit"

/obj/screen/ghost/orbit/Click()
	..()
	var/mob/observer/dead/G = usr
	G.follow()

/obj/screen/ghost/reenter_corpse
	name = "Reenter corpse"
	desc = "Only applicable if you HAVE a corpse..."
	icon_state = "reenter_corpse"

/obj/screen/ghost/reenter_corpse/Click()
	..()
	var/mob/observer/dead/G = usr
	G.reenter_corpse()

/obj/screen/ghost/teleport
	name = "Teleport"
	desc = "Pick an area to teleport to."
	icon_state = "teleport"

/obj/screen/ghost/teleport/Click()
	..()
	var/mob/observer/dead/G = usr
	G.dead_tele()

/obj/screen/ghost/pai
	name = "pAI Alert"
	desc = "Ping all the unoccupied pAI devices in the world."
	icon_state = "pai"

/obj/screen/ghost/pai/Click()
	..()
	var/mob/observer/dead/G = usr
	G.paialert()

/obj/screen/ghost/up
	name = "Move Upwards"
	desc = "Move up a z-level."
	icon_state = "up"

/obj/screen/ghost/up/Click()
	..()
	var/mob/observer/dead/G = usr
	G.zMove(UP)

/obj/screen/ghost/down
	name = "Move Downwards"
	desc = "Move down a z-level."
	icon_state = "down"
*/ 
	name = "Вернуться в меню"
	desc = "Вернуться обратно в меню."
	icon_state = "returntomenu"

/obj/screen/ghost/returntomenu/Click()
	..()
	var/mob/observer/dead/G = usr
	G.abandon_mob()

/obj/screen/ghost/jumptomob
	name = "Прыгнуть к мобу"
	desc = "Выбрать моба и переместиться к нему."
	icon_state = "jumptomob"

/obj/screen/ghost/jumptomob/Click()
	..()
	var/mob/observer/dead/G = usr
	G.jumptomob()

/obj/screen/ghost/orbit
	name = "Преследовать"
	desc = "Выбрать моба и следовать за ним."
	icon_state = "orbit"

/obj/screen/ghost/orbit/Click()
	..()
	var/mob/observer/dead/G = usr
	G.follow()

/obj/screen/ghost/reenter_corpse
	name = "Войти в тело"
	desc = "При условии, что тело есть..."
	icon_state = "reenter_corpse"

/obj/screen/ghost/reenter_corpse/Click()
	..()
	var/mob/observer/dead/G = usr
	G.reenter_corpse()

/obj/screen/ghost/teleport
	name = "Телепортироваться"
	desc = "Выбрать место и телепортироваться в него."
	icon_state = "teleport"

/obj/screen/ghost/teleport/Click()
	..()
	var/mob/observer/dead/G = usr
	G.dead_tele()

/obj/screen/ghost/pai
	name = "Подсветить ПИИ"
	desc = "Подсветить все свободные ПИИ."
	icon_state = "pai"

/obj/screen/ghost/pai/Click()
	..()
	var/mob/observer/dead/G = usr
	G.paialert()

/obj/screen/ghost/up
	name = "Переместиться вверх"
	desc = "Подняться на один Z-уровень."
	icon_state = "up"

/obj/screen/ghost/up/Click()
	..()
	var/mob/observer/dead/G = usr
	G.zMove(UP)

/obj/screen/ghost/down
	name = "Переместиться вниз"
	desc = "Опуститься на один Z-уровень."
	icon_state = "down"
// End of Bastion of Endeavor Translation

/obj/screen/ghost/down/Click()
	..()
	var/mob/observer/dead/G = usr
	G.zMove(DOWN)

/mob/observer/dead/create_mob_hud(datum/hud/HUD, apply_to_client = TRUE)
	..()

	var/list/adding = list()
	HUD.adding = adding
	
	var/obj/screen/using
	using = new /obj/screen/ghost/returntomenu()
	using.screen_loc = ui_ghost_returntomenu
	using.hud = src
	adding += using

	using = new /obj/screen/ghost/jumptomob()
	using.screen_loc = ui_ghost_jumptomob
	using.hud = src
	adding += using

	using = new /obj/screen/ghost/orbit()
	using.screen_loc = ui_ghost_orbit
	using.hud = src
	adding += using

	using = new /obj/screen/ghost/reenter_corpse()
	using.screen_loc = ui_ghost_reenter_corpse
	using.hud = src
	adding += using

	using = new /obj/screen/ghost/teleport()
	using.screen_loc = ui_ghost_teleport
	using.hud = src
	adding += using

	using = new /obj/screen/ghost/pai()
	using.screen_loc = ui_ghost_pai
	using.hud = src
	adding += using

	using = new /obj/screen/ghost/up()
	using.screen_loc = ui_ghost_updown
	using.hud = src
	adding += using

	using = new /obj/screen/ghost/down()
	using.screen_loc = ui_ghost_updown
	using.hud = src
	adding += using

	/*
	using = new /obj/screen/language_menu
	using.icon = ui_style
	using.hud = src
	adding += using
	*/

	if(client && apply_to_client)
		client.screen = list()
		client.screen += HUD.adding
		client.screen += client.void

/* I wish we had this. Not yet, though.
/datum/hud/ghost/show_hud(version = 0, mob/viewmob)
	// don't show this HUD if observing; show the HUD of the observee
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		plane_masters_update()
		return FALSE

	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client.prefs.ghost_hud)
		screenmob.client.screen -= static_inventory
	else
		screenmob.client.screen += static_inventory

//We should only see observed mob alerts.
/datum/hud/ghost/reorganize_alerts(mob/viewmob)
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		return
	. = ..()
*/