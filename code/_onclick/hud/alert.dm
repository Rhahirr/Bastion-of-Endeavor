//A system to manage and display alerts on screen without needing you to do it yourself

//PUBLIC -  call these wherever you want


/mob/proc/throw_alert(category, type, severity, obj/new_master)

/* Proc to create or update an alert. Returns the alert if the alert is new or updated, 0 if it was thrown already
 category is a text string. Each mob may only have one alert per category; the previous one will be replaced
 path is a type path of the actual alert type to throw
 severity is an optional number that will be placed at the end of the icon_state for this alert
 For example, high pressure's icon_state is "highpressure" and can be serverity 1 or 2 to get "highpressure1" or "highpressure2"
 new_master is optional and sets the alert's icon state to "template" in the ui_style icons with the master as an overlay.
 Clicks are forwarded to master */

	if(!category)
		return

	var/obj/screen/alert/alert
	if(alerts[category])
		alert = alerts[category]
		if(new_master && new_master != alert.master)
			/* Bastion of Endeavor Translation
			WARNING("[src] threw alert [category] with new_master [new_master] while already having that alert with master [alert.master]")
			*/
			WARNING("[src] отправил alert [category] с new_master [new_master], уже имея alert с master [alert.master]")
			// End of Bastion of Endeavor Translation
			clear_alert(category)
			return .()
		else if(alert.type != type)
			clear_alert(category)
			return .()
		else if(!severity || severity == alert.severity)
			if(alert.timeout)
				clear_alert(category)
				return .()
			else //no need to update
				return 0
	else
		alert = new type

	if(new_master)
		alert.icon_state = "itembased"
		var/image/I = image(icon = new_master.icon, icon_state = new_master.icon_state, dir = SOUTH)
		I.plane = PLANE_PLAYER_HUD_ABOVE
		alert.add_overlay(I)
		alert.master = new_master
	else
		alert.icon_state = "[initial(alert.icon_state)][severity]"
		alert.severity = severity

	alerts[category] = alert
	if(client && hud_used)
		hud_used.reorganize_alerts()
	alert.transform = matrix(32, 6, MATRIX_TRANSLATE)
	animate(alert, transform = matrix(), time = 2.5, easing = CUBIC_EASING)

	if(alert.timeout)
		addtimer(CALLBACK(src, .proc/alert_timeout, alert, category), alert.timeout)
		alert.timeout = world.time + alert.timeout - world.tick_lag
	return alert

/mob/proc/alert_timeout(obj/screen/alert/alert, category)
	if(alert.timeout && alerts[category] == alert && world.time >= alert.timeout)
		clear_alert(category)

// Proc to clear an existing alert.
/mob/proc/clear_alert(category)
	var/obj/screen/alert/alert = alerts[category]
	if(!alert)
		return 0

	alerts -= category
	if(client && hud_used)
		hud_used.reorganize_alerts()
		client.screen -= alert
	qdel(alert)

/obj/screen/alert
	/* Bastion of Endeavor Edit: We have a dmi with russian icons.
	icon = 'icons/mob/screen_alert.dmi'
	*/
	icon = 'icons/russian/screen_alert_ru.dmi'
	// End of Bastion of Endeavor Edit
	icon_state = "default"
	/* Bastion of Endeavor Translation
	name = "Alert"
	desc = "Something seems to have gone wrong with this alert, so report this bug please"
	*/
	name = "Уведомление"
	desc = "С этим уведомлением что-то пошло не так, так что просьба доложить об этом баге."
	// End of Bastion of Endeavor Translation
	mouse_opacity = 1
	var/timeout = 0 //If set to a number, this alert will clear itself after that many deciseconds
	var/severity = 0
	var/alerttooltipstyle = ""
	var/no_underlay // Don't underlay the UI style's blank template icon under this


/obj/screen/alert/MouseEntered(location,control,params)
	openToolTip(usr, src, params, title = name, content = desc, theme = alerttooltipstyle)


