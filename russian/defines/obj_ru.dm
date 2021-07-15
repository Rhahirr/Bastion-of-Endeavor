/obj/item/weapon/phone/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "телефон"
	ru_cases["gcase"] = "телефона"
	ru_cases["dcase"] = "телефону"
	ru_cases["acase"] = "телефон"
	ru_cases["icase"] = "телефоном"
	ru_cases["pcase"] = "телефоне"
	name = "Красный телефон"
	desc = "В случае беды..."
	//attack_verb = list("called", "rang")

/obj/item/weapon/rsp/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "Мгновенный Раздатчик Семян"
	ru_cases["gcase"] = "Мгновенного Раздатчика Семян"
	ru_cases["dcase"] = "Мгновенному Раздатчику Семян"
	ru_cases["acase"] = "Мгновенный Раздатчик Семян"
	ru_cases["icase"] = "Мгновенным Раздатчиком Семян"
	ru_cases["pcase"] = "Мгновенном Раздатчике Семян"
	name = "Мгновенный Раздатчик Семян (МРС)"
	desc = "Приспособление для мгновенной посадки семян."

/obj/item/weapon/soap/New()
	..()
	ru_cases["rugender"] = "neuter"
	ru_cases["ncase"] = "мыло"
	ru_cases["gcase"] = "мыла"
	ru_cases["dcase"] = "мылу"
	ru_cases["acase"] = "мыло"
	ru_cases["icase"] = "мылом"
	ru_cases["pcase"] = "мыле"
	name = "Мыло"
	desc = "Дешёвое мыло без запаха."

/obj/item/weapon/soap/nanotrasen
	desc = "Кусок мыла бренда NanoTrasen. Пахнет фороном."

/obj/item/weapon/soap/deluxe/New()
	desc = "Качественное мыло бренда Waffle Co. Пахнет [pick("лавандой", "ванилью", "клубникой", "шоколадом" ,"космосом")]."
	..()

/obj/item/weapon/soap/syndie
	desc = "Подозрительное мыло. Источает запах страха."

/obj/item/weapon/bikehorn/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "велосипедный клаксон"
	ru_cases["gcase"] = "велосипедного клаксона"
	ru_cases["dcase"] = "велосипедному клаксону"
	ru_cases["acase"] = "велосипедный клаксон"
	ru_cases["icase"] = "велосипедным клаксоном"
	ru_cases["pcase"] = "велосипедном клаксоне"
	name = "Велосипедный клаксон"
	desc = "Гудок от велосипеда."
	//attack_verb = list("HONKED")

/obj/item/weapon/c_tube/New()
	..()
	ru_cases["rugender"] = "female"
	ru_cases["ncase"] = "картонная трубка"
	ru_cases["gcase"] = "картонной трубки"
	ru_cases["dcase"] = "картонной трубке"
	ru_cases["acase"] = "картонную трубку"
	ru_cases["icase"] = "картонной трубкой"
	ru_cases["pcase"] = "картонной трубке"
	name = "Картонная трубка"
	desc = "Трубка из... картона."

/obj/item/weapon/disk/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "диск"
	ru_cases["gcase"] = "диска"
	ru_cases["dcase"] = "диску"
	ru_cases["acase"] = "диск"
	ru_cases["icase"] = "диском"
	ru_cases["pcase"] = "диске"
	name = "Диск"

/obj/item/weapon/disk/nuclear/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "диск ядерной идентификации"
	ru_cases["gcase"] = "диска ядерной идентификации"
	ru_cases["dcase"] = "диску ядерной идентификации"
	ru_cases["acase"] = "диск ядерной идентификации"
	ru_cases["icase"] = "диском ядерной идентификации"
	ru_cases["pcase"] = "диске ядерной идентификации"
	name = "Диск ядерной идентификации"
	desc = "Это стоит приберечь."

/* Uhhh it stayed unimplemented for the last 9 years it seems?
/obj/item/weapon/game_kit
	name = "Gaming Kit"
*/

/obj/item/weapon/gift/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "подарок"
	ru_cases["gcase"] = "подарка"
	ru_cases["dcase"] = "подарку"
	ru_cases["acase"] = "подарок"
	ru_cases["icase"] = "подарком"
	ru_cases["pcase"] = "подарке"
	name = "Подарок"
	desc = "Что-то обёрнутое."

/*/obj/item/weapon/syndicate_uplink
	name = "station bounced radio"
	desc = "Remain silent about this..."
*/

