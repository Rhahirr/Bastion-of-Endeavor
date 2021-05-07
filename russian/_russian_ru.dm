/atom
	// Cases are needed for proper russian grammar in the game. Added as a list that can be freely expanded.
	var/list/ru_cases = new /list()

/area
	var/ru_p_override = FALSE // This allows us to have different prepositions for areas. ON the deck, IN the room, etc.
	var/ru_area_fancy_name // This is a WIP that will let us have shorter area names that can be used for APCs and such.

/datum/reagent
	var/list/ru_cases = new /list() // Certain datums need cases too.

/datum/reagent/New()
	..()
	ru_cases["glass"] = new /list()
	ru_cases["glass"]["rugender"] = "male"
	ru_cases["glass"]["ncase"] = "стакан с чем-то"
	ru_cases["glass"]["gcase"] = "стакана с чем-то"
	ru_cases["glass"]["dcase"] = "стакану с чем-то"
	ru_cases["glass"]["acase"] = "стакан с чем-то"
	ru_cases["glass"]["icase"] = "стаканом с чем-то"
	ru_cases["glass"]["pcase"] = "стакане с чем-то"

/datum/material
	var/case_override // Case override handles the order of words in material stacks. By default, Material + Sheet. If set to TRUE, Sheet of Material.
	var/name_override // Required for other objects made with materials. Glass Table (by default), Table of Reinforced Glass (custom).
	var/list/ru_cases = new /list() // Same as earlier cases.

/datum/material/New()
	..()
	ru_cases["sheet_singular"] = new /list()
	ru_cases["sheet_singular"]["rugender"] = "male"
	ru_cases["sheet_singular"]["ncase"] = "лист"
	ru_cases["sheet_singular"]["gcase"] = "листа"
	ru_cases["sheet_singular"]["dcase"] = "листу"
	ru_cases["sheet_singular"]["acase"] = "лист"
	ru_cases["sheet_singular"]["icase"] = "листом"
	ru_cases["sheet_singular"]["pcase"] = "листе"
	ru_cases["sheet_plural"] = new /list()
	ru_cases["sheet_plural"]["rugender"] = "plural"
	ru_cases["sheet_plural"]["ncase"] = "листы"
	ru_cases["sheet_plural"]["gcase"] = "листов"
	ru_cases["sheet_plural"]["dcase"] = "листам"
	ru_cases["sheet_plural"]["acase"] = "листы"
	ru_cases["sheet_plural"]["icase"] = "листами"
	ru_cases["sheet_plural"]["pcase"] = "листах"

/obj/item/weapon/reagent_containers/food/snacks
	var/ru_foodtype // Handles the appropriate verb for various types of meals.

/obj/effect/decal/cleanable/blood/New()
	..()
	ru_cases["dry"] = new /list()
	ru_cases["dry"]["rugender"] = "female"
	ru_cases["dry"]["ncase"] = "засохшая кровь"
	ru_cases["dry"]["gcase"] = "засохшей крови"
	ru_cases["dry"]["dcase"] = "засохшей крови"
	ru_cases["dry"]["acase"] = "засохшую кровь"
	ru_cases["dry"]["icase"] = "засохшей кровью"
	ru_cases["dry"]["pcase"] = "засохшей крови"

/decl/flooring
	var/list/ru_cases = new /list()

// Need to remember to swap the decl for datum if decls are axed upstream.
/decl/xgm_gas
	var/list/ru_cases = new /list()

datum/preferences
	var/list/cases = list()

/mob/self_user // This is a placeholder that comes in handy in ru_v's that have the user as the target.

/mob/self_user/New() 
	..()
	ru_cases["gcase"] = "себя"
	ru_cases["dcase"] = "себе"
	ru_cases["acase"] = "себя"
	ru_cases["icase"] = "собой"
	ru_cases["pcase"] = "себе"

// This proc handles the appropriate numeral word depending on the, well, number.
/proc/ru_count(var/input, single_text = "единица", few_text = "единицы", many_text = "единиц", override = 0)
	var/output
	if(istype(input, /list))
		var/list/input_list = input
		output = input_list.len
	else output = input
	var/a = round(output) % 100
	var/b = round(output) % 10
	if (a > 10 && a < 20) return "[override? "" : "[output] "][many_text]"
	if (b > 1 && b < 5) return "[override? "" : "[output] "][few_text]"
	if (b == 1) return "[override? "" : "[output] "][single_text]"
	return "[override? "" : "[output] "][many_text]"