/obj/screen/alert/MouseExited()
	closeToolTip(usr)


//Gas alerts
/* Bastion of Endeavor Translation
/obj/screen/alert/not_enough_oxy
	name = "Choking (No O2)"
	desc = "You're not getting enough oxygen. Find some good air before you pass out! \
The box in your backpack has an oxygen tank and breath mask in it."
	icon_state = "not_enough_oxy"

/obj/screen/alert/too_much_oxy
	name = "Choking (O2)"
	desc = "There's too much oxygen in the air, and you're breathing it in! Find some good air before you pass out!"
	icon_state = "too_much_oxy"

/obj/screen/alert/not_enough_nitro
	name = "Choking (No N)"
	desc = "You're not getting enough nitrogen. Find some good air before you pass out!"
	icon_state = "not_enough_nitro"

/obj/screen/alert/too_much_nitro
	name = "Choking (N)"
	desc = "There's too much nitrogen in the air, and you're breathing it in! Find some good air before you pass out!"
	icon_state = "too_much_nitro"

/obj/screen/alert/not_enough_co2
	name = "Choking (No CO2)"
	desc = "You're not getting enough carbon dioxide. Find some good air before you pass out!"
	icon_state = "not_enough_co2"

/obj/screen/alert/too_much_co2
	name = "Choking (CO2)"
	desc = "There's too much carbon dioxide in the air, and you're breathing it in! Find some good air before you pass out!"
	icon_state = "too_much_co2"

/obj/screen/alert/too_much_co2/plant
	name = "Livin' the good life"
	desc = "There's so much carbon dioxide in the air, you're in fucking heaven. Watch out for passed out fleshies, though."
	icon_state = "too_much_co2"

/obj/screen/alert/not_enough_tox
	name = "Choking (No Phoron)"
	desc = "You're not getting enough phoron. Find some good air before you pass out!"
	icon_state = "not_enough_tox"

/obj/screen/alert/tox_in_air
	name = "Choking (Phoron)"
	desc = "There's highly flammable, toxic phoron in the air and you're breathing it in. Find some fresh air. \
The box in your backpack has an oxygen tank and gas mask in it."
	icon_state = "too_much_tox"

/obj/screen/alert/not_enough_fuel
	name = "Choking (No Volatile fuel)"
	desc = "You're not getting enough volatile fuel. Find some good air before you pass out!"
	icon_state = "not_enough_tox"

/obj/screen/alert/not_enough_n2o
	name = "Choking (No Sleeping Gas)"
	desc = "You're not getting enough sleeping gas. Find some good air before you pass out!"
	icon_state = "not_enough_tox"
*/
/obj/screen/alert/not_enough_oxy
	name = "Удушье (Мало O2)"
	desc = "Вам не хватает кислорода. Сделайте глоток свежего воздуха, пока не упали в обморок! \
В Вашем рюкзаке есть коробка с баллоном и дыхательной маской."
	icon_state = "not_enough_oxy"

/obj/screen/alert/too_much_oxy
	name = "Удушье (O2)"
	desc = "В воздухе слишком много кислорода, невозможно дышать! Сделайте глоток нормального воздуха, пока не упали в обморок!"
	icon_state = "too_much_oxy"

/obj/screen/alert/not_enough_nitro
	name = "Удушье (Мало N)"
	desc = "Вам не хватает азота, чтобы дышать. Сделайте глоток нормального воздуха, пока не упали в обморок!"
	icon_state = "not_enough_nitro"

/obj/screen/alert/too_much_nitro
	name = "Удушье (N)"
	desc = "В воздухе слишком много азота, невозможно дышать! Сделайте глоток нормального воздуха, пока не упали в обморок!"
	icon_state = "too_much_nitro"

/obj/screen/alert/not_enough_co2
	name = "Удушье (Мало CO2)"
	desc = "Вам не хватает углекислого газа. Сделайте глоток нормального воздуха, пока не упали в обморок!"
	icon_state = "not_enough_co2"