/obj/item/weapon/SWF_uplink/New()
	..()
	ru_cases["rugender"] = "neuter"
	ru_cases["ncase"] = "станционное радио"
	ru_cases["gcase"] = "станционного радио"
	ru_cases["dcase"] = "станционному радио"
	ru_cases["acase"] = "станционное радио"
	ru_cases["icase"] = "станционным радио"
	ru_cases["pcase"] = "станционном радио"
	name = "Станционное радио"
	desc = "Используется для связи, видимо."

/obj/item/weapon/staff/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "посох волшебника"
	ru_cases["gcase"] = "посоха волшебника"
	ru_cases["dcase"] = "посоху волшебника"
	ru_cases["acase"] = "посох волшебника"
	ru_cases["icase"] = "посохом волшебника"
	ru_cases["pcase"] = "посохе волшебника"
	name = "Посох волшебника"
	desc = "Якобы посох, используемый волшебником."
	//attack_verb = list("bludgeoned", "whacked", "disciplined")

/obj/item/weapon/staff/broom/New()
	..()
	ru_cases["rugender"] = "female"
	ru_cases["ncase"] = "метла"
	ru_cases["gcase"] = "метлы"
	ru_cases["dcase"] = "метле"
	ru_cases["acase"] = "метлу"
	ru_cases["icase"] = "метлой"
	ru_cases["pcase"] = "метле"
	name = "Метла"
	desc = "Используется для подметания, а также ночных полётов со зловещим смехом. Чёрный кот в комплект не входит."

/obj/item/weapon/staff/gentcane/New()
	..()
	ru_cases["rugender"] = "female"
	ru_cases["ncase"] = "трость джентльмена"
	ru_cases["gcase"] = "трости джентльмена"
	ru_cases["dcase"] = "трости джентльмена"
	ru_cases["acase"] = "трость джентльмена"
	ru_cases["icase"] = "тростью джентльмена"
	ru_cases["pcase"] = "трости джентльмена"
	name = "Трость джентльмена"
	desc = "Трость из чёрного дерева с наконечником из слоновой кости."

/obj/item/weapon/staff/stick/New()
	..()
	ru_cases["rugender"] = "female"
	ru_cases["ncase"] = "палка"
	ru_cases["gcase"] = "палки"
	ru_cases["dcase"] = "палке"
	ru_cases["acase"] = "палку"
	ru_cases["icase"] = "палкой"
	ru_cases["pcase"] = "палке"
	name = "Палка"
	desc = "Замечательное приспособление для похищения чужих напитков в баре."

/obj/item/weapon/module/card_reader/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "картридерный модуль"
	ru_cases["gcase"] = "картридерного модуля"
	ru_cases["dcase"] = "картридерному модулю"
	ru_cases["acase"] = "картридерный модуль"
	ru_cases["icase"] = "картридерным модулем"
	ru_cases["pcase"] = "картридерном модуле"
	name = "Картридерный модуль"
	desc = "Электронный модуль для чтения данных ID-карт."

/obj/item/weapon/module/power_control/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "модуль регулирования мощности"
	ru_cases["gcase"] = "модуля регулирования мощности"
	ru_cases["dcase"] = "модулю регулирования мощности"
	ru_cases["acase"] = "модуль регулирования мощности"
	ru_cases["icase"] = "модулем регулирования мощности"
	ru_cases["pcase"] = "модуле регулирования мощности"
	name = "Модуль регулирования мощности"
	desc = "Переключающая микросхема для регулирования мощности."

/obj/item/weapon/module/id_auth/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "модуль ID-идентификации"
	ru_cases["gcase"] = "модуля ID-идентификации"
	ru_cases["dcase"] = "модулю ID-идентификации"
	ru_cases["acase"] = "модуль ID-идентификации"
	ru_cases["icase"] = "модулем ID-идентификации"
	ru_cases["pcase"] = "модуле ID-идентификации"
	name = "Модуль ID-идентификации"
	desc = "Модуль для защищённой идентификации ID-карт."

/obj/item/weapon/module/cell_power/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "модуль регулятора батареи"
	ru_cases["gcase"] = "модуля регулятора батареи"
	ru_cases["dcase"] = "модулю регулятора батареи"
	ru_cases["acase"] = "модуль регулятора батареи"
	ru_cases["icase"] = "модулем регулятора батареи"
	ru_cases["pcase"] = "модуле регулятора батареи"
	name = "Модуль регулятора батареи"
	desc = "Конвертер и регулятор, позволяющий использование батареек."

