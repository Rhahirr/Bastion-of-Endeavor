/* 	Alright, so. This is going to be absolutely atrocious, but for the sake of looking polished in Russian, this must all be done.
	The following code gives the supply packs a specific var that will be tossed into the cases of the crate itself.
	Should the worst happen and the need to override the template arise, all of this should be safe to override with New().
*/


/datum/supply_pack
	var/list/ru_cases = new /list()
	var/ru_supply_pack_name

/datum/supply_pack/New()
	..()
	ru_cases["containername"] = new /list()
	ru_cases["containername"]["rugender"] = "male"
	ru_cases["containername"]["ncase"] = "ящик от [ru_supply_pack_name]"
	ru_cases["containername"]["gcase"] = "ящика от [ru_supply_pack_name]"
	ru_cases["containername"]["dcase"] = "ящику от [ru_supply_pack_name]"
	ru_cases["containername"]["acase"] = "ящик от [ru_supply_pack_name]"
	ru_cases["containername"]["icase"] = "ящиком от [ru_supply_pack_name]"
	ru_cases["containername"]["pcase"] = "ящике от [ru_supply_pack_name]"
	containername = "Ящик от [ru_supply_pack_name]"

// atmospherics.dm

/datum/supply_pack/atmos
	group = "Атмосфера"

/datum/supply_pack/atmos/inflatable
	name = "Надувные барьеры"
	ru_supply_pack_name = "надувных барьеров"

/datum/supply_pack/atmos/canister_empty
	name = "Канистра (пустая)"
	ru_supply_pack_name = "пустой канистры"

/datum/supply_pack/atmos/canister_air
	name = "Канистра с воздухом"
	ru_supply_pack_name = "канистры с воздухом"

/datum/supply_pack/atmos/canister_oxygen
	name = "Канистра с кислородом"
	ru_supply_pack_name = "канистры с кислородом"

/datum/supply_pack/atmos/canister_nitrogen
	name = "Канистра с азотом"
	ru_supply_pack_name = "канистры с азотом"

/datum/supply_pack/atmos/canister_phoron
	name = "Канистра с газообразным фороном"
	ru_supply_pack_name = "канистры с фороном"

/datum/supply_pack/atmos/canister_nitrous_oxide
	name = "Канистра с оксидом азота"
	ru_supply_pack_name = "канистры с N2O"

/datum/supply_pack/atmos/canister_carbon_dioxide
	name = "Канистра с углекислым газом"
	ru_supply_pack_name = "канистры с CO2"

/datum/supply_pack/atmos/air_dispenser
	name = "Раздатчик труб"
	ru_supply_pack_name = "раздатчика труб"

/datum/supply_pack/atmos/disposals_dispenser
	name = "Раздатчик сортировочных труб"
	ru_supply_pack_name = "раздатчика сортировочных труб"

/datum/supply_pack/atmos/internals
	name = "Дыхательные комплекты"
	ru_supply_pack_name = "дыхательных комплектов"

/datum/supply_pack/atmos/evacuation
	name = "Экстренные средства защиты"
	ru_supply_pack_name = "экстренных средств защиты"

// contraband_vr.dm

/datum/supply_pack/supply/stolen
	name = "Украденный груз"
	containername = "Украденный ящик"

/datum/supply_pack/supply/stolen/New()
	..()
	ru_cases["containername"]["rugender"] = "male"
	ru_cases["containername"]["ncase"] = "украденный ящик"
	ru_cases["containername"]["gcase"] = "украденного ящика"
	ru_cases["containername"]["dcase"] = "украденному ящику"
	ru_cases["containername"]["acase"] = "украденный ящик"
	ru_cases["containername"]["icase"] = "украденным ящиком"
	ru_cases["containername"]["pcase"] = "украденном ящике"

/datum/supply_pack/supply/wolfgirl
	name = "Ящик с волкодевочкой"
	ru_supply_pack_name = "волкодевочки"

/datum/supply_pack/supply/catgirl
	name = "Ящик с кошкодевочкой"
	ru_supply_pack_name = "кошкодевочки"

/datum/supply_pack/randomised/hospitality/pizzavouchers
	name = "ЯЩИК С КУПОНАМИ НА ПОТРЯСАЮЩУЮ ПИЦЦУ!"
	containername = "МЫ ВСЕГДА ДОСТАВЛЯЕМ!"

/datum/supply_pack/randomised/hospitality/pizzavouchers/New()
	..()
	ru_cases["containername"]["rugender"] = "male"
	ru_cases["containername"]["ncase"] = "МЫ ВСЕГДА ДОСТАВЛЯЕМ!"
	ru_cases["containername"]["gcase"] = "МЫ ВСЕГДА ДОСТАВЛЯЕМ!"
	ru_cases["containername"]["dcase"] = "МЫ ВСЕГДА ДОСТАВЛЯЕМ!"
	ru_cases["containername"]["acase"] = "МЫ ВСЕГДА ДОСТАВЛЯЕМ!"
	ru_cases["containername"]["icase"] = "МЫ ВСЕГДА ДОСТАВЛЯЕМ!"
	ru_cases["containername"]["pcase"] = "МЫ ВСЕГДА ДОСТАВЛЯЕМ!"

// contraband.dm 

/datum/supply_pack/randomised/contraband
	name = "Ящик с контрабандой"
	containername = "Ящик без подписи"
	group = "Снабжение"

/datum/supply_pack/randomised/contraband/New()
	..()
	ru_cases["containername"]["rugender"] = "male"
	ru_cases["containername"]["ncase"] = "ящик без подписи"
	ru_cases["containername"]["gcase"] = "ящика без подписи"
	ru_cases["containername"]["dcase"] = "ящику без подписи"
	ru_cases["containername"]["acase"] = "ящик без подписи"
	ru_cases["containername"]["icase"] = "ящиком без подписи"
	ru_cases["containername"]["pcase"] = "ящике без подписи"

/datum/supply_pack/security/specialops
	name = "Спецназовское снаряжение"
	ru_supply_pack_name = "спецназовского снаряжения"

/datum/supply_pack/supply/moghes
	name = "Импортные товары с Мога"
	ru_supply_pack_name = "импортных товаров с Мога"

/datum/supply_pack/munitions/bolt_rifles_militia
	name = "Оружие - Ополченческие ружья"
	ru_supply_pack_name = "баллистического оружия"

/datum/supply_pack/randomised/misc/telecrate
	name = "ERR_NULL_ENTRY"
	containername = "Подозрительный ящик"

/datum/supply_pack/randomised/misc/telecrate/New()
	..()
	ru_cases["containername"]["rugender"] = "male"
	ru_cases["containername"]["ncase"] = "украденный ящик"
	ru_cases["containername"]["gcase"] = "украденного ящика"
	ru_cases["containername"]["dcase"] = "украденному ящику"
	ru_cases["containername"]["acase"] = "украденный ящик"
	ru_cases["containername"]["icase"] = "украденным ящиком"
	ru_cases["containername"]["pcase"] = "украденном ящике"

// costumes_vr.dm

/datum/supply_pack/costumes/xenowear_vr
	name = "Набор расовой одежды"
	ru_supply_pack_name = "набора расовой одежды"