// This is one of the core procs. It handles the grammar cases of words and uses them in messages. Secondary is for "subtype" cases.
/proc/ru_case(atom/input, case = "case", secondary = null)
	if(!(istype(input, /atom)) || !(istype(input, /datum)))
		crash_with("Проку ru_case передан не атом/датум! Ввод: [input]")
		return input
	if(input.ru_cases[case])
		if(secondary) return input.ru_cases[case][secondary]
		else return input.ru_cases[case]
	else return input.name

// A more faithful version of capitalize proc.
/proc/ru_cap(atom/input, var/case = "ncase")
	return "[capitalize(ru_case(input, case))]"

// Backs up cases before changing them.
/atom/proc/ru_storecase(atom/input)
	ru_cases["initial"] = new /list()
	for(var/case in input.ru_cases)
		input.ru_cases["initial"][case] = input.ru_cases[case]
	return

// Adds something to the end of all cases of an atom, as well as changes its rugender element.
/atom/proc/ru_appendcase(atom/input, content)
	ru_storecase(input)
	for(var/case in input.ru_cases)
		if(case == "rugender") input.ru_cases[case] = input.ru_cases["initial"][case]
		input.ru_cases[case] += content
	return

// Reverts the grammar cases of an atom to their backed up state.
/atom/proc/ru_restorecase(atom/input)
	for(var/case in input.ru_cases)
		input.ru_cases[case] = input.ru_cases["initial"][case]
	return

// Dispenses an appropriately formatted string depending on the material and what it's used on.
/proc/ru_matadj(datum/material, case = "case", gender = "gender", input = "", pre = " из ")
	var/datum/material/mat = material
	var/adjective = ""
	adjective = mat.ru_cases["adj_[gender]"][case]
	if(mat.name_override) return "[input][pre]" + mat.ru_cases["display_name"]["gcase"]
	else return "[adjective][(input)? " [input]" : ""]"
	return