/obj/item/weapon/module/cell_power/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "модуль зарядки батареек"
	ru_cases["gcase"] = "модуля зарядки батареек"
	ru_cases["dcase"] = "модулю зарядки батареек"
	ru_cases["acase"] = "модуль зарядки батареек"
	ru_cases["icase"] = "модулем зарядки батареек"
	ru_cases["pcase"] = "модуле зарядки батареек"
	name = "Модуль зарядки батареек"
	desc = "Микросхемы, поволяющие запитывать батарейки."

/obj/item/device/camera_bug/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "жучок для камеры"
	ru_cases["gcase"] = "жучка для камеры"
	ru_cases["dcase"] = "жучку для камеры"
	ru_cases["acase"] = "жучок для камеры"
	ru_cases["icase"] = "жучком для камеры"
	ru_cases["pcase"] = "жучке для камеры"
	name = "Жучок для камеры"

/*
/obj/item/weapon/cigarpacket
	name = "Pete's Cuban Cigars"
	desc = "The most robust cigars on the planet."
*/

/obj/item/weapon/pai_cable/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "информационный кабель"
	ru_cases["gcase"] = "информационного кабеля"
	ru_cases["dcase"] = "информационному кабелю"
	ru_cases["acase"] = "информационный кабель"
	ru_cases["icase"] = "информационным кабелем"
	ru_cases["pcase"] = "информационном кабеле"
	desc = "Гибкий провод с универсальным разъёмом на одном из концов."
	name = "Информационный кабель"

//Neuter Noun 1c
/obj/item/weapon/storage/part_replacer/New()
	..()
	ru_cases["rugender"] = "neuter"
	ru_cases["ncase"] = "Устройство Быстрой Замены Компонентов"
	ru_cases["gcase"] = "Устройства Быстрой Замены Компонентов"
	ru_cases["dcase"] = "Устройству Быстрой Замены Компонентов"
	ru_cases["acase"] = "Устройство Быстрой Замены Компонентов"
	ru_cases["icase"] = "Устройством Быстрой Замены Компонентов"
	ru_cases["pcase"] = "Устройстве Быстрой Замены Компонентов"
	name = "Устройство Быстрой Замены Компонентов"
	desc = "Особый механический модуль, предназначенный для хранения, сортировки и замены стандартных компонентов аппаратуры."

//Neuter Adj 1*a + Noun 1a
/obj/item/weapon/storage/part_replacer/adv/New()
	..()
	ru_cases["rugender"] = "neuter"
	ru_cases["ncase"] = "Усовершенствованное Устройство Быстрой Замены Компонентов"
	ru_cases["gcase"] = "Усовершенствованного Устройства Быстрой Замены Компонентов"
	ru_cases["dcase"] = "Усовершенствованному Устройству Быстрой Замены Компонентов"
	ru_cases["acase"] = "Усовершенствованное Устройство Быстрой Замены Компонентов"
	ru_cases["icase"] = "Усовершенствованным Устройством Быстрой Замены Компонентов"
	ru_cases["pcase"] = "Усовершенствованном Устройстве Быстрой Замены Компонентов"
	name = "Усовершенствованное Устройство Быстрой Замены Компонентов"
	desc = "Особый механический модуль, предназначенный для хранения, сортировки и замены стандартных компонентов аппаратуры. Эта модель обладает гораздо большей вместительностью."

/obj/item/weapon/storage/part_replacer/adv/discount_bluespace/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "Блюспейсовый Быстрый Заменитель Компонентов"
	ru_cases["gcase"] = "Блюспейсового Быстрого Заменителя Компонентов"
	ru_cases["dcase"] = "Блюспейсовому Быстрому Заменителю Компонентов"
	ru_cases["acase"] = "Блюспейсовый Быстрый Заменитель Компонентов"
	ru_cases["icase"] = "Блюспейсовым Быстрым Заменителем Компонентов"
	ru_cases["pcase"] = "Блюспейсовом Быстром Заменителе Компонентов"
	name = "Блюспейсовый Быстрый Заменитель Компонентов"
	desc = "Особый механический модуль, предназначенный для хранения, сортировки и замены стандартных компонентов аппаратуры. Эта модель обладает гораздо большей вместительностью, а также возможностью работать с аппатурой при закрытой панелью техобслуживания."
	