/datum/supply_pack/costumes/tesh_smocks_vr
	ru_supply_pack_name = "набора халатиков тешари"
	name = "Тешари — Халатики"

/datum/supply_pack/randomised/costumes/tesh_coats_vr
	ru_supply_pack_name = "набора накидок тешари"
	name = "Тешари — Накидки"

/datum/supply_pack/randomised/costumes/tesh_coats_b_vr
	ru_supply_pack_name = "набора накидок тешари"
	name = "Тешари — Накидки (чёрные)"

/datum/supply_pack/randomised/costumes/tesh_cloaks_vr
	ru_supply_pack_name = "набора плащиков тешари"
	name = "Тешари — Плащики"

/datum/supply_pack/randomised/costumes/tesh_cloaks_b_vr
	ru_supply_pack_name = "набора плащиков тешари"
	name = "Тешари — Плащики (чёрные)"

/datum/supply_pack/costumes/tesh_worksuits_vr
	ru_supply_pack_name = "набора рабочих костюмчиков тешари"
	name = "Тешари — Рабочие костюмчики"

/datum/supply_pack/randomised/costumes/tesh_beltcloaks_vr
	ru_supply_pack_name = "набора плащиков тешари"
	name = "Тешари — Плащики с ремешком"

/datum/supply_pack/randomised/costumes/tesh_beltcloaks_b_vr
	ru_supply_pack_name = "набора плащиков тешари"
	name = "Тешари — Плащики с ремешком (чёрные)"

/datum/supply_pack/randomised/costumes/tesh_hoodcloaks_vr
	ru_supply_pack_name = "набора плащиков тешари"
	name = "Тешари — Плащики с капюшоном"

/datum/supply_pack/randomised/costumes/tesh_hoodcloaks_b_vr
	name = "Тешари — Плащики с капюшоном (чёрные)"
	ru_supply_pack_name = "набора плащиков тешари"

/datum/supply_pack/costumes/utility_vr
	ru_supply_pack_name = "комплектов одежды"
	name = "Комплекты водолазок и брюк"

/datum/supply_pack/costumes/skirts_vr
	ru_supply_pack_name = "набора юбок"
	name = "Набор юбок"

/datum/supply_pack/costumes/varsity_vr
	ru_supply_pack_name = "набора спортивных курток"
	name = "Набор спортивных курток"

/datum/supply_pack/randomised/costumes/leathergear_vr
	ru_supply_pack_name = "набора кожаной одежды"
	name = "Набор кожаной одежды"

/datum/supply_pack/costumes/eyewear_vr
	ru_supply_pack_name = "набора очков"
	name = "Набор очков и повязок"

/datum/supply_pack/randomised/costumes/gloves_vr
	ru_supply_pack_name = "набора перчаток"
	name = "Набор перчаток"

/datum/supply_pack/randomised/costumes/boots_vr
	ru_supply_pack_name = "набора ботинок"
	name = "Набор ботинок"

/datum/supply_pack/costumes/taurbags
	ru_supply_pack_name = "набора сёдел"
	name = "Набор сёдел"

/datum/supply_pack/costumes/knights_gear
	ru_supply_pack_name = "комплектов рыцарской брони"
	name = "Комплекты костюма рыцаря"

// costumes.dm

/datum/supply_pack/costumes
	group = "Одежда"

/datum/supply_pack/randomised/costumes
	group = "Одежда"

/datum/supply_pack/costumes/wizard
	ru_supply_pack_name = "костюма волшебника"
	name = "Костюм волшебника"

/datum/supply_pack/randomised/costumes/hats
	ru_supply_pack_name = "коллекционных шляп"
	name = "Коллекционные шляпы!"

/datum/supply_pack/randomised/costumes/costume
	ru_supply_pack_name = "набора реквизитных костюмов"
	name = "Набор реквизитных костюмов"

/datum/supply_pack/costumes/formal_wear
	ru_supply_pack_name = "комплектов официальной одежды"
	name = "Комплекты официальной одежды (костюмы)"

/datum/supply_pack/costumes/witch
	ru_supply_pack_name = "костюма ведьмы"
	name = "Костюм ведьмы"

/datum/supply_pack/randomised/costumes/costume_hats
	ru_supply_pack_name = "набора реквизитных шляп"
	name = "Набор реквизитных шляп"

/datum/supply_pack/randomised/costumes/dresses
	ru_supply_pack_name = "комплектов официальной одежды"
	name = "Комплекты официальной одежды (платья)"

// engineering_vr.dm

/datum/supply_pack/eng/modern_shield
	ru_supply_pack_name = "модернизированного генератора щита"
	name = "Генератор модернизированного щита"

/datum/supply_pack/eng/thermoregulator
	ru_supply_pack_name = "терморегулятора"
	name = "Терморегулятор"

/datum/supply_pack/eng/algae
	ru_supply_pack_name = "листов водорослей"
	name = "Листовые водоросли (10 шт.)"

/datum/supply_pack/eng/engine/tesla_gen
	ru_supply_pack_name = "генератора шара теслы"
	name = "Генератор шара теслы"

/datum/supply_pack/eng/inducer
	ru_supply_pack_name = "индукторов"
	name = "Индукторы"

// engineering.dm

/datum/supply_pack/eng
	group = "Техобслуживание"

/datum/supply_pack/eng/lightbulbs
	ru_supply_pack_name = "запасных лампочек"
	name = "Запасные лампочки"

/datum/supply_pack/eng/smescoil
	ru_supply_pack_name = "сверхпроводниковой магнитной катушки"
	name = "Сверхпроводниковая магнитная катушка"

/datum/supply_pack/eng/smescoil/super_capacity
	ru_supply_pack_name = "сверхпроводниковой емкостной катушки"
	name = "Сверхпроводниковая емкостная катушка"

/datum/supply_pack/eng/smescoil/super_io
	ru_supply_pack_name = "сверхпроводниковой индуктивной катушки"
	name = "Сверхпроводниковая индуктивная катушка"

/datum/supply_pack/eng/shield_capacitor
	ru_supply_pack_name = "конденсатора щита"
	name = "Конденсатор щита"

/datum/supply_pack/eng/shield_capacitor/advanced
	ru_supply_pack_name = "усовершенствованного конденсатора щита"
	name = "Конденсатор щита (усовершенствованный)"

/datum/supply_pack/eng/bubble_shield
	ru_supply_pack_name = "генератора сферообразного щита"
	name = "Генератор сферообразного щита"

/datum/supply_pack/eng/bubble_shield/advanced
	ru_supply_pack_name = "усовершенствованного генератора сферообразного щита"
	name = "Генератор сферообразного щита (усовершенствованный)"

/datum/supply_pack/eng/hull_shield
	ru_supply_pack_name = "генератора корпусного щита"
	name = "Генератор корпусного щита"

/datum/supply_pack/eng/hull_shield/advanced
	ru_supply_pack_name = "усовершенствованного генератора корпусного щита"
	name = "Генератор корпусного щита (усовершенствованный)"

/datum/supply_pack/eng/point_defense_cannon_circuit
	name = "Оборонительная турель (плата)"
	ru_supply_pack_name = "платы оборонительной турели"

/datum/supply_pack/eng/point_defense_control_circuit
	name = "Оборонительный контроллер (плата)"
	ru_supply_pack_name = "платы оборонительного контроллера"