/obj/screen/alert/too_much_co2
	name = "Удушье (CO2)"
	desc = "В воздухе слишком много углекислого газа, невозможно дышать! Сделайте глоток нормального воздуха, пока не упали в обморок!"
	icon_state = "too_much_co2"

/obj/screen/alert/too_much_co2/plant
	name = "Жизнь прекрасна"
	desc = "В воздухе столько углекислого газа, это просто райское наслаждение. Разве что, остерегайтесь мешков мяса в обмороке."
	icon_state = "too_much_co2"

/obj/screen/alert/not_enough_tox
	name = "Удушье (Мало форона)"
	desc = "Вам не хватает форона, чтобы дышать. Сделайте глоток нормального воздуха, пока не упали в обморок!"
	icon_state = "not_enough_tox"

/obj/screen/alert/tox_in_air
	name = "Удушье (Форон)"
	desc = "Вы дышите легковоспламеняющимся токсичным фороном. Сделайте глоток нормального воздуха. \
В Вашем рюкзаке есть коробка с баллоном и дыхательной маской."
	icon_state = "too_much_tox"

/obj/screen/alert/not_enough_fuel
	name = "Удушье (Мало летучего топлива)"
	desc = "Вам не хватает летучего топлива, чтобы дышать. Сделайте глоток нормального воздуха, пока не упали в обморок!"
	icon_state = "not_enough_tox"

/obj/screen/alert/not_enough_n2o
	name = "Удушье (Мало усыпляющего газа)"
	desc = "Вам не хватает усыпляющего газа. Сделайте глоток нормального воздуха, пока не упали в обморок!"
	icon_state = "not_enough_tox"
// End of Bastion of Endeavor Translation
//End gas alerts