/obj/item/weapon/stock_parts/New()
	..()
	ru_cases["rugender"] = "female"
	ru_cases["ncase"] = "запчасть"
	ru_cases["gcase"] = "запчасти"
	ru_cases["dcase"] = "запчасти"
	ru_cases["acase"] = "запчасть"
	ru_cases["icase"] = "запчастью"
	ru_cases["pcase"] = "запчасти"
	name = "Запчасть"
	desc = "Что?"

/obj/item/weapon/stock_parts/console_screen/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "экран консоли"
	ru_cases["gcase"] = "экрана консоли"
	ru_cases["dcase"] = "экрану консоли"
	ru_cases["acase"] = "экран консоли"
	ru_cases["icase"] = "экраном консоли"
	ru_cases["pcase"] = "экране консоли"
	name = "Экран консоли"
	desc = "Используется в создании компьютеров и прочих девайсов, обладающих интерактивной консолью."

/obj/item/weapon/stock_parts/capacitor/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "конденсатор"
	ru_cases["gcase"] = "конденсатора"
	ru_cases["dcase"] = "конденсатору"
	ru_cases["acase"] = "конденсатор"
	ru_cases["icase"] = "конденсатором"
	ru_cases["pcase"] = "конденсаторе"
	name = "Конденсатор"
	desc = "Простейший конденсатор, применяемый в конструкции множества девайсов."

/obj/item/weapon/stock_parts/scanning_module/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "сканирующий модуль"
	ru_cases["gcase"] = "сканирующего модуля"
	ru_cases["dcase"] = "сканирующему модулю"
	ru_cases["acase"] = "сканирующий модуль"
	ru_cases["icase"] = "сканирующим модулем"
	ru_cases["pcase"] = "сканирующем модуле"
	name = "Сканирующий модуль"
	desc = "Компактный сканирующий модуль высокого разрешения, применяемый в конструкции некоторых девайсов."

/obj/item/weapon/stock_parts/manipulator/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "микро-манипулятор"
	ru_cases["gcase"] = "микро-манипулятора"
	ru_cases["dcase"] = "микро-манипулятору"
	ru_cases["acase"] = "микро-манипулятор"
	ru_cases["icase"] = "микро-манипулятором"
	ru_cases["pcase"] = "микро-манипуляторе"
	name = "Микро-манипулятор"
	desc = "Крохотный манипулятор, применяемый в конструкции некоторых девайсов."

/obj/item/weapon/stock_parts/micro_laser/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "микролазер"
	ru_cases["gcase"] = "микролазера"
	ru_cases["dcase"] = "микролазеру"
	ru_cases["acase"] = "микролазер"
	ru_cases["icase"] = "микролазером"
	ru_cases["pcase"] = "микролазере"
	name = "Микролазер"
	desc = "Крохотный лазер, применяемый в конструкции некоторых девайсов."

/obj/item/weapon/stock_parts/matter_bin/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "контейнер материи"
	ru_cases["gcase"] = "контейнера материи"
	ru_cases["dcase"] = "контейнеру материи"
	ru_cases["acase"] = "контейнер материи"
	ru_cases["icase"] = "контейнером материи"
	ru_cases["pcase"] = "контейнере материи"
	name = "Контейнер материи"
	desc = "Контейнер, предназначенный для материи, которая в дальнейшем будет переформирована."

/obj/item/weapon/stock_parts/capacitor/adv/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "усовершенствованный конденсатор"
	ru_cases["gcase"] = "усовершенствованного конденсатора"
	ru_cases["dcase"] = "усовершенствованному конденсатору"
	ru_cases["acase"] = "усовершенствованный конденсатор"
	ru_cases["icase"] = "усовершенствованным конденсатором"
	ru_cases["pcase"] = "усовершенствованном конденсаторе"
	name = "Усовершенствованный конденсатор"
	desc = "Усовершенствованный конденсатор, применяемый в конструкции многих девайсов."

/obj/item/weapon/stock_parts/scanning_module/adv/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "усовершенствованный сканирующий модуль"
	ru_cases["gcase"] = "усовершенствованного сканирующего модуля"
	ru_cases["dcase"] = "усовершенствованному сканирующему модулю"
	ru_cases["acase"] = "усовершенствованный сканирующий модуль"
	ru_cases["icase"] = "усовершенствованным сканирующим модулем"
	ru_cases["pcase"] = "усовершенствованном сканирующем модуле"
	name = "Усовершенствованный сканирующий модуль"
	desc = "Компактный сканирующий модуль высокого разрешения, применяемый в конструкции некоторых девайсов."

