/atom
	var/rugender = "unset"
	var/ncase
	var/gcase
	var/dcase
	var/acase
	var/icase
	var/pcase

/area
	var/ru_p_override = FALSE
	var/ru_area_fancy_name

/datum/reagent
	var/rugender = "unset"
	var/ncase
	var/gcase
	var/dcase
	var/acase
	var/icase
	var/pcase
	var/glass_ncase = "стакан с чем-то"
	var/glass_gcase = "стакана с чем-то"
	var/glass_dcase = "стакану с чем-то"
	var/glass_acase = "стакан с чем-то"
	var/glass_icase = "стаканом с чем-то"
	var/glass_pcase = "стакане с чем-то"
	var/glass_rugender = "neuter"

/obj/item/weapon/reagent_containers/food/snacks
	var/ru_foodtype

/obj/item/stack
	var/singular_name_rugender
	var/singular_name_ncase
	var/singular_name_gcase
	var/singular_name_dcase
	var/singular_name_acase
	var/singular_name_icase
	var/singular_name_pcase
	var/plural_name_rugender
	var/plural_name_ncase
	var/plural_name_gcase
	var/plural_name_dcase
	var/plural_name_acase
	var/plural_name_icase
	var/plural_name_pcase
	
/obj/item/organ/external
	var/joint_rugender
	var/joint_ncase
	var/joint_gcase
	var/joint_dcase
	var/joint_acase
	var/joint_icase
	var/joint_pcase
	var/amputation_point_rugender
	var/amputation_point_ncase
	var/amputation_point_gcase
	var/amputation_point_dcase
	var/amputation_point_acase
	var/amputation_point_icase
	var/amputation_point_pcase
	var/encased_rugender
	var/encased_ncase
	var/encased_gcase
	var/encased_dcase
	var/encased_acase
	var/encased_icase
	var/encased_pcase

/obj/effect/decal/cleanable/blood
	var/dryncase = "засохшая кровь"
	var/drygcase = "засохшей крови"
	var/drydcase = "засохшей крови"
	var/dryacase = "засохшую кровь"
	var/dryicase = "засохшей кровью"
	var/drypcase = "засохшей крови"

/decl/flooring
	var/rugender
	var/ncase
	var/gcase
	var/dcase
	var/acase
	var/icase
	var/pcase

datum/preferences
	var/list/cases = list()

/proc/ru_count(var/input, single_text = "единица", few_text = "единицы", many_text = "единиц")
	var/output
	var/out_text = many_text
	if(istype(input, /list))
		var/list/input_list = input
		output = input_list.len
	else output = input
	var/a = round(output) % 100
	var/b = round(output) % 10
	if (a > 10 && a < 20) out_text = many_text
	if (b > 1 && b < 5) out_text = few_text
	if (b == 1) out_text = single_text
	return "[output] [out_text]"

/proc/ru_case(atom/input, case = "case")
	if(!(istype(input, /atom)) || !(istype(input, /datum)))
		crash_with("Проку ru_case передан не атом/датум! Ввод: [input]")
		return input
	if(case == "ncase" && input.ncase) return input.ncase
	if(case == "gcase" && input.gcase) return input.gcase
	if(case == "dcase" && input.dcase) return input.dcase
	if(case == "acase" && input.acase) return input.acase
	if(case == "icase" && input.icase) return input.icase
	if(case == "pcase" && input.pcase) return input.pcase
	return input.name

/proc/ru_g(input, base_verb = "", he_end = "", she_end = "а", it_end = "о", they_end = "и")
	var/gender_key = "male"
	if(istype(input, /mob/living/carbon/human))
		var/mob/user = input
		var/datum/gender/user_gender = gender_datums[user.get_visible_gender()]
		gender_key = user_gender.key
	else if (istype(input, /atom))
		var/atom/A = input
		gender_key = A.rugender
	switch(gender_key)
		if("male") return "[base_verb][he_end]"
		if("female") return "[base_verb][she_end]"
		if("neuter") return "[base_verb][it_end]"
		if("plural") return "[base_verb][they_end]"
	return "[base_verb][he_end]"