/* Bastion of Endeavor Translation
/obj/screen/alert/fat
	name = "Fat"
	desc = "You ate too much food, lardass. Run around the station and lose some weight."
	icon_state = "fat"

/obj/screen/alert/fat/vampire
	desc = "You drank too much blood, lardass. Run around the station and lose some weight."
	icon_state = "v_fat"

/obj/screen/alert/fat/synth
	desc = "Your battery is full! Don't overvolt it."
	icon_state = "c_fat"

/obj/screen/alert/hungry
	name = "Hungry"
	desc = "Some food would be good right about now."
	icon_state = "hungry"

/obj/screen/alert/hungry/vampire
	desc = "You could use a bloodsnack or two."
	icon_state = "v_hungry"

/obj/screen/alert/hungry/synth
	desc = "Battery's running a bit low, could use a topoff."
	icon_state = "c_hungry"

/obj/screen/alert/starving
	name = "Starving"
	desc = "You're severely malnourished. The hunger pains make moving around a chore."
	icon_state = "starving"

/obj/screen/alert/starving/vampire
	desc = "You *need* blood; go rip out someone's throat already!"
	icon_state = "v_starving"

/obj/screen/alert/starving/synth
	desc = "Your battery is about to die! Charge it ASAP!"
	icon_state = "c_starving"

/obj/screen/alert/hot
	name = "Too Hot"
	desc = "You're flaming hot! Get somewhere cooler and take off any insulating clothing like a fire suit."
	icon_state = "hot"

/obj/screen/alert/hot/robot
	desc = "The air around you is too hot for a humanoid. Be careful to avoid exposing them to this enviroment."

/obj/screen/alert/cold
	name = "Too Cold"
	desc = "You're freezing cold! Get somewhere warmer and take off any insulating clothing like a space suit."
	icon_state = "cold"

/obj/screen/alert/cold/robot
	desc = "The air around you is too cold for a humanoid. Be careful to avoid exposing them to this enviroment."

/obj/screen/alert/lowpressure
	name = "Low Pressure"
	desc = "The air around you is hazardously thin. A space suit would protect you."
	icon_state = "lowpressure"

/obj/screen/alert/highpressure
	name = "High Pressure"
	desc = "The air around you is hazardously thick. A fire suit would protect you."
	icon_state = "highpressure"

/obj/screen/alert/blind
	name = "Blind"
	desc = "You can't see! This may be caused by a genetic defect, eye trauma, being unconscious, \
or something covering your eyes."
	icon_state = "blind"

/obj/screen/alert/stunned
	name = "Stunned"
	desc = "You're temporarily stunned! You'll have trouble moving or performing actions, but it should clear up on it's own."
	icon_state = "stun"

/obj/screen/alert/paralyzed
	name = "Paralyzed"
	desc = "You're paralyzed! This could be due to drugs or serious injury. You'll be unable to move or perform actions."
	icon_state = "paralysis"

/obj/screen/alert/weakened
	name = "Weakened"
	desc = "You're weakened! This could be a temporary issue due to injury or the result of drugs or drinking."
	icon_state = "weaken"

/obj/screen/alert/confused
	name = "Confused"
	desc = "You're confused, and may stumble into things! This may be from concussive effects, drugs, or dizzyness. Walking will help reduce incidents."
	icon_state = "confused"

/obj/screen/alert/high
	name = "High"
	desc = "Whoa man, you're tripping balls! Careful you don't get addicted... if you aren't already."
	icon_state = "high"

/obj/screen/alert/embeddedobject
	name = "Embedded Object"
	desc = "Something got lodged into your flesh and is causing major bleeding. It might fall out with time, but surgery is the safest way. \
If you're feeling frisky, right click on yourself and select \"Remove embedded object\" to pull the object out."
	icon_state = "embeddedobject"

/obj/screen/alert/embeddedobject/Click()
	if(isliving(usr))
		var/mob/living/carbon/human/M = usr
		return M.help_shake_act(M)

/obj/screen/alert/asleep
	name = "Asleep"
	desc = "You've fallen asleep. Wait a bit and you should wake up. Unless you don't, considering how helpless you are."
	icon_state = "asleep"

/obj/screen/alert/weightless
	name = "Weightless"
	desc = "Gravity has ceased affecting you, and you're floating around aimlessly. You'll need something large and heavy, like a \
wall or lattice, to push yourself off if you want to move. A jetpack would enable free range of motion. A pair of \
magboots would let you walk around normally on the floor. Barring those, you can throw things, use a fire extinguisher, \
or shoot a gun to move around via Newton's 3rd Law of Motion."
	icon_state = "weightless"

/obj/screen/alert/fire
	name = "On Fire"
	desc = "You're on fire. Stop, drop and roll to put the fire out or move to a vacuum area."
	icon_state = "fire"

/obj/screen/alert/fire/Click()
	if(isliving(usr))
		var/mob/living/L = usr
		return L.resist()
*/
/obj/screen/alert/fat
	name = "Лишний вес"
	desc = "Вы слишком обожрались. Теперь отрабатывайте все эти калории, чтобы похудеть."
	icon_state = "fat"

/obj/screen/alert/fat/vampire
	desc = "Вы слишком упились кровью. Теперь отрабатывайте все эти калории, чтобы похудеть."
	icon_state = "v_fat"

/obj/screen/alert/fat/synth
	desc = "Ваш аккумулятор полностью заряжен. Не перегрузите его."
	icon_state = "c_fat"

/obj/screen/alert/hungry
	name = "Аппетит"
	desc = "Вы бы не отказались перекусить."
	icon_state = "hungry"

/obj/screen/alert/hungry/vampire
	desc = "Вы бы сейчас не отказались от крови."
	icon_state = "v_hungry"

/obj/screen/alert/hungry/synth
	desc = "Аккумулятор начинает садиться, не помешало бы подзарядить."
	icon_state = "c_hungry"

/obj/screen/alert/starving
	name = "Голод"
	desc = "Вы крайне голодны. Стонущий желудок затрудняет Ваше передвижение."
	icon_state = "starving"

