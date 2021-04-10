// Bastion of Endeavor Addition -- handles the editing of grammatical cases for character names.

/datum/category_item/player_setup_item/general/cases
	name = "Падежи"
	sort_order = 7

/datum/category_item/player_setup_item/general/cases/load_character(savefile/S)
	S["cases_ncase"]	    >> pref.cases["ncase"]
	S["cases_gcase"]		>> pref.cases["gcase"]
	S["cases_dcase"]		>> pref.cases["dcase"]
	S["cases_acase"]		>> pref.cases["acase"]
	S["cases_icase"]		>> pref.cases["icase"]
	S["cases_pcase"]		>> pref.cases["pcase"]

/datum/category_item/player_setup_item/general/cases/save_character(var/savefile/S)
	S["cases_ncase"]		<< pref.cases["ncase"]
	S["cases_gcase"]		<< pref.cases["gcase"]
	S["cases_dcase"]		<< pref.cases["dcase"]
	S["cases_acase"]		<< pref.cases["acase"]
	S["cases_icase"]		<< pref.cases["icase"]
	S["cases_pcase"]		<< pref.cases["pcase"]

/datum/category_item/player_setup_item/general/cases/sanitize_character()
	if(!pref.cases["ncase"]) pref.cases["ncase"] = pref.real_name
	if(!pref.cases["gcase"]) pref.cases["gcase"] = pref.real_name
	if(!pref.cases["dcase"]) pref.cases["dcase"] = pref.real_name
	if(!pref.cases["acase"]) pref.cases["acase"] = pref.real_name
	if(!pref.cases["icase"]) pref.cases["icase"] = pref.real_name
	if(!pref.cases["pcase"]) pref.cases["pcase"] = pref.real_name

/datum/category_item/player_setup_item/general/cases/copy_to_mob(var/mob/living/carbon/human/character)
	character.ncase			= pref.cases["ncase"]
	character.gcase			= pref.cases["gcase"]
	character.dcase			= pref.cases["dcase"]
	character.acase			= pref.cases["acase"]
	character.icase			= pref.cases["icase"]
	character.pcase			= pref.cases["pcase"]

/datum/category_item/player_setup_item/general/cases/content(var/mob/user)
	. += "<a href='?src=\ref[src];cases=open'>Установить склонение имени</a><br/>"

/datum/category_item/player_setup_item/general/cases/OnTopic(var/href,var/list/href_list, var/mob/user)
	switch(href_list["cases"])
		if("open")
		if("general")
			var/msg = sanitize(input(usr,"Укажите склонение имени Вашего персонажа по падежам.","Склонение Имени",html_decode(pref.cases[href_list["cases"]])) as text, extra = 0)
			if(CanUseTopic(user))
				pref.cases[href_list["cases"]] = msg
		else
			var/msg = sanitize(input(usr,"Установите склонение имени в этом падеже.","Склонение Имени",html_decode(pref.cases[href_list["cases"]])) as text, extra = 0)
			if(CanUseTopic(user))
				pref.cases[href_list["cases"]] = msg
	SetCases(user)
	return TOPIC_HANDLED

/datum/category_item/player_setup_item/general/cases/proc/SetCases(mob/user)
	var/HTML = "<body>"
	HTML += "<tt><meta charset=\"utf-8\"><center>"
	HTML += "<b>Установите склонение имени персонажа</b> <hr />"
	HTML += "<br></center>"
	HTML += "<a href='?src=\ref[src];cases=ncase'>Именительный:</a> "
	HTML += TextPreview(pref.cases["ncase"])
	HTML += "<br>"
	HTML += "<a href='?src=\ref[src];cases=gcase'>Родительный:</a> "
	HTML += TextPreview(pref.cases["gcase"])
	HTML += "<br>"
	HTML += "<a href='?src=\ref[src];cases=dcase'>Дательный:</a> "
	HTML += TextPreview(pref.cases["dcase"])
	HTML += "<br>"
	HTML += "<a href='?src=\ref[src];cases=acase'>Винительный:</a> "
	HTML += TextPreview(pref.cases["acase"])
	HTML += "<br>"
	HTML += "<a href='?src=\ref[src];cases=icase'>Творительный:</a> "
	HTML += TextPreview(pref.cases["icase"])
	HTML += "<br>"
	HTML += "<a href='?src=\ref[src];cases=pcase'>Предложный:</a> "
	HTML += TextPreview(pref.cases["pcase"])
	HTML += "<br>"
	HTML += "<hr />"
	HTML += "<tt>"
	user << browse(HTML, "window=cases;size=430x300")
	return