/proc/ru_cap(atom/input, var/case = "ncase")
	return "[capitalize(ru_case(input, case))]"

//adds something to the end of every case
/atom/proc/ru_addtocase(atom/input, content)
	input.ncase = "[initial(input.ncase)][content]"
	input.gcase = "[initial(input.gcase)][content]"
	input.dcase = "[initial(input.dcase)][content]"
	input.acase = "[initial(input.acase)][content]"
	input.icase = "[initial(input.icase)][content]"
	input.pcase = "[initial(input.pcase)][content]"
	return

/proc/ru_matadj(datum/material, case = "case", gender = "gender", input = "", pre = " из ")
	var/datum/material/mat = material
	var/adjective = ""
	if(gender == "male")
		if(case == "ncase") adjective = mat.adj_m_ncase
		if(case == "gcase") adjective = mat.adj_m_gcase
		if(case == "dcase") adjective = mat.adj_m_dcase
		if(case == "acase") adjective = mat.adj_m_acase
		if(case == "icase") adjective = mat.adj_m_icase
		if(case == "pcase") adjective = mat.adj_m_pcase
	if(gender == "female")
		if(case == "ncase") adjective = mat.adj_f_ncase
		if(case == "gcase") adjective = mat.adj_f_gcase
		if(case == "dcase") adjective = mat.adj_f_dcase
		if(case == "acase") adjective = mat.adj_f_acase
		if(case == "icase") adjective = mat.adj_f_icase
		if(case == "pcase") adjective = mat.adj_f_pcase
	if(gender == "neuter")
		if(case == "ncase") adjective = mat.adj_n_ncase
		if(case == "gcase") adjective = mat.adj_n_gcase
		if(case == "dcase") adjective = mat.adj_n_dcase
		if(case == "acase") adjective = mat.adj_n_acase
		if(case == "icase") adjective = mat.adj_n_icase
		if(case == "pcase") adjective = mat.adj_n_pcase
	if(gender == "plural")
		if(case == "ncase") adjective = mat.adj_p_ncase
		if(case == "gcase") adjective = mat.adj_p_gcase
		if(case == "dcase") adjective = mat.adj_p_dcase
		if(case == "acase") adjective = mat.adj_p_acase
		if(case == "icase") adjective = mat.adj_p_icase
		if(case == "pcase") adjective = mat.adj_p_pcase
	if(mat.name_override) return "[input][pre][mat.display_name_gcase]"
	else return "[adjective][(input != "")? " [input]" : ""]"
	return