/obj/screen/alert/starving/vampire
	desc = "Вам *нужна* кровь, идите и вырвите кому-нибудь глотку!"
	icon_state = "v_starving"

/obj/screen/alert/starving/synth
	desc = "Аккумулятор вот-вот сядет! Скорее подзарядитесь!"
	icon_state = "c_starving"

/obj/screen/alert/hot
	name = "Жара"
	desc = "Вам слишком жарко! Найдите место попрохладнее и снимите с себя теплоизолирующую одежду."
	icon_state = "hot"

/obj/screen/alert/hot/robot
	desc = "Воздух вокруг Вас слишком горяч для гуманоидных рас. Старайтесь не допускать их контакта с этой средой."

/obj/screen/alert/cold
	name = "Мороз"
	desc = "Вам слишком холодно! Найдите место потеплее и снимите с себя теплоизолирующую одежду."
	icon_state = "cold"

/obj/screen/alert/cold/robot
	desc = "Воздух вокруг Вас слишком горяч для гуманоидных рас. Старайтесь не допускать их контакта с этой средой."

/obj/screen/alert/lowpressure
	name = "Низкое давление"
	desc = "Вас окружает чрезмерно разреженный воздух. Вас может защитить скафандр."
	icon_state = "lowpressure"

/obj/screen/alert/highpressure
	name = "Высокое давление"
	desc = "Вас окружает чрезмерно плотный воздух. Вас может защитить противопожарный костюм."
	icon_state = "highpressure"

/obj/screen/alert/blind
	name = "Слепота"
	desc = "Вы ничего не видите! Это может быть вызвано повреждением глаз, генетическим дефектом, потерей сознания, \
или же просто прикрытием глаз."
	icon_state = "blind"

/obj/screen/alert/stunned
	name = "Оглушение"
	desc = "Вы временно оглушены! Вам тяжело двигаться или выполнять действия, но это должно скоро пройти."
	icon_state = "stun"

/obj/screen/alert/paralyzed
	name = "Паралич"
	desc = "Вы парализованы! Это может быть вывано препаратами или серьёзной травмой. Вы не можете двигаться или выполнять действия."
	icon_state = "paralysis"

/obj/screen/alert/weakened
	name = "Ослабление"
	desc = "Вы ослаблены! Это временное состояние может быть вызвано как травмой, так и алкоголем или препаратами."
	icon_state = "weaken"

/obj/screen/alert/confused
	name = "Запутанность"
	desc = "Осторожно, Вы можете случайно во что-то врезаться! Это может быть вызвано сотрясением, препаратами или плохим физическим состоянием. Медленная ходьба поможет снизить риск."
	icon_state = "confused"

/obj/screen/alert/high
	name = "Под кайфом"
	desc = "Ух ты ж ё, да Вы под кайфом! Постарайтесь не подсесть... если этого ещё не случилось."
	icon_state = "high"

/obj/screen/alert/embeddedobject
	name = "Инородный объект"
	desc = "Что-то вонзилось в Вашу плоть и вызвало сильное кровотечение. Оно может выпасть само, но лучше довериться хирургии. \
Если Вы готовы пойти на риск, Вы можете самостоятельно извлечь объект, нажав на себя правой кнопкой мыши и выбрав соответствующий глагол."
	icon_state = "embeddedobject"

/obj/screen/alert/embeddedobject/Click()
	if(isliving(usr))
		var/mob/living/carbon/human/M = usr
		return M.help_shake_act(M)

/obj/screen/alert/asleep
	name = "Сон"
	desc = "Вы уснули. Подождите немного, и Вы скоро проснётесь. Или нет."
	icon_state = "asleep"

