// Chemistry-Colours.dm 



// Chemistry-Holder.dm 



// Chemistry-Logging.dm 



// Chemistry-Machinery.dm 

/obj/machinery/chem_master
	name = "ХимМастер 3000"
	desc = "Используется для сепарации и упаковки химических веществ в пластыри, пилюли и склянки. Гарантия аннулируется при использовании аппарата для создания космических наркотиков."
	rugender = "male"
	ncase = "ХимМастер 3000"
	gcase = "ХимМастера 3000"
	dcase = "ХимМастеру 3000"
	acase = "ХимМастер 3000"
	icase = "ХимМастером 3000"
	pcase = "ХимМастере 3000"

/obj/machinery/chem_master/condimaster
	name = "КондиМастер 3000"
	rugender = "male"
	ncase = "КондиМастер 3000"
	gcase = "КондиМастера 3000"
	dcase = "КондиМастеру 3000"
	acase = "КондиМастер 3000"
	icase = "КондиМастером 3000"
	pcase = "КондиМастере 3000"

/obj/machinery/reagentgrinder
	name = "Универсальный блендер"
	desc = "Перемалывает крупные штуки в что-то помельче."
	rugender = "male"
	ncase = "универсальный блендер"
	gcase = "универсального блендера"
	dcase = "универсальному блендеру"
	acase = "универсальный блендер"
	icase = "универсальным блендером"
	pcase = "универсальном блендере"

/obj/machinery/chemical_analyzer
	name = "Химический анализатор"
	desc = "Используется для высокоточного сканирования и обнаружения химических веществ и других жидкостей внутри контейнеров. \
	Он также способен опознать жидкости, находящиеся в неизвестных объектах."
	description_info = "Этот аппарат постарается идентифицировать вещества внутри любого допустимого контейнера. \
	Он также позволяет выявить особые вещества, которые невозможно опознать невооружённым глазом."
	rugender = "male"
	ncase = "химический анализатор"
	gcase = "химического анализатора"
	dcase = "химическому анализатору"
	acase = "химический анализатор"
	icase = "химическим анализатором"
	pcase = "химическом анализаторе"

// Chemistry-Machinery_vr.dm 



// Chemistry-Metabolism.dm 



// Chemistry-Readme.dm 



// Chemistry-Reagents.dm 



// Chemistry-Reagents-Helpers.dm 



// Chemistry-Reagents_vr.dm 

/datum/reagent/advmutationtoxin
	name = "Усовершенствованный токсин мутации"
	description = "Деструктивный токсин, выделяемый слизнями. Превращает субъекта в прометеана."
	rugender = "male"
	ncase = "усовершенствованный токсин мутации"
	gcase = "усовершенствованного токсина мутации"
	dcase = "усовершенствованному токсину мутации"
	acase = "усовершенствованный токсин мутации"
	icase = "усовершенствованным токсином мутации"
	pcase = "усовершенствованном токсине мутации"

/datum/reagent/nif_repair_nanites
	name = "Программируемые наномашины"
	description = "Густая серая субстанция, состоящая из ремонтных наномашин."
	rugender = "plural"
	ncase = "программируемые наномашины"
	gcase = "программируемых наномашин"
	dcase = "программируемым наномашинам"
	acase = "программируемые наномашины"
	icase = "программируемыми наномашинами"
	pcase = "программируемых наномашинах"
	taste_description = "металла"

/datum/reagent/firefighting_foam
	name = "Противопожарная пена"
	description = "Привычный способ борьбы с огнём. Вместо того, чтобы просто лишать пожар кислорода, эта пена вмешивается в саму реакцию воспламенения. Значительно эффективнее, чем водяные огнетушители, поставляемые NT."
	taste_description = "содержимого огнетушителя"
	rugender = "female"
	ncase = "противопожарная пена"
	gcase = "противопожарной пены"
	dcase = "противопожарной пене"
	acase = "противопожарную пену"
	icase = "противопожарной пеной"
	pcase = "противопожарной пене"

/datum/reagent/liquid_protean
	name = "Жидкий протеан"
	description = "Похоже, это небольшой кусочек от протеана, всё ещё дрыгающийся."
	taste_description = "дёргающегося арахисового масла"
	rugender = "male"
	ncase = "жидкий протеан"
	gcase = "жидкого протеана"
	dcase = "жидкому протеану"
	acase = "жидкий протеан"
	icase = "жидким протеаном"
	pcase = "жидком протеане"

// reagent_containers.dm 

/obj/item/weapon/reagent_containers
	name = "Контейнер"
	desc = "..."
	rugender = "male"
	ncase = "контейнер"
	gcase = "контейнера"
	dcase = "контейнеру"
	acase = "контейнер"
	icase = "контейнером"
	pcase = "контейнере"

// reagent_dispenser.dm

/obj/structure/reagent_dispensers
	name = "Диспенсер"
	desc = "..."
	rugender = "male"
	ncase = "диспенсер"
	gcase = "диспенсера"
	dcase = "диспенсеру"
	acase = "диспенсер"
	icase = "диспенсером"
	pcase = "диспенсере"