/datum/supply_pack/eng/electrical
	name = "Набор для обслуживания электрооборудования"
	ru_supply_pack_name = "набора для обслуживания электрооборудования"

/datum/supply_pack/eng/e_welders
	name = "Электрический сварочный аппарат"
	ru_supply_pack_name = "электрического сварочного аппарата"

/datum/supply_pack/eng/mechanical
	name = "Набор для обслуживания механического оборудования"
	ru_supply_pack_name = "набора для обслуживания механического оборудования"

/datum/supply_pack/eng/fueltank
	name = "Бак с топливом"
	ru_supply_pack_name = "бака с топливом"

/datum/supply_pack/eng/solar
	name = "Солнечные панели"
	ru_supply_pack_name = "комплектов солнечных панелей"

/datum/supply_pack/eng/engine
	name = "Эмиттеры"
	ru_supply_pack_name = "эмиттеров"

/datum/supply_pack/eng/engine/field_gen
	name = "Генераторы поля"
	ru_supply_pack_name = "генераторов поля"

/datum/supply_pack/eng/engine/sing_gen
	name = "Генератор сингулярности"
	ru_supply_pack_name = "генератора сингулярности"

/datum/supply_pack/eng/engine/collector
	name = "Коллекторы"
	ru_supply_pack_name = "коллекторов"

/datum/supply_pack/eng/engine/PA
	name = "Ускоритель частиц"
	ru_supply_pack_name = "ускорителя частиц"

/datum/supply_pack/eng/shield_gen
	name = "Генератор сферообразного щита (плата)"
	ru_supply_pack_name = "платы генератора сферообразного щита"

/datum/supply_pack/eng/shield_gen_ex
	name = "Генератор корпусного щита (плата)"
	ru_supply_pack_name = "платы генератора корпусного щита"

/datum/supply_pack/eng/shield_cap
	name = "Конденсатор щита (плата)"
	ru_supply_pack_name = "платы конденсатора щита"

/datum/supply_pack/eng/smbig
	name = "Ядро суперматерии"
	ru_supply_pack_name = "ядра суперматерии (ОСТОРОЖНО!)"

/datum/supply_pack/eng/teg
	name = "Термоэлектрогенератор Мk. 1"
	ru_supply_pack_name = "термоэлектрогенератора Мk. 1"

/datum/supply_pack/eng/circulator
	name = "Газовый циркулятор"
	ru_supply_pack_name = "газового циркулятора"

/datum/supply_pack/eng/radsuit
	name = "Антирадиационные костюмы (гуманоид)"
	ru_supply_pack_name = "антирадиационных костюмов"

/datum/supply_pack/eng/radsuitteshari
	name = "Антирадиационные костюмы (тешари)"
	ru_supply_pack_name = "антирадиационных костюмов тешари"

/datum/supply_pack/eng/pacman_parts
	name = "Портативный генератор серии P.A.C.M.A.N."
	ru_supply_pack_name = "комплектации портативного генератора P.A.C.M.A.N."

/datum/supply_pack/eng/super_pacman_parts
	name = "Портативный генератор серии Super P.A.C.M.A.N."
	ru_supply_pack_name = "комплектации портативного генератора Super P.A.C.M.A.N."

/datum/supply_pack/eng/fusion_core
	name = "R-UST Mk. 8 — Токамак"
	ru_supply_pack_name = "комплектации токамака R-UST Mk. 8"

/datum/supply_pack/eng/fusion_fuel_injector
	name = "R-UST Mk. 8 — Инжекторная система подачи"
	ru_supply_pack_name = "комплектации инжекторной системы R-UST Mk. 8"

/datum/supply_pack/eng/gyrotron
	name = "Гиротрон"
	ru_supply_pack_name = "гиротрона"

/datum/supply_pack/eng/fusion_fuel_compressor
	name = "Компрессор топлива ядерного синтеза (плата)"
	ru_supply_pack_name = "компрессора топлива синтеза"

/datum/supply_pack/eng/tritium
	name = "Тритий"
	ru_supply_pack_name = "трития"

// hospitality_vr.dm

/datum/supply_pack/randomised/hospitality/burgers_vr
	ru_supply_pack_name = "бургеров"
	name = "Бургеры"

/*
/datum/supply_pack/randomised/hospitality/bakery_vr
	ru_supply_pack_name = "выпечки"
	name = "Выпечка"

/datum/supply_pack/randomised/hospitality/cakes_vr
	ru_supply_pack_name = "тортов"
	name = "Торты"

/datum/supply_pack/randomised/hospitality/mexican_vr
	ru_supply_pack_name = "доставки мексиканской кухни"
	name = "Мексиканская кухня"
*/
/datum/supply_pack/randomised/hospitality/asian_vr
	ru_supply_pack_name = "доставки китайской кухни"
	name = "Китайская кухня"

// hospitality.dm

/datum/supply_pack/hospitality
	group = "Гостеприимство"

/datum/supply_pack/hospitality/party
	ru_supply_pack_name = "набора для вечеринок"
	name = "Набор для вечеринки"

/datum/supply_pack/hospitality/barsupplies
	ru_supply_pack_name = "набора для бара"
	name = "Набор для бара"
	
/datum/supply_pack/hospitality/cookingoil
	ru_supply_pack_name = "бака растительного масла"
	name = "Бак растительного масла"

/datum/supply_pack/hospitality/pizza
	ru_supply_pack_name = "пиццы"
	name = "Набор случайной пиццы"

/datum/supply_pack/hospitality/gifts
	ru_supply_pack_name = "подарков"
	name = "Набор подарков"

/datum/supply_pack/randomised/hospitality/
	group = "Гостеприимство"

// hydroponics_vr.dm

/datum/supply_pack/hydro/birds
	name = "Ящик птиц"
	ru_supply_pack_name = "птиц"

/datum/supply_pack/hydro/sobaka
	name = "Ящик собак"
	ru_supply_pack_name = "собак"

/datum/supply_pack/hydro/saru
	name = "Ящик сару"
	ru_supply_pack_name = "сару"

/datum/supply_pack/hydro/sparra
	name = "Ящик спарр"
	ru_supply_pack_name = "спарр"

/datum/supply_pack/hydro/wolpin
	name = "Ящик вольпинов"
	ru_supply_pack_name = "вольпинов"

/datum/supply_pack/hydro/fennec
	name = "Ящик феньков"
	ru_supply_pack_name = "феньков"

/datum/supply_pack/hydro/fish
	name = "Рыбный ассортимент"
	ru_supply_pack_name = "рыбы"

// hydroponics.dm

/datum/supply_pack/hydro
	group = "Гидропоника"

/datum/supply_pack/hydro/monkey
	name = "Ящик обезьян"
	ru_supply_pack_name = "обезьян"

/datum/supply_pack/hydro/farwa
	name = "Ящик фарв"
	ru_supply_pack_name = "фарв"

/datum/supply_pack/hydro/neara
	name = "Ящик неер"
	ru_supply_pack_name = "неер"

/datum/supply_pack/hydro/stok
	name = "Ящик сток"
	ru_supply_pack_name = "сток"

/datum/supply_pack/hydro/lisa
	name = "Ящик с корги"
	ru_supply_pack_name = "корги"

