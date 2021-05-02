/mob/living/silicon/robot/update_hud()
	if(ui_style_vr)
		/* Bastion of Endeavor Edit: Got our own russian UI for this.
		hands.icon = 'icons/mob/screen1_robot_vr.dmi'
		*/
		hands.icon = 'icons/russian/screen1_robot_vr_ru.dmi'
	if(modtype)
		// Bastion of Endeavor TODO: Take a look at the following line. Modtypes are to be translated at some point, so this will break.
		hands.icon_state = lowertext(modtype)
	..()