/obj/item/weapon/stock_parts/manipulator/nano/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "нано-манипулятор"
	ru_cases["gcase"] = "нано-манипулятора"
	ru_cases["dcase"] = "нано-манипулятору"
	ru_cases["acase"] = "нано-манипулятор"
	ru_cases["icase"] = "нано-манипулятором"
	ru_cases["pcase"] = "нано-манипуляторе"
	name = "Нано-манипулятор"
	desc = "Крохотный манипулятор, применяемый в конструкции некоторых девайсов."

/obj/item/weapon/stock_parts/micro_laser/high/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "высоковольтный микролазер"
	ru_cases["gcase"] = "высоковольтного микролазера"
	ru_cases["dcase"] = "высоковольтному микролазеру"
	ru_cases["acase"] = "высоковольтный микролазер"
	ru_cases["icase"] = "высоковольтным микролазером"
	ru_cases["pcase"] = "высоковольтном микролазере"
	name = "Высоковольтный микролазер"
	desc = "Крохотный лазер, применяемый в конструкции некоторых девайсов."

/obj/item/weapon/stock_parts/matter_bin/adv/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "усовершенствованный контейнер материи"
	ru_cases["gcase"] = "усовершенствованного контейнера материи"
	ru_cases["dcase"] = "усовершенствованному контейнеру материи"
	ru_cases["acase"] = "усовершенствованный контейнер материи"
	ru_cases["icase"] = "усовершенствованным контейнером материи"
	ru_cases["pcase"] = "усовершенствованном контейнере материи"
	name = "Усовершенствованный контейнер материи"
	desc = "Контейнер, предназначенный для материи, которая в дальнейшем будет переформирована."

//Male Noun 1a
/obj/item/weapon/stock_parts/capacitor/super/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "сверхконденсатор"
	ru_cases["gcase"] = "сверхконденсатора"
	ru_cases["dcase"] = "сверхконденсатору"
	ru_cases["acase"] = "сверхконденсатор"
	ru_cases["icase"] = "сверхконденсатором"
	ru_cases["pcase"] = "сверхконденсаторе"
	name = "Сверхконденсатор"
	desc = "Высокоёмкостный конденсатор, применяемый в конструкции многих девайсов."

//Male Adj 1*a + Adj 2a/c + Noun 2a
/obj/item/weapon/stock_parts/scanning_module/phasic/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "фазовый сканирующий модуль"
	ru_cases["gcase"] = "фазового сканирующего модуля"
	ru_cases["dcase"] = "фазовому сканирующему модулю"
	ru_cases["acase"] = "фазовый сканирующий модуль"
	ru_cases["icase"] = "фазовым сканирующим модулем"
	ru_cases["pcase"] = "фазовом сканирующем модуле"
	name = "Фазовый сканирующий модуль"
	desc = "Компактный фазовый сканирующий модуль высокого разрешения, применяемый в конструкции некоторых девайсов."

//Male Noun 1a
/obj/item/weapon/stock_parts/manipulator/pico/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "пикоманипулятор"
	ru_cases["gcase"] = "пикоманипулятора"
	ru_cases["dcase"] = "пикоманипулятору"
	ru_cases["acase"] = "пикоманипулятор"
	ru_cases["icase"] = "пикоманипулятором"
	ru_cases["pcase"] = "пикоманипуляторе"
	name = "Пико-манипулятор"
	desc = "Крохотный манипулятор, применяемый в конструкции некоторых девайсов."

//Male Adj 1*a + Noun 3a
/obj/item/weapon/stock_parts/micro_laser/ultra/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "ультравысоковольтный микролазер"
	ru_cases["gcase"] = "ультравысоковольтного микролазера"
	ru_cases["dcase"] = "ультравысоковольтному микролазеру"
	ru_cases["acase"] = "ультравысоковольтный микролазер"
	ru_cases["icase"] = "ультравысоковольтным микролазером"
	ru_cases["pcase"] = "ультравысоковольтном микролазере"
	name = "Ультравысоковольтный микролазер"
	desc = "Крохотный лазер, применяемый в конструкции некоторых девайсов."