/proc/ru_buckleverb(obj/seat, mob/user, tense = "present", mob/target)
	var/who
	if(target)
		who = "[ru_case(target, "acase")]"
	else
		who = "Вас"
	if(istype(seat, /obj/structure/bed/chair/shuttle) || istype(seat, /obj/structure/bed/chair/bay/shuttle))
		switch(tense)
			//buckle
			if("present") return "[ru_v(user, "пристёгива/ет/ет/ет/ют//")] [who] к [ru_case(seat, "dcase")]"
			if("self") return "[ru_v(user, "пристегнул/ся/ась/ось/ись//")] к [ru_case(seat, "dcase")]"
			if("past") return "[ru_v(user, "пристегнул//а/о/и//")] [who] к [ru_case(seat, "dcase")]"
			if("participle") return "[ru_v(user, "пристёгнут//а/о/ы//")] к [ru_case(seat, "dcase")]"
			if("action") return "пристёгиваете [who] к [ru_case(seat, "dcase")]"
			if("indefinite") return "пристегнуть [who] к [ru_case(seat, "dcase")]"
			if("you") return "пристегнулись к [ru_case(seat, "dcase")]"
			//unbuckle
			if("upresent") return "[ru_v(user, "отстёгива/ет/ет/ет/ют//")] [who] от [ru_case(seat, "gcase")]"
			if("uself") return "[ru_v(user, "отстегнул/ся/ась/ось/ись//")] от [ru_case(seat, "gcase")]"
			if("upast") return "[ru_v(user, "отстегнул//а/о/и//")] [who] от [ru_case(seat, "gcase")]"
			if("uyou") return "отстегнулись от [ru_case(seat, "gcase")]"
	else if(istype(seat, /obj/structure/bed/chair/comfy))
		switch(tense)
			//buckle
			if("present") return "[ru_v(user, "усажива/ет/ет/ет/ют//")] [who] [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			if("self") return "[ru_v(user, "сад/ит/ит/ит/ят/ся/")] [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			if("past") return "[ru_v(user, "посадил//а/о/и//")] [who] [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			if("participle") return "[ru_v(user, "сид/ит/ит/ит/ят//")] [ru_p(seat, "в")] [ru_case(seat, "pcase")]"
			if("action") return "усаживаете [who] [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			if("indefinite") return "усадить [who] [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			if("you") return "сели [ru_p(seat, "в")] [ru_case(seat, "acase")]"
			//unbuckle
			if("upresent") return "[ru_v(user, "поднима/ет/ет/ет/ют//")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uself") return "[ru_v(user, "вста/ёт/ёт/ёт/ют//")] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("upast") return "[ru_v(user, "поднял//а/о/и//")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uyou") return "встали [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
	else if(istype(seat, /obj/structure/bed/chair))
		switch(tense)
			//buckle
			if("present") return "[ru_v(user, "усажива/ет/ет/ет/ют//")] [who] на [ru_case(seat, "acase")]"
			if("self") return "[ru_v(user, "сад/ит/ит/ит/ят/ся/")] на [ru_case(seat, "acase")]"
			if("past") return "[ru_v(user, "усадил//а/о/и//acase")] [who] на [ru_case(seat, "acase")]"
			if("participle") return "[ru_v(user, "сид/ит/ит/ит/ят//")] на [ru_case(seat, "pcase")]"
			if("action") return "усаживаете [who] на [ru_case(seat, "acase")]"
			if("indefinite") return "усадить [who] на [ru_case(seat, "acase")]"
			if("you") return "сели на [ru_case(seat, "acase")]"
			//unbuckle
			if("upresent") return "[ru_v(user, "поднима/ет/ет/ет/ют//")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uself") return "[ru_v(user, "вста/ёт/ёт/ёт/ют//")] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("upast") return "[ru_v(user, "поднял//а/о/и//")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uyou") return "встали [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
	else if(istype(seat, /obj/structure/bed) || istype(seat, /obj/structure/dogbed))
		switch(tense)
			//buckle
			if("present") return "[ru_v(user, "укладыва/ет/ет/ет/ют//")] [who] на [ru_case(seat, "acase")]"
			if("self") return "[ru_v(user, "лож/ит/ит/ит/ат/ся/")] на [ru_case(seat, "acase")]"
			if("past") return "[ru_v(user, "положил//а/о/и//")] [who] на [ru_case(seat, "acase")]"
			if("participle") return "[ru_v(user, "леж/ит/ит/ит/ат//")] на [ru_case(seat, "pcase")]"
			if("action") return "укладываете [who] на [ru_case(seat, "acase")]"
			if("indefinite") return "положить [who] на [ru_case(seat, "acase")]"
			if("you") return "легли на [ru_case(seat, "acase")]"
			//unbuckle
			if("upresent") return "[ru_v(user, "поднима/ет/ет/ет/ют//")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uself") return "[ru_v(user, "вста/ёт/ёт/ёт/ют//")] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("upast") return "[ru_v(user, "поднял//а/о/и//")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uyou") return "встали [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
	else
		switch(tense)
			//buckle
			if("present") return "[ru_v(user, "усажива/ет/ет/ет/ют//")] [who] на [ru_case(seat, "acase")]"
			if("self") return "[ru_v(user, "сад/ит/ит/ит/ат/ся/")] на [ru_case(seat, "acase")]"
			if("past") return "[ru_v(user, "усадил//а/о/и//")] [who] на [ru_case(seat, "acase")]"
			if("participle") return "[ru_v(user, "сид/ит/ит/ит/ят//")] на [ru_case(seat, "pcase")]"
			if("action") return "усаживаете [who] на [ru_case(seat, "acase")]"
			if("indefinite") return "усадить [who] на [ru_case(seat, "acase")]"
			if("you") return "сели на [ru_case(seat, "acase")]"
			//unbuckle
			if("upresent") return "[ru_v(user, "поднима/ет/ет/ет/ют//")] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uself") return "[ru_v(user, "вста/ёт/ёт/ёт/ют//")] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("upast") return "[ru_v(user, "поднял//а/о/и//")] [who] [who] [ru_p(seat, "с")] [ru_case(seat, "gcase")]"
			if("uyou") return "встали [ru_p(seat, "с")] [ru_case(seat, "gcase")]"

var/global/list/consonants = list("б", "в", "г", "д", "ж", "з", "й", "к", "л", "м", "н", "п", "р", "с", "т", "ф", "х", "ц", "ч", "ш", "щ")
/proc/ru_p(atom/input, preposition = "")
	var/first_letter = lowertext(copytext_char(ru_case(input, "ncase"), 1, 2))
	var/second_letter = lowertext(copytext_char(ru_case(input, "ncase"), 2, 3))
	switch(preposition)
		if("с")
			var/list/c_letter = list("с", "ж", "з", "ш", "л", "р", "м", "в", "щ")
			for(var/let_s in c_letter)
				if (first_letter == "щ") return "со"
				else if (first_letter == let_s)
					for(var/cons_s in consonants)
						if (second_letter == cons_s) return "со"
			return "с"
		if("в")
			var/list/v_letter = list("в", "ф")
			for(var/let_v in v_letter)
				if (first_letter == let_v)
					for(var/cons_v in consonants)
						if (second_letter == cons_v) return "во"
			return "в"
		else 
			crash_with("Проку ru_p передан недопустимый предлог: [preposition].")
			return preposition

//an updated version of ru_g that helps handle hardcoded messages, e.g. arrivals/cryo announcements and attack verbs
//input template: "base/m_ending/f_ending/n_ending/p_ending/extra_text/case". case defines the target's case, or hides target if unspecified
/proc/ru_v(var/atom/verb_user, var/input, var/atom/target)
	var/checker = 0
	for(var/i=1, i<length(input), i++)
		if(copytext_char(input, i, i+1) == "/") //i'd use a regex but they dont seem to work with unicode or something
			checker += 1
	if(checker != 6)
		crash_with("Глагол ru_v не соответствует шаблону! Ввод: [input], проверка выдала [checker].")
		return input
	var/list/message_list = splittext_char(input, "/")
	var/who = message_list[7]
	if (findtext_char(input, "case"))
		who = ru_case(target, message_list[7])
	return "[ru_g(verb_user, message_list[1], message_list[2], message_list[3], message_list[4], message_list[5])][who? " [who] " : ""][message_list[6]]"

/mob/self_user // a holder for "self" words to be used with ru_v if the target is the user themselves
	gcase = "себя"
	dcase = "себе"
	acase = "себя"
	icase = "собой"
	pcase = "себе"

/proc/ru_att_p(var/att_prep, var/att_case, var/ncase, var/gcase, var/dcase, var/acase, var/icase, var/pcase, var/obj/target)
	if(target)
		return "[ru_p(target, att_prep)] [ru_case(target, att_case)]"
	if(att_case == "ncase") return "[att_prep] [ncase]"
	if(att_case == "gcase") return "[att_prep] [gcase]"
	if(att_case == "dcase") return "[att_prep] [dcase]"
	if(att_case == "acase") return "[att_prep] [acase]"
	if(att_case == "icase") return "[att_prep] [icase]"
	if(att_case == "pcase") return "[att_prep] [pcase]"

/proc/ru_area_name(var/area/input)
	if(!input.ru_p_override) return "[ru_p(input, "в")] [ru_case(input, "pcase")]"
	else return "на [ru_case(input, "pcase")]"