/obj/screen/alert/weightless
	name = "Невесомость"
	desc = "Сила притяжения прекратила оказывать на Вас своё действие, и Вы бесцельно летаете в пространстве. Для того, чтобы перемещаться, необходимо что-то тяжёлое, \
вроде стены или решётки, от которых можно было бы оттолкнуться. С помощью реактивного ранца можно перемещаться свободно, а \
магнитные ботинки позволяют ходить по полу. Также из вариантов у Вас бросить что-нибудь в сторону, выстрелить из оружия или использовать огнетушитель, \
чтобы оттолкнуться согласно третьему закону Ньютона."
	icon_state = "weightless"

/obj/screen/alert/fire
	name = "В огне"
	desc = "Вы горите. Бросьтесь вниз и катайтесь по полу, чтобы потушиться, или переместитесь в вакуум."
	icon_state = "fire"

/obj/screen/alert/fire/Click()
	if(isliving(usr))
		var/mob/living/L = usr
		return L.resist()
// End of Bastion of Endeavor Translation


//ALIENS

/* Bastion of Endeavor Translation
/obj/screen/alert/alien_tox
	name = "Plasma"
	desc = "There's flammable plasma in the air. If it lights up, you'll be toast."
	icon_state = "alien_tox"
	alerttooltipstyle = "alien"

/obj/screen/alert/alien_fire
// This alert is temporarily gonna be thrown for all hot air but one day it will be used for literally being on fire
	name = "Too Hot"
	desc = "It's too hot! Flee to space or at least away from the flames. Standing on weeds will heal you."
	icon_state = "alien_fire"
	alerttooltipstyle = "alien"

/obj/screen/alert/alien_vulnerable
	name = "Severed Matriarchy"
	desc = "Your queen has been killed, you will suffer movement penalties and loss of hivemind. A new queen cannot be made until you recover."
	icon_state = "alien_noqueen"
	alerttooltipstyle = "alien"
*/
/obj/screen/alert/alien_tox
	name = "Плазма"
	desc = "В воздухе воспламеняемая плазма. Если она загорится, Вам не жить."
	icon_state = "alien_tox"
	alerttooltipstyle = "alien"

/obj/screen/alert/alien_fire
	name = "Слишком жарко"
	desc = "Горячо! Вам необходимо отдалиться от огня. Вы восстановите здоровье, если встанете на сорняки."
	icon_state = "alien_fire"
	alerttooltipstyle = "alien"

/obj/screen/alert/alien_vulnerable
	name = "Свергнутый матриархат"
	desc = "Ваша королева была убита, поэтому Ваше передвижение затруднено, а коллективный разум — утрачен. Пока Вы не восстановитесь, новой королевы не будет."
	icon_state = "alien_noqueen"
	alerttooltipstyle = "alien"
// End of Bastion of Endeavor Translation

//BLOBS

/* Bastion of Endeavor Translation
/obj/screen/alert/nofactory
	name = "No Factory"
	desc = "You have no factory, and are slowly dying!"
	icon_state = "blobbernaut_nofactory"
	alerttooltipstyle = "blob"
*/
/obj/screen/alert/nofactory
	name = "Нет источника"
	desc = "У Вас нет источника, в связи с чем Вы медленно умираете!"
	icon_state = "blobbernaut_nofactory"
	alerttooltipstyle = "blob"
// End of Bastion of Endeavor Translation

//SILICONS