/datum/supply_pack/hydro/cat
	name = "Ящик с кошкой"
	ru_supply_pack_name = "кошки"

/datum/supply_pack/hydro/hydroponics
	name = "Гидропонические принадлежности"
	ru_supply_pack_name = "гидропонических принадлежностей"

/datum/supply_pack/hydro/cow
	name = "Ящик с коровой"
	ru_supply_pack_name = "коровы"

/datum/supply_pack/hydro/goat
	name = "Ящик с козой"
	ru_supply_pack_name = "козы"

/datum/supply_pack/hydro/chicken
	name = "Ящик куриц"
	ru_supply_pack_name = "куриц"

/datum/supply_pack/hydro/seeds
	name = "Семена"
	ru_supply_pack_name = "семян"

/datum/supply_pack/hydro/weedcontrol
	name = "Средства борьбы с сорняками"
	ru_supply_pack_name = "средств борьбы с сорняками"

/datum/supply_pack/hydro/watertank
	name = "Бак с водой"
	ru_supply_pack_name = "бака с водой"

/datum/supply_pack/hydro/bee_keeper
	name = "Пчеловодный комплект"
	ru_supply_pack_name = "пчеловодного комплект"

/datum/supply_pack/hydro/tray
	name = "Гидропонические ванночки"
	ru_supply_pack_name = "гидропонических ванночек"

// materials.dm

/datum/supply_pack/materials
	group = "Материалы"

/datum/supply_pack/materials/metal50
	ru_supply_pack_name = "листового металла"
	name = "50 листов металла"

/datum/supply_pack/materials/glass50
	ru_supply_pack_name = "листового стекла"
	name = "50 листов стекла"

/datum/supply_pack/materials/wood50
	ru_supply_pack_name = "деревянных досок"
	name = "50 деревянных досок"

/datum/supply_pack/materials/plastic50
	ru_supply_pack_name = "листового пластика"
	name = "50 листов пластика"

/datum/supply_pack/materials/copper50
	ru_supply_pack_name = "медных слитков"
	name = "50 слитков меди"

/datum/supply_pack/materials/cardboard_sheets
	ru_supply_pack_name = "листового картона"
	name = "50 листов картона"

/datum/supply_pack/materials/carpet
	ru_supply_pack_name = "импортного ковролина"
	name = "Импортные ковры"

/datum/supply_pack/misc/linoleum
	ru_supply_pack_name = "линолеум"
	name = "Линолеум"

// medical_vr.dm 

/datum/supply_pack/med/virologybiosuits
	name = "Средства защиты от эпидемиологических угроз"
	ru_supply_pack_name = "средств защиты от эпидемиологических угроз"

/datum/supply_pack/med/virus
	name = "Образцы вирусов"
	ru_supply_pack_name = "образцов вирусов"

/datum/supply_pack/med/compactdefib
	name = "Компактный дефибриллятор"
	ru_supply_pack_name = "компактного дефибриллятора"

// medical.dm

/datum/supply_pack/med
	group = "Медицина"

/datum/supply_pack/med/medical
	name = "Ящик лекарств"
	ru_supply_pack_name = "лекарств"

/datum/supply_pack/med/bloodpack
	name = "Мешки с кровью"
	ru_supply_pack_name = "мешков с кровью"

/datum/supply_pack/med/synthplas
	name = "Мешки с синтетической кровью"
	ru_supply_pack_name = "мешков с синтетической кровью"

/datum/supply_pack/med/bodybag
	name = "Мешки для трупов"
	ru_supply_pack_name = "мешков для трупов"

/datum/supply_pack/med/cryobag
	name = "Стазисные мешки"
	ru_supply_pack_name = "стазисных мешков"

/datum/supply_pack/med/surgery
	name = "Хирургические принадлежности"
	ru_supply_pack_name = "хирургических принадлежностей"

/datum/supply_pack/med/deathalarm
	name = "Наборы сигнализации о гибели"
	ru_supply_pack_name = "наборов сигнализации о гибели"

/datum/supply_pack/med/clotting
	name = "Набор для свёртывания ран"
	ru_supply_pack_name = "набора для свёртывания ран"

/datum/supply_pack/med/sterile
	name = "Комплект стерильной одежды"
	ru_supply_pack_name = "стерильной одежды"

/datum/supply_pack/med/extragear
	name = "Дополнительные медицинские принадлежности"
	ru_supply_pack_name = "дополнительных медицинских принадлежностей"

/datum/supply_pack/med/cmogear
	name = "Принадлежности Главврача"
	ru_supply_pack_name = "принадлежностей Главврача"

/datum/supply_pack/med/doctorgear
	name = "Принадлежности врача"
	ru_supply_pack_name = "принадлежностей врача"

/datum/supply_pack/med/chemistgear
	name = "Принадлежности химика"
	ru_supply_pack_name = "принадлежностей химика"

/datum/supply_pack/med/paramedicgear
	name = "Принадлежности парамедика"
	ru_supply_pack_name = "принадлежностей парамедика"

/datum/supply_pack/med/psychiatristgear
	name = "Принадлежности психиатра"
	ru_supply_pack_name = "принадлежностей психиатра"

/datum/supply_pack/med/medicalscrubs
	name = "Комплекты клинических униформ"
	ru_supply_pack_name = "клинических униформ"

/datum/supply_pack/med/autopsy
	name = "Набор для проведения вскрытия"
	ru_supply_pack_name = "набора для проведения вскрытия"

/datum/supply_pack/med/medicaluniforms
	name = "Комплекты медицинских униформ"
	ru_supply_pack_name = "мединицнских униформ"

/datum/supply_pack/med/medicalbiosuits
	name = "Средства защиты от биологических угроз"
	ru_supply_pack_name = "средств защиты от биологических угроз"

/datum/supply_pack/med/portablefreezers
	name = "Переносные морозильники"
	ru_supply_pack_name = "переносных морозильников"

/datum/supply_pack/med/defib
	name = "Дефибрилляторы"
	ru_supply_pack_name = "дефибрилляторов"

/datum/supply_pack/med/distillery
	name = "Химический дистиллятор"
	ru_supply_pack_name = "химического дистиллятора"

/datum/supply_pack/med/advdistillery
	name = "Химический дистиллятор (промышленный)"
	ru_supply_pack_name = "промышленного химического дистиллятора"

/datum/supply_pack/med/oxypump
	name = "Помпа кислородная"
	ru_supply_pack_name = "кислородной помпы"

/datum/supply_pack/med/anestheticpump
	name = "Помпа анестетиковая"
	ru_supply_pack_name = "анестетиковой помпы"

/datum/supply_pack/med/stablepump
	name = "Помпа стабилизирующая"
	ru_supply_pack_name = "стабилизирующей помпы"

// misc_vr.dm

/datum/supply_pack/misc/beltminer
	name = "Снаряжение для астероидной рудодобычи"
	ru_supply_pack_name = "снаряжения для астероидной рудодобычи"

/datum/supply_pack/misc/eva_rig
	name = "ИКС для ВКД (пустой)"
	ru_supply_pack_name = "ИКС для ВКД"

/datum/supply_pack/misc/mining_rig
	name = "ИКС промышленный (пустой)"
	ru_supply_pack_name = "промышленного ИКС"

