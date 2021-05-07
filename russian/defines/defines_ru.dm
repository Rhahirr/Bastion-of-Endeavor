// gases.dm

// Bastion of Endeavor TODO: Gotta remember to update these decls once they are axed upstream.
//Male Noun 1a
/decl/xgm_gas/oxygen/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "кислород"
	ru_cases["gcase"] = "кислорода"
	ru_cases["dcase"] = "кислороду"
	ru_cases["acase"] = "кислород"
	ru_cases["icase"] = "кислородом"
	ru_cases["pcase"] = "кислороде"
	name = "Кислород"

//Male Noun 1a
/decl/xgm_gas/nitrogen/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "азот"
	ru_cases["gcase"] = "азота"
	ru_cases["dcase"] = "азоту"
	ru_cases["acase"] = "азот"
	ru_cases["icase"] = "азотом"
	ru_cases["pcase"] = "азоте"
	name = "Азот"

//Male Adj 1*a + Noun 3a
/decl/xgm_gas/carbon_dioxide/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "углекислый газ"
	ru_cases["gcase"] = "углекислого газа"
	ru_cases["dcase"] = "углекислому газу"
	ru_cases["acase"] = "углекислый газ"
	ru_cases["icase"] = "углекислым газом"
	ru_cases["pcase"] = "углекислом газе"
	name = "Углекислый газ"

//Male Noun 1a
/decl/xgm_gas/phoron/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "форон"
	ru_cases["gcase"] = "форона"
	ru_cases["dcase"] = "форону"
	ru_cases["acase"] = "форон"
	ru_cases["icase"] = "фороном"
	ru_cases["pcase"] = "фороне"
	name = "Форон"

//Male Adj 1*a + Adj 2a/c + Noun 2a
/decl/xgm_gas/volatile_fuel/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "летучее топливо"
	ru_cases["gcase"] = "летучего топлива"
	ru_cases["dcase"] = "летучему топливу"
	ru_cases["acase"] = "летучее топливо"
	ru_cases["icase"] = "летучим топливом"
	ru_cases["pcase"] = "летучем топливе"
	name = "Летучеетопливо"

//Male Noun 1a
/decl/xgm_gas/nitrous_oxide/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "оксид азота"
	ru_cases["gcase"] = "оксида азота"
	ru_cases["dcase"] = "оксиду азота"
	ru_cases["acase"] = "оксид азота"
	ru_cases["icase"] = "оксидом азота"
	ru_cases["pcase"] = "оксиде азота"
	name = "Оксид азота"

// objs.dm
//Male Noun 1a
/obj/effect/beam/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "луч"
	ru_cases["gcase"] = "луча"
	ru_cases["dcase"] = "лучу"
	ru_cases["acase"] = "луч"
	ru_cases["icase"] = "лучом"
	ru_cases["pcase"] = "луче"
	name = "Луч"


//Neuter Noun 1c
/obj/effect/begin/New()
	..()
	ru_cases["rugender"] = "neuter"
	ru_cases["ncase"] = "начало"
	ru_cases["gcase"] = "начала"
	ru_cases["dcase"] = "началу"
	ru_cases["acase"] = "начало"
	ru_cases["icase"] = "началом"
	ru_cases["pcase"] = "начале"
	name = "Начало"

//Male Noun 1a
/obj/effect/laser/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "лазер"
	ru_cases["gcase"] = "лазера"
	ru_cases["dcase"] = "лазеру"
	ru_cases["acase"] = "лазер"
	ru_cases["icase"] = "лазером"
	ru_cases["pcase"] = "лазере"
	name = "Лазер"
	desc = "ГОРЯЧО!!!"

//Female Noun 7a
/obj/effect/projection/New()
	..()
	ru_cases["rugender"] = "female"
	ru_cases["ncase"] = "проекция"
	ru_cases["gcase"] = "проекции"
	ru_cases["dcase"] = "проекции"
	ru_cases["acase"] = "проекцию"
	ru_cases["icase"] = "проекцией"
	ru_cases["pcase"] = "проекции"
	name = "Проекция"
	desc = "Похоже на проекцию чего-то."

// Fuck if I know how to read this, commenting this out since it's unused just like the rest of this god forsaken file.
/*
/obj/effect/shut_controller
	name = "shut controller"
*/

//Female Noun 6a
/obj/structure/showcase/New()
	..()
	ru_cases["rugender"] = "female"
	ru_cases["ncase"] = "статуя"
	ru_cases["gcase"] = "статуи"
	ru_cases["dcase"] = "статуе"
	ru_cases["acase"] = "статую"
	ru_cases["icase"] = "статуей"
	ru_cases["pcase"] = "статуе"
	name = "Статуя"
	desc = "Манекен из пустого тела киборга."

//Female Noun 3*a
/obj/structure/showcase/sign/New()
	..()
	ru_cases["rugender"] = "female"
	ru_cases["ncase"] = "табличка"
	ru_cases["gcase"] = "таблички"
	ru_cases["dcase"] = "табличке"
	ru_cases["acase"] = "табличку"
	ru_cases["icase"] = "табличкой"
	ru_cases["pcase"] = "табличке"
	name = "ВНИМАНИЕ: ДИКАЯ МЕСТНОСТЬ"
	desc = "Похоже, эта табличка хочет предупредить Вас о том, что на другой стороне находиться опасно. А ещё она гласит, что NanoTrasen не может гарантировать Вашу безопасность за этой чертой."

//Male Adj 1*a + Noun 3a
/obj/item/weapon/beach_ball/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "пляжный мяч"
	ru_cases["gcase"] = "пляжного мяча"
	ru_cases["dcase"] = "пляжному мячу"
	ru_cases["acase"] = "пляжный мяч"
	ru_cases["icase"] = "пляжным мячом"
	ru_cases["pcase"] = "пляжном мяче"
	name = "Пляжный мяч"

//Male Noun 1a
/obj/effect/spawner/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "спавнер объектов"
	ru_cases["gcase"] = "спавнера объектов"
	ru_cases["dcase"] = "спавнеру объектов"
	ru_cases["acase"] = "спавнер объектов"
	ru_cases["icase"] = "спавнером объектов"
	ru_cases["pcase"] = "спавнере объектов"
	name = "Спавнер объектов"