//Male Noun 1a
/obj/item/weapon/stock_parts/matter_bin/super/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "сверхконтейнер материи"
	ru_cases["gcase"] = "сверхконтейнера материи"
	ru_cases["dcase"] = "сверхконтейнеру материи"
	ru_cases["acase"] = "сверхконтейнер материи"
	ru_cases["icase"] = "сверхконтейнером материи"
	ru_cases["pcase"] = "сверхконтейнере материи"
	name = "Сверхконтейнер материи"
	desc = "Контейнер, предназначенный для материи, которая в дальнейшем будет переформирована."

//Male Noun 1a
/obj/item/weapon/stock_parts/capacitor/hyper/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "гиперконденсатор"
	ru_cases["gcase"] = "гиперконденсатора"
	ru_cases["dcase"] = "гиперконденсатору"
	ru_cases["acase"] = "гиперконденсатор"
	ru_cases["icase"] = "гиперконденсатором"
	ru_cases["pcase"] = "гиперконденсаторе"
	name = "Гиперконденсатор"
	desc = "Гиперёмкостный конденсатор, применяемый в конструкции многих девайсов."

//Male Adj 1*a + Adj 2a/c + Noun 2a
/obj/item/weapon/stock_parts/scanning_module/hyper/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "квантовый сканирующий модуль"
	ru_cases["gcase"] = "квантового сканирующего модуля"
	ru_cases["dcase"] = "квантовому сканирующему модулю"
	ru_cases["acase"] = "квантовый сканирующий модуль"
	ru_cases["icase"] = "квантовым сканирующим модулем"
	ru_cases["pcase"] = "квантовом сканирующем модуле"
	name = "Квантовый сканирующий модуль"
	desc = "Компактный квантовый сканирующий модуль практически идеального разрешения, применяемый в конструкции некоторых девайсов."

//Male Adj 1*a + Adj 2a/c + Noun 2a
/obj/item/weapon/stock_parts/manipulator/hyper/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "планковский манипулятор"
	ru_cases["gcase"] = "планковского манипулятора"
	ru_cases["dcase"] = "планковскому манипулятору"
	ru_cases["acase"] = "планковский манипулятор"
	ru_cases["icase"] = "планковским манипулятором"
	ru_cases["pcase"] = "планковском манипуляторе"
	name = "Планковский манипулятор"
	desc = "Крохотный манипулятор, применяемый в конструкции некоторых девайсов."

//Male Adj 1*a + Noun 3a
/obj/item/weapon/stock_parts/micro_laser/hyper/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "гипервысоковольтный микролазер"
	ru_cases["gcase"] = "гипервысоковольтного микролазера"
	ru_cases["dcase"] = "гипервысоковольтному микролазеру"
	ru_cases["acase"] = "гипервысоковольтный микролазер"
	ru_cases["icase"] = "гипервысоковольтным микролазером"
	ru_cases["pcase"] = "гипервысоковольтном микролазере"
	name = "Гипервысоковольтный микролазер"
	desc = "Крохотный лазер, применяемый в конструкции некоторых девайсов."

//Male Noun 1a
/obj/item/weapon/stock_parts/matter_bin/hyper/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "гиперконтейнер материи"
	ru_cases["gcase"] = "гиперконтейнера материи"
	ru_cases["dcase"] = "гиперконтейнеру материи"
	ru_cases["acase"] = "гиперконтейнер материи"
	ru_cases["icase"] = "гиперконтейнером материи"
	ru_cases["pcase"] = "гиперконтейнере материи"
	name = "Гиперконтейнер материи"
	desc = "Контейнер, предназначенный для материи, которая в дальнейшем будет переформирована."

// Rating 5 - Precursor

//Male Noun 1a
/obj/item/weapon/stock_parts/capacitor/omni/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "омниконденсатор"
	ru_cases["gcase"] = "омниконденсатора"
	ru_cases["dcase"] = "омниконденсатору"
	ru_cases["acase"] = "омниконденсатор"
	ru_cases["icase"] = "омниконденсатором"
	ru_cases["pcase"] = "омниконденсаторе"
	name = "Омниконденсатор"
	desc = "Невероятно высокоёмкостный конденсатор, применяемый в конструкции многих девайсов."

//Male Adj 2a/c + Noun 2a
/obj/item/weapon/stock_parts/scanning_module/omni/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "омнисканирующий модуль"
	ru_cases["gcase"] = "омнисканирующего модуля"
	ru_cases["dcase"] = "омнисканирующему модулю"
	ru_cases["acase"] = "омнисканирующий модуль"
	ru_cases["icase"] = "омнисканирующим модулем"
	ru_cases["pcase"] = "омнисканирующем модуле"
	name = "Омнисканирующий модуль"
	desc = "Компактный пространственно-временной сканирующий модуль идеального разрешения, применяемый в конструкции некоторых девайсов."