/datum/supply_pack/misc/medical_rig
	name = "ИКС медицинский (пустой)"
	ru_supply_pack_name = "медицинского ИКС"

/datum/supply_pack/misc/security_rig
	name = "ИКС службы безопасности (пустой)"
	ru_supply_pack_name = "ИКС службы безопасности"

/datum/supply_pack/misc/science_rig
	name = "ИКС научный (пустой)"
	ru_supply_pack_name = "научного ИКС"

/datum/supply_pack/misc/ce_rig
	name = "ИКС инженерный (пустой)"
	ru_supply_pack_name = "инженерного ИКС"

/datum/supply_pack/misc/jetpack
	name = "Реактивный ранец (пустой)"
	ru_supply_pack_name = "реактивного ранца"

/datum/supply_pack/randomised/misc/explorer_shield
	name = "Экспедиционный щит"
	ru_supply_pack_name = "экспедиционного щита"

// misc.dm

/datum/supply_pack/misc
	group = "Другое"

/datum/supply_pack/randomised/misc
	group = "Другое"

/datum/supply_pack/randomised/misc/card_packs
	name = "Коллекционные карточки"
	ru_supply_pack_name = "коллекционных карточек"

/datum/supply_pack/randomised/misc/dnd
	name = "Миниатюрные фигурки"
	ru_supply_pack_name = "миниатюрных фигурок"

/datum/supply_pack/randomised/misc/plushies
	name = "Плюшевые игрушки"
	ru_supply_pack_name = "плюшевых игрушек"

/datum/supply_pack/misc/eftpos
	name = "Сканер ОТНМП"
	ru_supply_pack_name = "сканера ОТНМП"

/datum/supply_pack/misc/chaplaingear
	name = "Принадлежности капеллана"
	ru_supply_pack_name = "принадлежностей капеллана"

/datum/supply_pack/misc/hoverpod
	name = "Ховерпод"
	ru_supply_pack_name = "ховерпода"

/datum/supply_pack/randomised/misc/webbing
	name = "Лямочные жилеты"
	ru_supply_pack_name = "лямочных жилетов"

/datum/supply_pack/misc/holoplant
	name = "Голо-растение"
	ru_supply_pack_name = "голо-растения"

/datum/supply_pack/misc/glucose_hypos
	name = "Гипоинъекторы с глюкозой"
	ru_supply_pack_name = "гипоинъекторов с глюкозой"

/datum/supply_pack/misc/mre_rations
	num_contained = 6
	name = "Рацион — Сухпаёк"
	ru_supply_pack_name = "экстренного рациона"

/datum/supply_pack/misc/paste_rations
	name = "Рацион — Жидкая Пища"
	ru_supply_pack_name = "экстренного рациона"

/datum/supply_pack/misc/medical_rations
	name = "Рацион — Вита-Паста"
	ru_supply_pack_name = "экстренного рациона"

/datum/supply_pack/misc/reagentpump
	name = "Насос"
	ru_supply_pack_name = "насоса"

// munitions_vr.dm

/datum/supply_pack/munitions/expeditionguns
	ru_supply_pack_name = "экспедиционного фазера"
	name = "Фазер экспедиционный (на предохранителе)"

// munitions_vr.dm

/datum/supply_pack/munitions
	group = "Оружие"

/datum/supply_pack/randomised/munitions
	group = "Оружие"

/*
/datum/supply_pack/munitions/weapons
	name = "Оружие - Снаряжение СБ"
	ru_supply_pack_name = "снаряжения СБ"*/

/datum/supply_pack/munitions/egunpistol
	name = "Оружие — Энергетические пистолеты"
	ru_supply_pack_name = "энергетических пистолетов"

/datum/supply_pack/munitions/flareguns
	name = "Оружие — Сигнальные огни"
	ru_supply_pack_name = "сигнальных огней"

/datum/supply_pack/munitions/eweapons
	name = "Оружие — Экспериментальное оружие"
	ru_supply_pack_name = "экспериментального оружия"

/datum/supply_pack/munitions/energyweapons
	name = "Оружие — Лазерные винтовки"
	ru_supply_pack_name = "лазерных винтовок"

/datum/supply_pack/munitions/shotgun
	name = "Оружие — Дробовики"
	ru_supply_pack_name = "дробовиков"

/* VOREStation edit -- This is a bad idea. -- So is this.
/datum/supply_pack/munitions/erifle
	name = "Weapons - Energy marksman"
	ru_supply_pack_name = "Energy marksman crate"

/datum/supply_pack/munitions/burstlaser
	name = "Weapons - Burst laser"
	ru_supply_pack_name = "Burst laser crate"
*/

/datum/supply_pack/munitions/ionweapons
	name = "Оружие — Электромагнитные винтовки"
	ru_supply_pack_name = "электромагнитного оружия"

/datum/supply_pack/munitions/ionpistols
	name = "Оружие — Электромагнитные пистолеты"
	ru_supply_pack_name = "электромагнитного оружия"

/datum/supply_pack/munitions/bsmg
	name = "Оружие — Баллистические пистолеты-пулемёты"
	ru_supply_pack_name = "баллистического оружия"

/datum/supply_pack/munitions/brifle
	name = "Оружие — Баллистические винтовки"
	ru_supply_pack_name = "баллистического оружия"

/datum/supply_pack/munitions/bolt_rifles_competitive
 	name = "Оружие — Соревновательные винтовки"
 	ru_supply_pack_name = "баллистического оружия"

/datum/supply_pack/munitions/caseless
	name = "Оружие — Безгильзовая винтовка"
	ru_supply_pack_name = "безгильзовой винтовки"

/datum/supply_pack/munitions/mrifle
	name = "Оружие — Индукционные винтовки"
	ru_supply_pack_name = "индукционного оружия"

/datum/supply_pack/munitions/mpistol
	name = "Оружие — Индукционные пистолеты"
	ru_supply_pack_name = "индукционного оружия"

/datum/supply_pack/munitions/mcarbine
	name = "Оружие — Индукционные карабины"
	ru_supply_pack_name = "индукционного оружия"

/datum/supply_pack/munitions/mshells
	name = "Оружие — Индукционные пули"
	ru_supply_pack_name = "индукционных пуль"

/datum/supply_pack/munitions/shotgunammo
	name = "Амуниция — Патроны для дробовика"
	ru_supply_pack_name = "баллистической амуниции"

/datum/supply_pack/munitions/beanbagammo
	name = "Амуниция — Травмирующие пули"
	ru_supply_pack_name = "баллистической амуниции"

/datum/supply_pack/munitions/bsmgammo
	name = "Амуниция — Летальные пули, 9 мм"
	ru_supply_pack_name = "баллистической амуниции"

/datum/supply_pack/munitions/bsmgammorubber
	name = "Амуниция — Резиновые пули, 9 мм"
	ru_supply_pack_name = "баллистической амуниции"

/datum/supply_pack/munitions/brifleammo
	name = "Амуниция — Летальные пули, 7.62 мм"
	ru_supply_pack_name = "баллистической амуниции"

/datum/supply_pack/munitions/pcellammo
	name = "Амуниция — Батарейки"
	ru_supply_pack_name = "энергетической амуниции"

// recreation_vr.dm