/* Bastion of Endeavor Translation
/obj/screen/alert/nocell
	name = "Missing Power Cell"
	desc = "Unit has no power cell. No modules available until a power cell is reinstalled. Robotics may provide assistance."
	icon_state = "nocell"

/obj/screen/alert/emptycell
	name = "Out of Power"
	desc = "Unit's power cell has no charge remaining. No modules available until power cell is recharged. \
Recharging stations are available in robotics, the dormitory bathrooms, and the AI satellite."
	icon_state = "emptycell"

/obj/screen/alert/lowcell
	name = "Low Charge"
	desc = "Unit's power cell is running low. Recharging stations are available in robotics, the dormitory bathrooms, and the AI satellite."
	icon_state = "lowcell"

//Need to cover all use cases - emag, illegal upgrade module, malf AI hack, traitor cyborg
/obj/screen/alert/hacked
	name = "Hacked"
	desc = "Hazardous non-standard equipment detected. Please ensure any usage of this equipment is in line with unit's laws, if any."
	icon_state = "hacked"
	no_underlay = TRUE

/obj/screen/alert/locked
	name = "Locked Down"
	desc = "Unit has been remotely locked down. Usage of a Robotics Control Console like the one in the Research Director's \
office by your AI master or any qualified human may resolve this matter. Robotics may provide further assistance if necessary."
	icon_state = "locked"
	no_underlay = TRUE

/obj/screen/alert/newlaw
	name = "Law Update"
	desc = "Laws have potentially been uploaded to or removed from this unit. Please be aware of any changes \
so as to remain in compliance with the most up-to-date laws."
	icon_state = "newlaw"
	timeout = 300
	no_underlay = TRUE
*/
/obj/screen/alert/nocell
	name = "Нет батарейки"
	desc = "Юнит не обладает батарейкой. Модули недоступны. Робототехник может оказать с этим помощь."
	icon_state = "nocell"

/obj/screen/alert/emptycell
	name = "Нет заряда"
	desc = "Батарейка юнита полностью разряжена. Модули недоступны. Зарядные станции доступны в робототехнике, уборных при дормиториях и на спутнике ИИ."
	icon_state = "emptycell"

/obj/screen/alert/lowcell
	name = "Низкий заряд"
	desc = "Батарейка юнита почти разряжена. Зарядные станции доступны в робототехнике, уборных при дормиториях и на спутнике ИИ."
	icon_state = "lowcell"

/obj/screen/alert/hacked
	name = "Взлом"
	desc = "Обнаружено опасное оснащение. Убедитесь, что использование этого оснащения соблюдает законы юнита, если это применимо."
	icon_state = "hacked"
	no_underlay = TRUE

/obj/screen/alert/locked
	name = "Отключение"
	desc = "Юнит был удалённо отключён. Эту проблему можно устранить при помощи Робототехнической Панели Управления в кабинете Директора исследований \
и квалифицированного работника или ИИ. При необходимости оказать помощь может робототехник."
	icon_state = "locked"
	no_underlay = TRUE

/obj/screen/alert/newlaw
	name = "Обновление законов"
	desc = "Обнаружено изменение перечня законов данного юнита. Убедитесь, что Вы соблюдаете законы обновлённой версии перечня."
	icon_state = "newlaw"
	timeout = 300
	no_underlay = TRUE
// End of Bastion of Endeavor Translation

//MECHS

/* Bastion of Endeavor Translation
/obj/screen/alert/low_mech_integrity
	name = "Mech Damaged"
	desc = "Mech integrity is low."
	icon_state = "low_mech_integrity"
*/
/obj/screen/alert/low_mech_integrity
	name = "Мех повреждён"
	desc = "Низкая целостность меха."
	icon_state = "low_mech_integrity"
// End of Bastion of Endeavor Translation


//GHOSTS
//TODO: expand this system to replace the pollCandidates/CheckAntagonist/"choose quickly"/etc Yes/No messages
/* Bastion of Endeavor Translation
/obj/screen/alert/notify_cloning
	name = "Revival"
	desc = "Someone is trying to revive you. Re-enter your corpse if you want to be revived!"
*/
	name = "Реанимация"
	desc = "Кто-то пытается реанимировать Вас. Войдите в своё тело, если хотите вернуться к жизни!"
// End of Bastion of Endeavor Translation
	icon_state = "template"
	timeout = 300

/obj/screen/alert/notify_cloning/Click()
	if(!usr || !usr.client) return
	var/mob/observer/dead/G = usr
	G.reenter_corpse()