//Male Adj 1*a + Adj 2a/c + Noun 2a
/obj/item/weapon/stock_parts/manipulator/omni/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "омниманипулятор"
	ru_cases["gcase"] = "омниманипулятора"
	ru_cases["dcase"] = "омниманипулятору"
	ru_cases["acase"] = "омниманипулятор"
	ru_cases["icase"] = "омниманипулятором"
	ru_cases["pcase"] = "омниманипуляторе"
	name = "Омниманипулятор"
	desc = "Странный бесконечно малый манипулятор, применяемый в конструкции некоторых девайсов."

//Male Adj 1*a + Noun 3a
/obj/item/weapon/stock_parts/micro_laser/omni/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "омнивысоковольтный микролазер"
	ru_cases["gcase"] = "омнивысоковольтного микролазера"
	ru_cases["dcase"] = "омнивысоковольтному микролазеру"
	ru_cases["acase"] = "омнивысоковольтный микролазер"
	ru_cases["icase"] = "омнивысоковольтным микролазером"
	ru_cases["pcase"] = "омнивысоковольтном микролазере"
	name = "Омнивысоковольтный микролазер"
	desc = "Странный лазер, применяемый в конструкции некоторых девайсов."

//Male Noun 1a
/obj/item/weapon/stock_parts/matter_bin/omni/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "омниконтейнер материи"
	ru_cases["gcase"] = "омниконтейнера материи"
	ru_cases["dcase"] = "омниконтейнеру материи"
	ru_cases["acase"] = "омниконтейнер материи"
	ru_cases["icase"] = "омниконтейнером материи"
	ru_cases["pcase"] = "омниконтейнере материи"
	name = "Омниконтейнер материи"
	desc = "Странный контейнер, предназначенный для материи, которая в дальнейшем будет переформирована."

// Subspace stock parts

//Male Adj 1*a + Noun 2a
/obj/item/weapon/stock_parts/subspace/ansible/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "субпространственный анзибль"
	ru_cases["gcase"] = "субпространственного анзибля"
	ru_cases["dcase"] = "субпространственному анзиблю"
	ru_cases["acase"] = "субпространственный анзибль"
	ru_cases["icase"] = "субпространственным анзиблем"
	ru_cases["pcase"] = "субпространственном анзибле"
	name = "Субпространственный анзибль"
	desc = "Компактный модуль, способный фиксировать внепространственную активность."

//Male Adj 1*a + Adj 2a/c + Noun 2a
/obj/item/weapon/stock_parts/subspace/sub_filter/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "гиперволновой фильтр"
	ru_cases["gcase"] = "гиперволнового фильтра"
	ru_cases["dcase"] = "гиперволновому фильтру"
	ru_cases["acase"] = "гиперволновой фильтр"
	ru_cases["icase"] = "гиперволновым фильтром"
	ru_cases["pcase"] = "гиперволновом фильтре"
	name = "Гиперволновой фильтр"
	desc = "Крохотный девайс, способный фильтровать и конвертировать сверхинтенсивные радиоволны."

//Male Adj 1*a + Noun 2a
/obj/item/weapon/stock_parts/subspace/amplifier/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "субпространственный усилитель"
	ru_cases["gcase"] = "субпространственного усилителя"
	ru_cases["dcase"] = "субпространственному усилителю"
	ru_cases["acase"] = "субпространственный усилитель"
	ru_cases["icase"] = "субпространственным усилителем"
	ru_cases["pcase"] = "субпространственном усилителе"
	name = "Субпространственный усилитель"
	desc = "Компактный микромеханизм, способный усиливать слабые субпространственные передачи."

//Male Adj 1*a + Adj 2a/c + Noun 2a
/obj/item/weapon/stock_parts/subspace/treatment/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "субпространственный обрабатывающий диск"
	ru_cases["gcase"] = "субпространственного обрабатывающего диска"
	ru_cases["dcase"] = "субпространственному обрабатывающему диску"
	ru_cases["acase"] = "субпространственный обрабатывающий диск"
	ru_cases["icase"] = "субпространственным обрабатывающим диском"
	ru_cases["pcase"] = "субпространственном обрабатывающем диске"
	name = "Субпространственный обрабатывающий диск"
	desc = "Компактный микромеханизм, способный увеличивать длину гиперсжатых радиоволн."