/* Ehhh...
/datum/supply_pack/recreation/rover
	name = "NT Humvee"
	ru_supply_pack_name = "NT Humvee Crate"
*/

/datum/supply_pack/recreation/restraints
	ru_supply_pack_name = "рекреационных средств усмирения"
	name = "Рекреационные средства усмирения"

/datum/supply_pack/recreation/wolfgirl_cosplay_crate
	ru_supply_pack_name = "комплекта косплея волкодевочки"
	name = "Комплект для косплея волкодевочки"

/datum/supply_pack/randomised/recreation/figures
	ru_supply_pack_name = "игрушечных фигурок"
	name = "Игрушечные фигурки"

/datum/supply_pack/recreation/collars
	ru_supply_pack_name = "набора ошейников"
	name = "Ошейники"

/datum/supply_pack/recreation/shiny
	ru_supply_pack_name = "набора латексной одежды"
	name = "Латексная одежда"

/datum/supply_pack/recreation/smoleworld
	ru_supply_pack_name = "набора Микрокирпичиков"
	name = "Набор строительных Микрокирпичиков"

/datum/supply_pack/recreation/smolesnackplanets
	ru_supply_pack_name = "набора планет-конфет"
	name = "Набор планет-конфет"

// recreation.dm

/datum/supply_pack/recreation
	group = "Рекреационное"

/datum/supply_pack/randomised/recreation
	group = "Рекреационное"
	access = access_security

/datum/supply_pack/recreation/foam_weapons
	ru_supply_pack_name = "пенопластового оружия"
	name = "Пенопластовое оружие"

/datum/supply_pack/recreation/lasertag
	ru_supply_pack_name = "снаряжения для лазерных салок"
	name = "Набор для игры в лазерные салки (снаряжение)"

/datum/supply_pack/recreation/artscrafts
	ru_supply_pack_name = "художественных принадлежностей"
	name = "Художественные принадлежности"

/datum/supply_pack/recreation/painters
	ru_supply_pack_name = "красящих приспособлений"
	name = "Красящие приспособления"

/datum/supply_pack/recreation/cheapbait
	ru_supply_pack_name = "дешевой наживки"
	name = "Рыбная наживка (дешёвая)"

/datum/supply_pack/randomised/recreation/cheapbait
	ru_supply_pack_name = "дорогостоящей рыбной наживки"
	name = "Рыбная наживка (дорогостоящая)"

/datum/supply_pack/recreation/ltagturrets
	ru_supply_pack_name = "турелей для лазерных салок"
	name = "Набор для игры в лазерные салки (турели)"

// robotics_vr.dm

/datum/supply_pack/robotics/mecha_gopher
	name = "Circuit Crate (\"Gopher\" APLU)"
	ru_supply_pack_name = "APLU \"Gopher\" Circuit Crate"

/datum/supply_pack/robotics/mecha_polecat
	name = "Circuit Crate (\"Polecat\" APLU)"
	ru_supply_pack_name = "APLU \"Polecat\" Circuit Crate"

/datum/supply_pack/robotics/mecha_weasel
	name = "Circuit Crate (\"Weasel\" APLU)"
	ru_supply_pack_name = "APLU \"Weasel\" Circuit Crate"

/datum/supply_pack/robotics/some_robolimbs
	name = "Basic Robolimb Blueprints"
	ru_supply_pack_name = "Basic Robolimb Blueprint Crate"

/datum/supply_pack/robotics/all_robolimbs
	name = "Advanced Robolimb Blueprints"
	ru_supply_pack_name = "Advanced Robolimb Blueprint Crate"

// robotics.dm

/datum/supply_pack/robotics
	group = "Робототехника"

/datum/supply_pack/randomised/robotics
	group = "Робототехника"
	access = access_robotics

/datum/supply_pack/robotics/robotics_assembly
	name = "Robotics assembly crate"
	ru_supply_pack_name = "Robotics assembly"

/*/datum/supply_pack/robotics/robolimbs_basic
	name = "Basic robolimb blueprints"
	ru_supply_pack_name = "Robolimb blueprints (basic)"

/datum/supply_pack/robotics/robolimbs_adv
	name = "All robolimb blueprints
	ru_supply_pack_name = "Robolimb blueprints (adv)"
*/

/datum/supply_pack/robotics/robolimbs/morpheus
	name = "Morpheus robolimb blueprints"
	ru_supply_pack_name = "Robolimb blueprints (Morpheus)"

/datum/supply_pack/robotics/robolimbs/cybersolutions
	name = "Cyber Solutions robolimb blueprints"
	ru_supply_pack_name = "Robolimb blueprints (Cyber Solutions)"

/datum/supply_pack/robotics/robolimbs/xion
	name = "Xion robolimb blueprints"
	ru_supply_pack_name = "Robolimb blueprints (Xion)"

/datum/supply_pack/robotics/robolimbs/grayson
	name = "Grayson robolimb blueprints"
	ru_supply_pack_name = "Robolimb blueprints (Grayson)"

/datum/supply_pack/robotics/robolimbs/hephaestus
	name = "Hephaestus robolimb blueprints"
	ru_supply_pack_name = "Robolimb blueprints (Hephaestus)"

/datum/supply_pack/robotics/robolimbs/wardtakahashi
	name = "Ward-Takahashi robolimb blueprints"
	ru_supply_pack_name = "Robolimb blueprints (Ward-Takahashi)"

/datum/supply_pack/robotics/robolimbs/zenghu
	name = "Zeng Hu robolimb blueprints"
	ru_supply_pack_name = "Robolimb blueprints (Zeng Hu)"

/datum/supply_pack/robotics/robolimbs/bishop
	name = "Bishop robolimb blueprints"
	ru_supply_pack_name = "Robolimb blueprints (Bishop)"

/datum/supply_pack/robotics/robolimbs/cenilimicybernetics
	name = "Cenilimi Cybernetics robolimb blueprints"
	ru_supply_pack_name = "Robolimb blueprints (Cenilimi Cybernetics)"

/datum/supply_pack/robotics/mecha_ripley
	name = "Circuit Crate (\"Ripley\" APLU)"
	ru_supply_pack_name = "APLU \"Ripley\" Circuit Crate"

/datum/supply_pack/robotics/mecha_odysseus
	name = "Circuit Crate (\"Odysseus\")"
	ru_supply_pack_name = "\"Odysseus\" Circuit Crate"

/datum/supply_pack/randomised/robotics/exosuit_mod
	name = "Random APLU modkit"
	ru_supply_pack_name = "heavy crate"

/datum/supply_pack/randomised/robotics/exosuit_mod/durand
	name = "Random Durand exosuit modkit"

/datum/supply_pack/randomised/robotics/exosuit_mod/gygax
	name = "Random Gygax exosuit modkit"

/datum/supply_pack/robotics/jumper_cables
	name = "Jumper kit crate"
	ru_supply_pack_name = "Jumper kit crate"

/datum/supply_pack/robotics/restrainingbolt
	name = "Restraining bolt crate"
	ru_supply_pack_name = "Restraining bolt crate"

/datum/supply_pack/robotics/bike
	name = "Spacebike Crate"
	ru_supply_pack_name = "Spacebike Crate"

/datum/supply_pack/robotics/quadbike
	name = "ATV Crate"
	ru_supply_pack_name = "ATV Crate"