/obj/structure/reagent_dispensers/watertank
	name = "Бак для воды"
	desc = "Обыкновенная цистерна для воды."
	rugender = "male"
	ncase = "бак для воды"
	gcase = "бака для воды"
	dcase = "баку для воды"
	acase = "бак для воды"
	icase = "баком для воды"
	pcase = "баке для воды"

/obj/structure/reagent_dispensers/watertank/high
	name = "Объёмный бак для воды"
	desc = "Бак под высоким давлением, способный содержать большие объёмы воды."
	rugender = "male"
	ncase = "объёмный бак для воды"
	gcase = "объёмного бака для воды"
	dcase = "объёмному баку для воды"
	acase = "объёмный бак для воды"
	icase = "объёмным баком для воды"
	pcase = "объёмном баке для воды"

/obj/structure/reagent_dispensers/fueltank
	name = "Бак для топлива"
	desc = "Цистерна для топлива."
	rugender = "male"
	ncase = "бак для топлива"
	gcase = "бака для топлива"
	dcase = "баку для топлива"
	acase = "бак для топлива"
	icase = "баком для топлива"
	pcase = "баке для топлива"

/obj/structure/reagent_dispensers/fueltank/high
	name = "Объёмный бак для топлива"
	desc = "Бак под высоким давлением, способный содержать большие объёмы топлива."
	rugender = "male"
	ncase = "объёмный бак для топлива"
	gcase = "объёмного бака для топлива"
	dcase = "объёмному баку для топлива"
	acase = "объёмный бак для топлива"
	icase = "объёмным баком для топлива"
	pcase = "объёмном баке для топлива"

/obj/structure/reagent_dispensers/foam
	name = "Бак для пены"
	desc = "Цистерна для пены."
	rugender = "male"
	ncase = "бак для пены"
	gcase = "бака для пены"
	dcase = "баку для пены"
	acase = "бак для пены"
	icase = "баком для пены"
	pcase = "баке для пены"

/obj/structure/reagent_dispensers/peppertank
	name = "Наполнитель перцовых баллончиков"
	desc = "Позволяет заправить перцовый баллончик."
	rugender = "male"
	ncase = "наполнитель перцовых баллончиков"
	gcase = "наполнителя перцовых баллончиков"
	dcase = "наполнителю перцовых баллончиков"
	acase = "наполнитель перцовых баллончиков"
	icase = "наполнителем перцовых баллончиков"
	pcase = "наполнителем перцовых баллончиков"

/obj/structure/reagent_dispensers/water_cooler
	name = "Кулер"
	desc = "Аппарат, наливающий в стаканчики воду."
	rugender = "male"
	ncase = "кулер"
	gcase = "кулера"
	dcase = "кулеру"
	acase = "кулер"
	icase = "кулером"
	pcase = "кулере"

/obj/structure/reagent_dispensers/beerkeg
	name = "Пивная бочка"
	desc = "Обыкновенная пивная бочка."
	rugender = "female"
	ncase = "пивная бочка"
	gcase = "пивной бочки"
	dcase = "пивной бочке"
	acase = "пивную бочку"
	icase = "пивной бочкой"
	pcase = "пивной бочке"

/obj/structure/reagent_dispensers/beerkeg/fakenuke
	name = "Бочка ядерного пива"
	desc = "Бочка пива в форме ядерной бомбы! Гарантированно устраивает взрыв эмоций!"
	rugender = "female"
	ncase = "бочка ядерного пива"
	gcase = "бочки ядерного пива"
	dcase = "бочке ядерного пива"
	acase = "бочку ядерного пива"
	icase = "бочкой ядерного пива"
	pcase = "бочке ядерного пива"

/obj/structure/reagent_dispensers/virusfood
	name = "Диспенсер вирусной пищи"
	desc = "Диспенсер для вирусной пищи. Пальчики оближешь."
	rugender = "male"
	ncase = "диспенсер вирусной пищи"
	gcase = "диспенсера вирусной пищи"
	dcase = "диспенсеру вирусной пищи"
	acase = "диспенсер вирусной пищи"
	icase = "диспенсером вирусной пищи"
	pcase = "диспенсере вирусной пищи"

/obj/structure/reagent_dispensers/acid
	name = "Диспенсер серной кислоты"
	desc = "Диспенсер кислоты для технических процессов."
	rugender = "male"
	ncase = "диспенсер серной кислоты"
	gcase = "диспенсера серной кислоты"
	dcase = "диспенсеру серной кислоты"
	acase = "диспенсер серной кислоты"
	icase = "диспенсером серной кислоты"
	pcase = "диспенсере серной кислоты"

/obj/structure/reagent_dispensers/cookingoil
	name = "Бак для масла"
	desc = "Пятидесятилитровый бак кукурузного масла, предназначенный для крупных фритюрниц. Хранить в прохладном тёмном месте."
	rugender = "male"
	ncase = "бак для масла"
	gcase = "бака для масла"
	dcase = "баку для масла"
	acase = "бак для масла"
	icase = "баком для масла"
	pcase = "баке для масла"