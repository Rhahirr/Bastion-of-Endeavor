/obj/screen/proc/Click_vr(location, control, params)
	if(!usr)	return 1
	switch(name)

		//Shadekin
		/* Bastion of Endeavor Translation
		if("darkness")
			var/turf/T = get_turf(usr)
			var/darkness = round(1 - T.get_lumcount(),0.1)
			to_chat(usr,"<span class='notice'><b>Darkness:</b> [darkness]</span>")
		if("energy")
			var/mob/living/simple_mob/shadekin/SK = usr
			if(istype(SK))
				to_chat(usr,"<span class='notice'><b>Energy:</b> [SK.energy] ([SK.dark_gains])</span>")
		if("shadekin status")
			var/turf/T = get_turf(usr)
			if(T)
				var/darkness = round(1 - T.get_lumcount(),0.1)
				to_chat(usr,"<span class='notice'><b>Darkness:</b> [darkness]</span>")
			var/mob/living/carbon/human/H = usr
			if(istype(H) && istype(H.species, /datum/species/shadekin))
				to_chat(usr,"<span class='notice'><b>Energy:</b> [H.shadekin_get_energy(H)]</span>")
		if("danger level")
			var/mob/living/carbon/human/H = usr
			if(istype(H) && istype(H.species, /datum/species/xenochimera))
				if(H.feral > 50)
					to_chat(usr, "<span class='warning'>You are currently <b>completely feral.</b></span>")
				else if(H.feral > 10)
					to_chat(usr, "<span class='warning'>You are currently <b>crazed and confused.</b></span>")
				else if(H.feral > 0)
					to_chat(usr, "<span class='warning'>You are currently <b>acting on instinct.</b></span>")
				else
					to_chat(usr, "<span class='notice'>You are currently <b>calm and collected.</b></span>")
				if(H.feral > 0)
					var/feral_passing = TRUE
					if(H.traumatic_shock > min(60, H.nutrition/10))
						to_chat(usr, "<span class='warning'>Your pain prevents you from regaining focus.</span>")
						feral_passing = FALSE
					if(H.feral + H.nutrition < 150)
						to_chat(usr, "<span class='warning'>Your hunger prevents you from regaining focus.</span>")
						feral_passing = FALSE
					if(H.jitteriness >= 100)
						to_chat(usr, "<span class='warning'>Your jitterness prevents you from regaining focus.</span>")
						feral_passing = FALSE
					if(feral_passing)
						var/turf/T = get_turf(H)
						if(T.get_lumcount() <= 0.1)
							to_chat(usr, "<span class='notice'>You are slowly calming down in darkness' safety...</span>")
						else
							to_chat(usr, "<span class='notice'>You are slowly calming down... But safety of darkness is much preferred.</span>")
				else
					if(H.nutrition < 150)
						to_chat(usr, "<span class='warning'>Your hunger is slowly making you unstable.</span>")
		*/
		if("Тьма")
			var/turf/T = get_turf(usr)
			var/darkness = round(1 - T.get_lumcount(),0.1)
			to_chat(usr,"<span class='notice'><b>Тьма:</b> [darkness]</span>")
		if("Энергия")
			var/mob/living/simple_mob/shadekin/SK = usr
			if(istype(SK))
				to_chat(usr,"<span class='notice'><b>Энергия:</b> [SK.energy] ([SK.dark_gains])</span>")
		if("Состояние")
			var/turf/T = get_turf(usr)
			if(T)
				var/darkness = round(1 - T.get_lumcount(),0.1)
				to_chat(usr,"<span class='notice'><b>Тьма:</b> [darkness]</span>")
			var/mob/living/carbon/human/H = usr
			if(istype(H) && istype(H.species, /datum/species/shadekin))
				to_chat(usr,"<span class='notice'><b>Энергия:</b> [H.shadekin_get_energy(H)]</span>")
		if("Уровень угрозы")
			var/mob/living/carbon/human/H = usr
			if(istype(H) && istype(H.species, /datum/species/xenochimera))
				if(H.feral > 50)
					to_chat(usr, "<span class='warning'>Вы <b>полностью одичали</b>.</span>")
				else if(H.feral > 10)
					to_chat(usr, "<span class='warning'>Вы постепенно <b>начинаете сходить с ума</b>.</span>")
				else if(H.feral > 0)
					to_chat(usr, "<span class='warning'>Вы сейчас <b>полагаетесь на инстинкты.</b></span>")
				else
					to_chat(usr, "<span class='notice'>Вы сейчас <b>полностью спокойны.</b></span>")
				if(H.feral > 0)
					var/feral_passing = TRUE
					if(H.traumatic_shock > min(60, H.nutrition/10))
						to_chat(usr, "<span class='warning'>Боль мешает Вам сосредоточиться.</span>")
						feral_passing = FALSE
					if(H.feral + H.nutrition < 150)
						to_chat(usr, "<span class='warning'>Голод не позволяет Вам сосредоточиться.</span>")
						feral_passing = FALSE
					if(H.jitteriness >= 100)
						to_chat(usr, "<span class='warning'>Дрожь не позволяет Вам сосредоточиться.</span>")
						feral_passing = FALSE
					if(feral_passing)
						var/turf/T = get_turf(H)
						if(T.get_lumcount() <= 0.1)
							to_chat(usr, "<span class='notice'>Вы постепенно успокаиваетесь, находясь в родных объятиях тьмы...</span>")
						else
							to_chat(usr, "<span class='notice'>Вы постепенно успокаиваетесь... но Вам хочется обратно во тьму.</span>")
				else
					if(H.nutrition < 150)
						to_chat(usr, "<span class='warning'>Голод постепенно доводит Вас до неуравновешенности.</span>")
		// End of Bastion of Endeavor Translation

		else
			return 0

	return 1