/datum/supply_pack/robotics/quadtrailer
	name = "ATV Trailer Crate"
	ru_supply_pack_name = "ATV Trailer Crate"

// science_vr.dm

/*
/datum/supply_pack/sci/dune_buggy
	name = "Exploration Dune Buggy"
	ru_supply_pack_name = "Exploration Dune Buggy Crate"
*/

/datum/supply_pack/sci/pred
	name = "Dangerous Predator crate"
	ru_supply_pack_name = "Dangerous Predator crate"

/datum/supply_pack/sci/pred_doom
	name = "EXTREMELY Dangerous Predator crate"
	ru_supply_pack_name = "EXTREMELY Dangerous Predator crate"

/*
/datum/supply_pack/sci/otie
	name = "VARMAcorp adoptable reject (Dangerous!)"
	ru_supply_pack_name = "VARMAcorp adoptable reject (Dangerous!)"

/datum/supply_pack/sci/phoronotie
	name = "VARMAcorp adaptive beta subject (Experimental)"
	ru_supply_pack_name = "VARMAcorp adaptive beta subject (Experimental)"
*/

// science_vr.dm

/datum/supply_pack/sci
	group = "Наука"

/datum/supply_pack/sci/coolanttank
	name = "Coolant tank crate"
	ru_supply_pack_name = "coolant tank crate"

/datum/supply_pack/sci/phoron
	name = "Phoron research crate"
	ru_supply_pack_name = "Phoron assembly crate"

/datum/supply_pack/sci/exoticseeds
	name = "Exotic seeds crate"
	ru_supply_pack_name = "Exotic Seeds crate"

/datum/supply_pack/sci/integrated_circuit_printer
	name = "Integrated circuit printer"
	ru_supply_pack_name = "Integrated circuit crate"

/datum/supply_pack/sci/integrated_circuit_printer_upgrade
	name = "Integrated circuit printer upgrade - advanced designs"
	ru_supply_pack_name = "Integrated circuit crate"

/datum/supply_pack/sci/xenoarch
	name = "Xenoarchaeology Tech crate"
	ru_supply_pack_name = "Xenoarchaeology Tech crate"

// security_vr.dm

/*/datum/supply_pack/security/guardbeast //VORESTATION AI TEMPORARY REMOVAL
	name = "VARMAcorp autoNOMous security solution"
	ru_supply_pack_name = "VARMAcorp autoNOMous security solution crate"

/datum/supply_pack/security/guardmutant
	name = "VARMAcorp autoNOMous security solution for hostile environments"
	ru_supply_pack_name = "VARMAcorp autoNOMous security phoron-proof solution crate"
*/

/datum/supply_pack/security/trackingimplant
	name = "Implants - Tracking"
	ru_supply_pack_name = "Tracking implants"

/datum/supply_pack/security/chemicalimplant
	name = "Implants - Chemical"
	ru_supply_pack_name = "Chemical implants"

// security.dm

/datum/supply_pack/security
	group = "Безопасность"
	access = access_security

/datum/supply_pack/randomised/security
	group = "Безопасность"
	access = access_security

/datum/supply_pack/randomised/security/armor
	name = "Armor - Security armor"
	ru_supply_pack_name = "Armor crate"

/datum/supply_pack/security/carriersblack
	name = "Armor - Black modular armor"
	ru_supply_pack_name = "Plate Carrier crate"

/datum/supply_pack/security/carriersblue
	name = "Armor - Blue modular armor"
	ru_supply_pack_name = "Plate Carrier crate"

/datum/supply_pack/security/carriersgreen
	name = "Armor - Green modular armor"
	ru_supply_pack_name = "Plate Carrier crate"

/datum/supply_pack/security/carriersnavy
	name = "Armor - Navy modular armor"
	ru_supply_pack_name = "Plate Carrier crate"

/datum/supply_pack/security/carrierstan
	name = "Armor - Tan modular armor"
	ru_supply_pack_name = "Plate Carrier crate"

/datum/supply_pack/security/armorplate
	name = "Armor - Security light armor plate"
	ru_supply_pack_name = "Armor plate crate"

/datum/supply_pack/security/armorplatestab
	name = "Armor - Security stab armor plate"
	ru_supply_pack_name = "Armor plate crate"

/datum/supply_pack/security/armorplatemedium
	name = "Armor - Security armor plate"
	ru_supply_pack_name = "Armor plate crate"

/datum/supply_pack/security/armorplatetac
	name = "Armor - Security medium armor plate"
	ru_supply_pack_name = "Armor plate crate"

/datum/supply_pack/randomised/security/carriers
	name = "Armor - Surplus plate carriers"
	ru_supply_pack_name = "Plate Carrier crate"

/datum/supply_pack/security/carriertags
	name = "Armor - Plate carrier tags"
	ru_supply_pack_name = "Plate Carrier crate"

/datum/supply_pack/security/helmcovers
	name = "Armor - Helmet covers"
	ru_supply_pack_name = "Helmet Covers crate"

/datum/supply_pack/randomised/security/armorplates
	name = "Armor - Surplus security armor plates"
	ru_supply_pack_name = "Armor plate crate"

/datum/supply_pack/randomised/security/carrierarms
	name = "Armor - Surplus security armguard attachments"
	ru_supply_pack_name = "Armor plate crate"

/datum/supply_pack/randomised/security/carrierlegs
	name = "Armor - Surplus security legguard attachments"
	ru_supply_pack_name = "Armor plate crate"

/datum/supply_pack/randomised/security/carrierbags
	name = "Armor - Surplus security pouch attachments"
	ru_supply_pack_name = "Armor plate crate"

/datum/supply_pack/security/riot_gear
	name = "Gear - Riot"
	ru_supply_pack_name = "Riot gear crate"

/datum/supply_pack/security/riot_armor
	name = "Armor - Riot"
	ru_supply_pack_name = "Riot armor crate"

/datum/supply_pack/security/riot_plates
	name = "Armor - Riot plates"
	ru_supply_pack_name = "Riot armor crate"

/datum/supply_pack/security/ablative_armor
	name = "Armor - Ablative"
	ru_supply_pack_name = "Ablative armor crate"

/datum/supply_pack/security/ablative_plates
	name = "Armor - Ablative plates"
	ru_supply_pack_name = "Ablative armor crate"

/datum/supply_pack/security/bullet_resistant_armor
	name = "Armor - Ballistic"
	ru_supply_pack_name = "Ballistic armor crate"

/*
/datum/supply_pack/security/bullet_resistant_plates
	name = "Armor - Ballistic plates"
	ru_supply_pack_name = "Ballistic armor crate"

/datum/supply_pack/security/combat_armor
	name = "Armor - Combat"
	ru_supply_pack_name = "Combat armor crate"

/datum/supply_pack/security/tactical
	name = "Armor - Tactical"
	ru_supply_pack_name = "Tactical armor crate"
*/

/datum/supply_pack/security/flexitac
	name = "Armor - Tactical Light"
	ru_supply_pack_name = "Tactical Light armor crate"

/datum/supply_pack/security/securitybarriers
	name = "Misc - Security Barriers"
	ru_supply_pack_name = "Security barrier crate"