//Male Adj 1*a + Noun 3a
/obj/item/weapon/stock_parts/subspace/analyzer/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "субпространственный анализатор волн"
	ru_cases["gcase"] = "субпространственного анализатора волн"
	ru_cases["dcase"] = "субпространственному анализатору волн"
	ru_cases["acase"] = "субпространственный анализатор волн"
	ru_cases["icase"] = "субпространственным анализатором волн"
	ru_cases["pcase"] = "субпространственном анализаторе волн"
	name = "Субпространственный анализатор волн"
	desc = "Высокоточный анализатор, способный анализировать длину субпространственных волн."

//Male Adj 1*a + Noun 3a
/obj/item/weapon/stock_parts/subspace/crystal/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "анзиблевый кристалл"
	ru_cases["gcase"] = "анзиблевого кристалла"
	ru_cases["dcase"] = "анзиблевому кристаллу"
	ru_cases["acase"] = "анзиблевый кристалл"
	ru_cases["icase"] = "анзиблевым кристаллом"
	ru_cases["pcase"] = "анзиблевом кристалле"
	name = "Анзиблевый кристалл"
	desc = "Кристалл, изготоавливаемый из чистейшего стекла и предназначенный для передачи лазерных пакетов данных в субпространство."

//Male Adj 1*a + Noun 3a
/obj/item/weapon/stock_parts/subspace/transmitter/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "субпространственный передатчик"
	ru_cases["gcase"] = "субпространственного передатчика"
	ru_cases["dcase"] = "субпространственному передатчику"
	ru_cases["acase"] = "субпространственный передатчик"
	ru_cases["icase"] = "субпространственным передатчиком"
	ru_cases["pcase"] = "субпространственном передатчике"
	name = "Субпространственный передатчик"
	desc = "Крупный механизм, предназначенный для открытия окна в субпространственное измерение."

//Female Noun 1*d
/obj/item/weapon/ectoplasm/New()
	..()
	ru_cases["rugender"] = "female"
	ru_cases["ncase"] = "эктоплазма"
	ru_cases["gcase"] = "эктоплазмы"
	ru_cases["dcase"] = "эктоплазме"
	ru_cases["acase"] = "эктоплазму"
	ru_cases["icase"] = "эктоплазмой"
	ru_cases["pcase"] = "эктоплазме"
	name = "Эктоплазма"
	desc = "Жуть!"

//Male Noun 1a
/obj/item/weapon/research/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "инструмент дебаггинга исследований"
	ru_cases["gcase"] = "инструмента дебаггинга исследований"
	ru_cases["dcase"] = "инструменту дебаггинга исследований"
	ru_cases["acase"] = "инструмент дебаггинга исследований"
	ru_cases["icase"] = "инструментом дебаггинга исследований"
	ru_cases["pcase"] = "инструменте дебаггинга исследований"
	name = "Инструмент дебаггинга исследований"
	desc = "Инструмент для моментальной прокачки исследований. Только для тестирования."

// Additional construction stock parts

/obj/item/weapon/stock_parts/gear/New()
	..()
	ru_cases["rugender"] = "female"
	ru_cases["ncase"] = "шестерня"
	ru_cases["gcase"] = "шестерни"
	ru_cases["dcase"] = "шестерне"
	ru_cases["acase"] = "шестерню"
	ru_cases["icase"] = "шестернёй"
	ru_cases["pcase"] = "шестерне"
	name = "Шестерня"
	desc = "Шестерня, используемая в конструкциях."
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "gear"

/obj/item/weapon/stock_parts/motor/New()
	..()
	ru_cases["rugender"] = "male"
	ru_cases["ncase"] = "мотор"
	ru_cases["gcase"] = "мотора"
	ru_cases["dcase"] = "мотору"
	ru_cases["acase"] = "мотор"
	ru_cases["icase"] = "мотором"
	ru_cases["pcase"] = "моторе"
	name = "Мотор"
	desc = "Мотор, используемый в конструкциях."

/obj/item/weapon/stock_parts/spring/New()
	..()
	ru_cases["rugender"] = "female"
	ru_cases["ncase"] = "пружина"
	ru_cases["gcase"] = "пружины"
	ru_cases["dcase"] = "пружине"
	ru_cases["acase"] = "пружину"
	ru_cases["icase"] = "пружиной"
	ru_cases["pcase"] = "пружине"
	name = "Пружина"
	desc = "Пружина, используемая в конструкциях."