// Has anyone ever stopped to question why the verb is always "buckle" even when you interact with a bed?
// This proc may look awful, but it adds an immense amount of clarity in russian, as it largely depends on the context and the target.
/proc/ru_buckleverb(obj/seat, mob/user, tense = "present", mob/target)
	var/who
	if(target)
		who = "[ru_case(target, "acase")]"
	else
		who = "Вас"
	if(istype(seat, /obj/structure/bed/chair/shuttle) || istype(seat, /obj/structure/bed/chair/bay/shuttle))
		switch(tense)
			//buckle
			if("present") return "[ru_v(user, "пристёгива;ет;ет;ет;ют;;")] [who] к [ru_case(seat, "dcase")]"
			if("self") return "[ru_v(user, "пристегнул;ся;ась;ось;ись;;")] к [ru_case(seat, "dcase")]"
			if("past") return "[ru_v(user, "пристегнул;;а;о;и;;")] [who] к [ru_case(seat, "dcase")]"
			if("participle") return "[ru_v(user, "пристёгнут;;а;о;ы;;")] к [ru_case(seat, "dcase")]"
			if("action") return "пристёгиваете [who] к [ru_case(seat, "dcase")]"
			if("indefinite") return "пристегнуть [who] к [ru_case(seat, "dcase")]"
			if("you") return "пристегнулись к [ru_case(seat, "dcase")]"
			//unbuckle
			if("upresent") return "[ru_v(user, "отстёгива;ет;ет;ет;ют;;")] [who] от [ru_case(seat, "gcase")]"
			if("uself") return "[ru_v(user, "отстегнул;ся;ась;ось;ись;;")] от [ru_case(seat, "gcase")]"
			if("upast") return "[ru_v(user, "отстегнул;;а;о;и;;")] [who] от [ru_case(seat, "gcase")]"
			if("uyou") return "отстегнулись от [ru_case(seat, "gcase")]"
	else if(istype(seat, /obj/structure/bed/chair/comfy))
		switch(tense)
			//buckle
			if("present") return "[ru_v(user, "усажива;ет;ет;ет;ют;;")] [who] [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			if("self") return "[ru_v(user, "сад;ит;ит;ит;ят;ся;")] [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			if("past") return "[ru_v(user, "посадил;;а;о;и;;")] [who] [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			if("participle") return "[ru_v(user, "сид;ит;ит;ит;ят;;")] [ru_p(seat, "в")] [ru_case(seat, "pcase")]"
			if("action") return "усаживаете [who] [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			if("indefinite") return "усадить [who] [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			if("you") return "сели [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			//unbuckle
			if("upresent") return "[ru_v(user, "поднима;ет;ет;ет;ют;;")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uself") return "[ru_v(user, "вста;ёт;ёт;ёт;ют;;")] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("upast") return "[ru_v(user, "поднял;;а;о;и;;")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uyou") return "встали [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
	else if(istype(seat, /obj/structure/bed/chair))
		switch(tense)
			//buckle
			if("present") return "[ru_v(user, "усажива;ет;ет;ет;ют;;")] [who] на [ru_case(seat, "acase")]"
			if("self") return "[ru_v(user, "сад;ит;ит;ит;ят;ся;")] на [ru_case(seat, "acase")]"
			if("past") return "[ru_v(user, "усадил;;а;о;и;;")] [who] на [ru_case(seat, "acase")]"
			if("participle") return "[ru_v(user, "сид;ит;ит;ит;ят;;")] на [ru_case(seat, "pcase")]"
			if("action") return "усаживаете [who] на [ru_case(seat, "acase")]"
			if("indefinite") return "усадить [who] на [ru_case(seat, "acase")]"
			if("you") return "сели на [ru_case(seat, "acase")]"
			//unbuckle
			if("upresent") return "[ru_v(user, "поднима;ет;ет;ет;ют;;")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uself") return "[ru_v(user, "вста;ёт;ёт;ёт;ют;;")] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("upast") return "[ru_v(user, "поднял;;а;о;и;;")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uyou") return "встали [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
	else if(istype(seat, /obj/structure/bed) || istype(seat, /obj/structure/dogbed))
		switch(tense)
			//buckle
			if("present") return "[ru_v(user, "укладыва;ет;ет;ет;ют;;")] [who] на [ru_case(seat, "acase")]"
			if("self") return "[ru_v(user, "лож;ит;ит;ит;ат;ся;")] на [ru_case(seat, "acase")]"
			if("past") return "[ru_v(user, "положил;;а;о;и;;")] [who] на [ru_case(seat, "acase")]"
			if("participle") return "[ru_v(user, "леж;ит;ит;ит;ат;;")] на [ru_case(seat, "pcase")]"
			if("action") return "укладываете [who] на [ru_case(seat, "acase")]"
			if("indefinite") return "положить [who] на [ru_case(seat, "acase")]"
			if("you") return "легли на [ru_case(seat, "acase")]"
			//unbuckle
			if("upresent") return "[ru_v(user, "поднима;ет;ет;ет;ют;;")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uself") return "[ru_v(user, "вста;ёт;ёт;ёт;ют;;")] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("upast") return "[ru_v(user, "поднял;;а;о;и;;")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uyou") return "встали [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
	else
		switch(tense)
			//buckle
			if("present") return "[ru_v(user, "усажива;ет;ет;ет;ют;;")] [who] на [ru_case(seat, "acase")]"
			if("self") return "[ru_v(user, "сад;ит;ит;ит;ат;ся;")] на [ru_case(seat, "acase")]"
			if("past") return "[ru_v(user, "усадил;;а;о;и;;")] [who] на [ru_case(seat, "acase")]"
			if("participle") return "[ru_v(user, "сид;ит;ит;ит;ят;;")] на [ru_case(seat, "pcase")]"
			if("action") return "усаживаете [who] на [ru_case(seat, "acase")]"
			if("indefinite") return "усадить [who] на [ru_case(seat, "acase")]"
			if("you") return "сели на [ru_case(seat, "acase")]"
			//unbuckle
			if("upresent") return "[ru_v(user, "поднима;ет;ет;ет;ют;;")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uself") return "[ru_v(user, "вста;ёт;ёт;ёт;ют;;")] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("upast") return "[ru_v(user, "поднял;;а;о;и;;")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uyou") return "встали [ru_p(seat, "с")] [ru_case(seat, "gcase")]"

// The following proc adjusts a preposition to be used before a word. The list of consonants is provided for this very cause.
var/global/list/consonants = list("б", "в", "г", "д", "ж", "з", "й", "к", "л", "м", "н", "п", "р", "с", "т", "ф", "х", "ц", "ч", "ш", "щ")

/proc/ru_p(atom/input, preposition = "", capital = 0)
	var/first_letter = lowertext(copytext_char(ru_case(input, "ncase"), 1, 2))
	var/second_letter = lowertext(copytext_char(ru_case(input, "ncase"), 2, 3))
	switch(preposition)
		if("с")
			var/list/c_letter = list("с", "ж", "з", "ш", "л", "р", "м", "в", "щ")
			for(var/let_s in c_letter)
				if (first_letter == "щ") return "[capital? "Со" : "со"]"
				else if (first_letter == let_s)
					for(var/cons_s in consonants)
						if (second_letter == cons_s) return "[capital? "Со" : "со"]"
			return "[capital? "С" : "с"]"
		if("в")
			var/list/v_letter = list("в", "ф")
			for(var/let_v in v_letter)
				if (first_letter == let_v)
					for(var/cons_v in consonants)
						if (second_letter == cons_v) return "[capital? "Во" : "в"]"
			return "[capital? "В" : "в"]"
		else 
			crash_with("Проку ru_p передан недопустимый предлог: [preposition].")
			return "[capital? "[capitalize(preposition)]" : "[preposition]"]"

// This is a simple proc that adds an apropriate ending to a verb depending on the user's gender. This is core.
/proc/ru_g(input, base_verb = "", he_end = "", she_end = "а", it_end = "о", they_end = "и")
	var/gender_key = "male"
	if(istype(input, /mob/living/carbon/human))
		var/mob/user = input
		var/datum/gender/user_gender = gender_datums[user.get_visible_gender()]
		gender_key = user_gender.key
	else if (istype(input, /atom))
		var/atom/A = input
		gender_key = A.ru_cases["rugender"]
	switch(gender_key)
		if("male") return "[base_verb][he_end]"
		if("female") return "[base_verb][she_end]"
		if("neuter") return "[base_verb][it_end]"
		if("plural") return "[base_verb][they_end]"
	return "[base_verb][he_end]"

// An updated version of ru_g that helps handle hardcoded messages, e.g. arrivals/cryo announcements and attack verbs.
// Input template: "base/m_ending/f_ending/n_ending/p_ending/extra_text/case". Case defines the target's case, or hides target if unspecified.
/proc/ru_v(var/atom/verb_user, var/input, var/atom/target)
	var/list/message_list = splittext_char(input, ";")
	if(!message_list.len == 1)
		return "[ru_g(verb_user, input)]" // If the template is omitted, use the default verb endings.
	if(message_list.len < 6)
		crash_with("Глагол ru_v не соответствует шаблону! Ввод: [input], проверка выдала [message_list.len].")
		return message_list[1]
	var/who = message_list[7]
	if (findtext_char(input, "case"))
		who = ru_case(target, message_list[7])
	return "[ru_g(verb_user, message_list[1], message_list[2], message_list[3], message_list[4], message_list[5])][who? " [who] " : ""][message_list[6]]"

// It looks silly, but it's very important for attack verbs that need custom cases that can't be provided with ru_case.
/proc/ru_att_p(var/att_prep, var/att_case, var/ncase, var/gcase, var/dcase, var/acase, var/icase, var/pcase, var/obj/target)
	if(target)
		return "[ru_p(target, att_prep)] [ru_case(target, att_case)]"
	if(att_case == "ncase") return "[att_prep] [ncase]"
	if(att_case == "gcase") return "[att_prep] [gcase]"
	if(att_case == "dcase") return "[att_prep] [dcase]"
	if(att_case == "acase") return "[att_prep] [acase]"
	if(att_case == "icase") return "[att_prep] [icase]"
	if(att_case == "pcase") return "[att_prep] [pcase]"

// Handles the ru_p_override var.
/proc/ru_area_name(var/area/input)
	if(!input.ru_p_override) return "[ru_p(input, "в")] [ru_case(input, "pcase")]"
	else return "на [ru_case(input, "pcase")]"

/client/add_admin_verbs()
	if(holder)
		verbs += /client/proc/case_viewer
		verbs += /client/proc/case_editor
	..()

/client/proc/case_viewer(var/atom/A in world)
	set category = "Дебаг"
	set name = "Проверить Падежи"
	set desc = "Отобразить падежи атома."

	if(A)
		to_chat(usr, "Найдены следующие падежи атома: ")
		for (var/case in A.ru_cases)
			to_chat(usr, "[(case == "rugender")? "Род: [A.ru_cases[case]]" : "[case]: [A.ru_cases[case]]"]<br>")

/client/proc/case_editor(var/atom/A in world)
	set category = "Дебаг"
	set name = "Установить Падежи"
	set desc = "Установить род и падежи атома."

	if(A)
		A.ru_cases["rugender"] = sanitize(input(usr, "Введите род (male/female/neuter/plural):", "Установить Падежи", A.ru_cases["rugender"]))
		A.ru_cases["ncase"] = sanitize(input(usr, "Введите именительный падеж:", "Установить Падежи", A.ru_cases["ncase"]))
		A.ru_cases["gcase"] = sanitize(input(usr, "Введите родительный падеж:", "Установить Падежи", A.ru_cases["gcase"]))
		A.ru_cases["dcase"] = sanitize(input(usr, "Введите дательный падеж:", "Установить Падежи", A.ru_cases["dcase"]))
		A.ru_cases["acase"] = sanitize(input(usr, "Введите винительный падеж:", "Установить Падежи", A.ru_cases["acase"]))
		A.ru_cases["icase"] = sanitize(input(usr, "Введите творительный падеж:", "Установить Падежи", A.ru_cases["icase"]))
		A.ru_cases["pcase"] = sanitize(input(usr, "Введите предложный падеж:", "Установить Падежи", A.ru_cases["pcase"]))