/datum/supply_pack/security/securityshieldgen
	name = "Misc - Wall shield generators"
	ru_supply_pack_name = "Wall shield generators crate"

/datum/supply_pack/randomised/security/holster
	name = "Gear - Holsters"
	ru_supply_pack_name = "Holster crate"

/datum/supply_pack/security/extragear
	name = "Gear - Security surplus equipment"
	ru_supply_pack_name = "Security surplus equipment"

/datum/supply_pack/security/detectivegear
	name = "Forensic - Investigation equipment"
	ru_supply_pack_name = "Forensic equipment"

/datum/supply_pack/security/detectivescan
	name = "Forensic - Scanning Equipment"
	ru_supply_pack_name = "Forensic equipment"

/datum/supply_pack/security/detectiveclothes
	name = "Forensic - Investigation apparel"
	ru_supply_pack_name = "Investigation clothing"

/datum/supply_pack/security/officergear
	name = "Gear - Officer equipment"
	ru_supply_pack_name = "Officer equipment"

/datum/supply_pack/security/wardengear
	name = "Gear - Warden equipment"
	ru_supply_pack_name = "Warden equipment"

/datum/supply_pack/security/headofsecgear
	name = "Gear - Head of security equipment"
	ru_supply_pack_name = "Head of security equipment"

/datum/supply_pack/security/securityclothing
	name = "Misc - Security uniform red"
	ru_supply_pack_name = "Security uniform crate"

/datum/supply_pack/security/navybluesecurityclothing
	name = "Misc - Security uniform navy blue"
	ru_supply_pack_name = "Navy blue security uniform crate"

/datum/supply_pack/security/corporatesecurityclothing
	name = "Misc - Security uniform corporate"
	ru_supply_pack_name = "Corporate security uniform crate"

/datum/supply_pack/security/biosuit
	name = "Gear - Security biohazard gear"
	ru_supply_pack_name = "Security biohazard gear"

/datum/supply_pack/security/posters
	name = "Gear - Morale Posters"
	ru_supply_pack_name = "Morale Posters"

// supply_vr.dm

/datum/supply_pack/supply/foodcubes
	ru_supply_pack_name = "экстренного рациона"
	name = "Экстренный рацион в кубиках"

// supply_vr.dm

/datum/supply_pack/supply
	group = "Снабжение"

/datum/supply_pack/supply/food
	name = "Кухонные принадлежности"
	ru_supply_pack_name = "еды"

/datum/supply_pack/supply/toner
	name = "Картриджи с чернилами"
	ru_supply_pack_name = "картриджей с чернилами"

/datum/supply_pack/supply/janitor
	name = "Инвентарь уборщика"
	ru_supply_pack_name = "принадлежностей уборщика"

/datum/supply_pack/supply/shipping
	name = "Поставочные принадлежности"
	ru_supply_pack_name = "поставочных принадлежностей"

/datum/supply_pack/supply/bureaucracy
	name = "Канцелярские принадлежности"
	ru_supply_pack_name = "канцелярских принадлежностей"

/datum/supply_pack/supply/sticky_notes
	name = "Канцелярские стикеры (50 шт.)"
	ru_supply_pack_name = "канцелярских стикеров"

/datum/supply_pack/supply/spare_pda
	name = "Запасные КПК"
	ru_supply_pack_name = "запасных КПК"

/datum/supply_pack/supply/minergear
	name = "Принадлежности шахтёра"
	ru_supply_pack_name = "шахтёрских принадлежностей"

/*
/datum/supply_pack/supply/mule
	name = "Mulebot Crate"
	ru_supply_pack_name = "Mulebot Crate"
*/

/datum/supply_pack/supply/cargotrain
	name = "Поезд снабжения — Тягач"
	ru_supply_pack_name = "поезда снабжения"

/datum/supply_pack/supply/cargotrailer
	name = "Поезд снабжения — Вагон"
	ru_supply_pack_name = "поезда снабжения"

// voidsuits_vr.dm

/datum/supply_pack/voidsuits/explorer
	ru_supply_pack_name = "скафандров исследовательского отдела"
	name = "Скафандры исследовательского отдела"

/datum/supply_pack/voidsuits/pilot
	ru_supply_pack_name = "скафандра пилота"
	name = "Скафандр пилота"

// voidsuits.dm

/datum/supply_pack/voidsuits
	group = "Скафандры"

/datum/supply_pack/voidsuits/atmos
	name = "Atmospheric voidsuits"
	ru_supply_pack_name = "Atmospheric voidsuit crate"

/datum/supply_pack/voidsuits/atmos/alt
	name = "Heavy Duty Atmospheric voidsuits"
	ru_supply_pack_name = "Heavy Duty Atmospheric voidsuit crate"

/datum/supply_pack/voidsuits/engineering
	name = "Engineering voidsuits"
	ru_supply_pack_name = "Engineering voidsuit crate"

/datum/supply_pack/voidsuits/engineering/construction
	name = "Engineering Construction voidsuits"
	ru_supply_pack_name = "Engineering Construction voidsuit crate"

/datum/supply_pack/voidsuits/engineering/hazmat
	name = "Engineering Hazmat voidsuits"
	ru_supply_pack_name = "Engineering Hazmat voidsuit crate"

/datum/supply_pack/voidsuits/engineering/alt
	name = "Reinforced Engineering voidsuits"
	ru_supply_pack_name = "Reinforced Engineering voidsuit crate"

/datum/supply_pack/voidsuits/medical
	name = "Medical voidsuits"
	ru_supply_pack_name = "Medical voidsuit crate"

/datum/supply_pack/voidsuits/medical/emt
	name = "Medical EMT voidsuits"
	ru_supply_pack_name = "Medical EMT voidsuit crate"

/datum/supply_pack/voidsuits/medical/bio
	name = "Medical Biohazard voidsuits"
	ru_supply_pack_name = "Medical Biohazard voidsuit crate"

/datum/supply_pack/voidsuits/medical/alt
	name = "Vey-Med Autoadaptive voidsuits (humanoid)"
	ru_supply_pack_name = "Vey-Med Autoadaptive voidsuit (humanoid) crate"

/datum/supply_pack/voidsuits/medical/alt/tesh
	name = "Vey-Med Autoadaptive voidsuits (teshari)"
	ru_supply_pack_name = "Vey-Med Autoadaptive voidsuit (teshari) crate"

/datum/supply_pack/voidsuits/security
	name = "Security voidsuits"
	ru_supply_pack_name = "Security voidsuit crate"

/datum/supply_pack/voidsuits/security/crowd
	name = "Security Crowd Control voidsuits"
	ru_supply_pack_name = "Security Crowd Control voidsuit crate"

/datum/supply_pack/voidsuits/security/alt
	name = "Security EVA voidsuits"
	ru_supply_pack_name = "Security EVA voidsuit crate"

/datum/supply_pack/voidsuits/supply
	name = "Mining voidsuits"
	ru_supply_pack_name = "Mining voidsuit crate"

/datum/supply_pack/voidsuits/supply/alt
	name = "Frontier Mining voidsuits"
	ru_supply_pack_name = "Frontier Mining voidsuit crate"

/datum/supply_pack/voidsuits/zaddat
	name = "Покров заддат"
	ru_supply_pack_name = "покрова заддат"