// /obj/screen/alert/notify_jump
// 	name = "Body created"
// 	desc = "A body was created. You can enter it."
// 	icon_state = "template"
// 	timeout = 300
// 	var/atom/jump_target = null
// 	var/attack_not_jump = null

// /obj/screen/alert/notify_jump/Click()
// 	if(!usr || !usr.client) return
// 	if(!jump_target) return
// 	var/mob/dead/observer/G = usr
// 	if(!istype(G)) return
// 	if(attack_not_jump)
// 		jump_target.attack_ghost(G)
// 	else
// 		var/turf/T = get_turf(jump_target)
// 		if(T && isturf(T))
// 			G.loc = T

//OBJECT-BASED

/* Bastion of Endeavor Translation
/obj/screen/alert/restrained/buckled
	name = "Buckled"
	desc = "You've been buckled to something. Click the alert to unbuckle unless you're handcuffed."

/obj/screen/alert/restrained/handcuffed
	name = "Handcuffed"
	desc = "You're handcuffed and can't act. If anyone drags you, you won't be able to move. Click the alert to free yourself."

/obj/screen/alert/restrained/legcuffed
	name = "Legcuffed"
	desc = "You're legcuffed, which slows you down considerably. Click the alert to free yourself."
*/ 
/obj/screen/alert/restrained/buckled
	name = "Положение сидя/лёжа"
	desc = "Вы находитесь в сидячем или лежачем положении. Нажмите на это уведомление, чтобы встать, если Ваши руки не связаны."

/obj/screen/alert/restrained/handcuffed
	name = "Связанные руки"
	desc = "Ваши руки связаны, и Ваши действия ограничены. Если Вас кто-то тащит, Вы не сможете шевелиться. Нажмите на это уведомление, чтобы высвободиться."

/obj/screen/alert/restrained/legcuffed
	name = "Связанные ноги"
	desc = "Ваши ноги связаны, и Ваше передвижение замедлено. Нажмите на это уведомление, чтобы высвободиться."
// End of Bastion of Endeavor Translation

/obj/screen/alert/restrained/Click()
	if(isliving(usr))
		var/mob/living/L = usr
		return L.resist()
// PRIVATE = only edit, use, or override these if you're editing the system as a whole

// Re-render all alerts - also called in /datum/hud/show_hud() because it's needed there
/datum/hud/proc/reorganize_alerts()
	var/list/alerts = mymob.alerts
	if(!hud_shown)
		for(var/i = 1, i <= alerts.len, i++)
			mymob.client.screen -= alerts[alerts[i]]
		return 1
	for(var/i = 1, i <= alerts.len, i++)
		var/obj/screen/alert/alert = alerts[alerts[i]]
		
		if(alert.icon_state in cached_icon_states(ui_style))
			alert.icon = ui_style
		
		else if(!alert.no_underlay)
			var/image/I = image(icon = ui_style, icon_state = "template")
			I.color = ui_color
			I.alpha = ui_alpha
			alert.underlays = list(I)
		
		switch(i)
			if(1)
				. = ui_alert1
			if(2)
				. = ui_alert2
			if(3)
				. = ui_alert3
			if(4)
				. = ui_alert4
			if(5)
				. = ui_alert5 // Right now there's 5 slots
			else
				. = ""
		alert.screen_loc = .
		mymob?.client?.screen |= alert
	return 1

/mob
	var/list/alerts = list() // contains /obj/screen/alert only // On /mob so clientless mobs will throw alerts properly

/obj/screen/alert/Click(location, control, params)
	if(!usr || !usr.client)
		return
	var/paramslist = params2list(params)
	if(paramslist["shift"]) // screen objects don't do the normal Click() stuff so we'll cheat
		to_chat(usr,"<span class='boldnotice'>[name]</span> - <span class='info'>[desc]</span>")
		return
	if(master)
		return usr.client.Click(master, location, control, params)

/obj/screen/alert/Destroy()
	..()
	severity = 0
	master = null
	screen_loc = ""
	return QDEL_HINT_QUEUE
