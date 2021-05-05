// This is a sort of successor to the various event systems created over the years.  It is designed to be just a tad smarter than the
// previous ones, checking various things like player count, department size and composition, individual player activity,
// individual player (IC) skill, and such, in order to try to choose the best events to take in order to add spice or variety to
// the round.

// This subsystem holds the logic that chooses events. Actual event processing is handled in a seperate subsystem.
SUBSYSTEM_DEF(game_master)
	/* Bastion of Endeavor Translation
	name = "Events (Game Master)"
	*/
	name = "Эвенты (Гейм Мастер)"
	// End of Bastion of Endeavor Translation
	wait = 1 MINUTE
	runlevels = RUNLEVEL_GAME

	// The GM object is what actually chooses events.
	// It's held in a seperate object for better encapsulation, and allows for different 'flavors' of GMs to be made, that choose events differently.
	var/datum/game_master/GM = null
	var/game_master_type = /datum/game_master/default

	var/list/available_events = list() // A list of meta event objects.

	var/danger = 0						// The GM's best guess at how chaotic the round is.  High danger makes it hold back.
	var/staleness = -20					// Determines liklihood of the GM doing something, increases over time.

	var/next_event = 0								// Minimum amount of time of nothingness until the GM can pick something again.

	var/debug_messages = FALSE // If true, debug information is written to `log_debug()`.

/datum/controller/subsystem/game_master/Initialize()
	var/list/subtypes = subtypesof(/datum/event2/meta)
	for(var/T in subtypes)
		var/datum/event2/meta/M = new T()
		if(!M.name)
			continue
		available_events += M

	GM = new game_master_type()

	if(config && !config.enable_game_master)
		can_fire = FALSE

	return ..()

/datum/controller/subsystem/game_master/fire(resumed)
	adjust_staleness(1)
	adjust_danger(-1)

	var/global_afk = metric.assess_all_living_mobs()
	global_afk = abs(global_afk - 100)
	global_afk = round(global_afk / 100, 0.1)
	adjust_staleness(global_afk) // Staleness increases faster if more people are less active.

	if(GM.ignore_time_restrictions || next_event < world.time)
		if(prob(staleness) && pre_event_checks())
			do_event_decision()


/datum/controller/subsystem/game_master/proc/do_event_decision()
	/* Bastion of Endeavor Translation
	log_game_master("Going to choose an event.")
	*/
	log_game_master("Сейчас будет выбран эвент.")
	// End of Bastion of Endeavor Translation
	var/datum/event2/meta/event_picked = GM.choose_event()
	if(event_picked)
		run_event(event_picked)
		next_event = world.time + rand(GM.decision_cooldown_lower_bound, GM.decision_cooldown_upper_bound)

/datum/controller/subsystem/game_master/proc/debug_gm()
	can_fire = TRUE
	staleness = 100
	debug_messages = TRUE

/datum/controller/subsystem/game_master/proc/run_event(datum/event2/meta/chosen_event)
	var/datum/event2/event/E = chosen_event.make_event()

	chosen_event.times_ran++

	if(!chosen_event.reusable)
		// Disable this event, so it only gets picked once.
		chosen_event.enabled = FALSE
		if(chosen_event.event_class)
			// Disable similar events, too.
			for(var/M in available_events)
				var/datum/event2/meta/meta = M
				if(meta.event_class == chosen_event.event_class)
					meta.enabled = FALSE

	SSevent_ticker.event_started(E)
	adjust_danger(chosen_event.chaos)
	adjust_staleness(-(10 + chosen_event.chaos)) // More chaotic events reduce staleness more, e.g. a 25 chaos event will reduce it by 35.


// Tell the game master that something dangerous happened, e.g. someone dying, station explosions.
/datum/controller/subsystem/game_master/proc/adjust_danger(amount)
	amount *= GM.danger_modifier
	danger = round(between(0, danger + amount, 1000), 0.1)

// Tell the game master that things are getting boring if positive, or something interesting if negative..
/datum/controller/subsystem/game_master/proc/adjust_staleness(amount)
	amount *= GM.staleness_modifier
	staleness = round( between(-20, staleness + amount, 100), 0.1)

// These are ran before committing to an event.
// Returns TRUE if the system is allowed to procede, otherwise returns FALSE.
/datum/controller/subsystem/game_master/proc/pre_event_checks(quiet = FALSE)
	if(!ticker || ticker.current_state != GAME_STATE_PLAYING)
		if(!quiet)
			/* Bastion of Endeavor Translation
			log_game_master("Unable to start event: Ticker is nonexistant, or the game is not ongoing.")
			*/
			log_game_master("Не удалось начать эвент: Отсутствует тикер, либо игра ещё не идёт.")
			// End of Bastion of Endeavor Translation
		return FALSE
	if(GM.ignore_time_restrictions)
		return TRUE
	if(next_event > world.time) // Sanity.
		if(!quiet)
			/* Bastion of Endeavor Translation
			log_game_master("Unable to start event: Time until next event is approximately [round((next_event - world.time) / (1 MINUTE))] minute(s)")
			*/
			log_game_master("Не удалось начать эвент: Время до следующего эвента приблизительно [ru_count(round((next_event - world.time) / (1 MINUTE)), "минута", "минуты", "минут")].")
			// End of Bastion of Endeavor Translation
		return FALSE

	// Last minute antagging is bad for humans to do, so the GM will respect the start and end of the round.
	var/mills = round_duration_in_ds
	var/mins = round((mills % 36000) / 600)
	var/hours = round(mills / 36000)

//	if(hours < 1 && mins <= 20) // Don't do anything for the first twenty minutes of the round.
//		if(!quiet)
//			log_debug("Game Master unable to start event: It is too early.")
//		return FALSE
	if(hours >= 2 && mins >= 40) // Don't do anything in the last twenty minutes of the round, as well.
		if(!quiet)
			/* Bastion of Endeavor Translation
			log_game_master("Unable to start event: It is too late.")
			*/
			log_game_master("Не удалось начать эвент: Слишком поздно.")
			// End of Bastion of Endeavor Translation
		return FALSE
	return TRUE

/datum/controller/subsystem/game_master/proc/choose_game_master(mob/user)
	var/list/subtypes = subtypesof(/datum/game_master)
	/* Bastion of Endeavor Translation
	var/new_gm_path = input(user, "What kind of Game Master do you want?", "New Game Master", /datum/game_master/default) as null|anything in subtypes
	if(new_gm_path)
		log_and_message_admins("has swapped the current GM ([GM.type]) for a new GM ([new_gm_path]).")
		GM = new new_gm_path(src)
	*/
	var/new_gm_path = input(user, "Какой Гейм Мастер Вам необходим?", "Новый Гейм Мастер", /datum/game_master/default) as null|anything in subtypes
	if(new_gm_path)
		log_and_message_admins("сменил текущий ГМ ([GM.type]) на новый ГМ ([new_gm_path]).")
		GM = new new_gm_path(src)
	// End of Bastion of Endeavor Translation

/datum/controller/subsystem/game_master/proc/log_game_master(message)
	if(debug_messages)
		/* Bastion of Endeavor Translation
		log_debug("GAME MASTER: [message]")
		*/
		log_debug("ГЕЙМ МАСТЕР: [message]")
		// End of Bastion of Endeavor Translation


// This object makes the actual decisions.
/datum/game_master
	// Multiplier for how much 'danger' is accumulated. Higer generally makes it possible for more dangerous events to be picked.
	var/danger_modifier = 1.0

	// Ditto.  Higher numbers generally result in more events occuring in a round.
	var/staleness_modifier = 1.0

	var/decision_cooldown_lower_bound = 5 MINUTES	// Lower bound for how long to wait until -the potential- for another event being decided.
	var/decision_cooldown_upper_bound = 20 MINUTES	// Same, but upper bound.

	var/ignore_time_restrictions = FALSE 	// Useful for debugging without needing to wait 20 minutes each time.
	var/ignore_round_chaos = FALSE			// If true, the system will happily choose back to back intense events like meteors and blobs, Dwarf Fortress style.

/client/proc/show_gm_status()
	/* Bastion of Endeavor Translation
	set category = "Debug"
	set name = "Show GM Status"
	set desc = "Shows you what the GM is thinking.  If only that existed in real life..."

	if(check_rights(R_ADMIN|R_EVENT|R_DEBUG))
		SSgame_master.interact(usr)
	else
		to_chat(usr, span("warning", "You do not have sufficent rights to view the GM panel, sorry."))
	*/
	set category = "Дебаг"
	set name = "Показать Статус ГМ"
	set desc = "Показывает, о чём думает ГМ. Вот бы в жизни такое..."

	if(check_rights(R_ADMIN|R_EVENT|R_DEBUG))
		SSgame_master.interact(usr)
	else
		to_chat(usr, span("warning", "К сожалению, у Вас недостаточно прав для просмотра панели ГМ."))
	// End of Bastion of Endeavor Translation

/datum/controller/subsystem/game_master/proc/interact(var/client/user)
	if(!user)
		return

	/* Bastion of Endeavor Translation: Imagine bloating the code like this only to find out this entire file is unticked.
	// Using lists for string tree conservation.
	var/list/dat = list("<html><head><title>Automated Game Master Event System</title></head><body>")

	// Makes the system turn on or off.
	dat += href(src, list("toggle" = 1), "\[Toggle GM\]")
	dat += " | "

	// Makes the system not care about staleness or being near round-end.
	dat += href(src, list("toggle_time_restrictions" = 1), "\[Toggle Time Restrictions\]")
	dat += " | "

	// Makes the system not care about how chaotic the round might be.
	dat += href(src, list("toggle_chaos_throttle" = 1), "\[Toggle Chaos Throttling\]")
	dat += " | "

	// Makes the system immediately choose an event, while still bound to factors like danger, weights, and department staffing.
	dat += href(src, list("force_choose_event" = 1), "\[Force Event Decision\]")
	dat += "<br>"

	// Swaps out the current GM for a new one with different ideas on what a good event might be.
	dat += href(src, list("change_gm" = 1), "\[Change GM\]")
	dat += "<br>"

	dat += "Current GM Type: [GM.type]<br>"
	dat += "State: [can_fire ? "Active": "Inactive"]<br>"
	dat += "Status: [pre_event_checks(TRUE) ? "Ready" : "Suppressed"]<br><br>"

	dat += "Staleness: [staleness] "
	dat += href(src, list("set_staleness" = 1), "\[Set\]")
	dat += "<br>"
	dat += "<i>Staleness is an estimate of how boring the round might be, and if an event should be done. It is increased passively over time, \
	and increases faster if people are AFK. It deceases when events and certain 'interesting' things happen in the round.</i><br>"

	dat += "Danger: [danger] "
	dat += href(src, list("set_danger" = 1), "\[Set\]")
	dat += "<br>"
	dat += "<i>Danger is an estimate of how chaotic the round has been so far. It is decreased passively over time, and is increased by having \
	certain chaotic events be selected, or chaotic things happen in the round. A sufficently high amount of danger will make the system \
	avoid using destructive events, to avoid pushing the station over the edge.</i><br>"

	dat += "<h2>Player Activity:</h2>"

	dat += "<table border='1' style='width:100%'>"
	dat += "<tr>"
	dat += "<th>Category</th>"
	dat += "<th>Activity Percentage</th>"
	dat += "</tr>"

	dat += "<tr>"
	dat += "<td>All Living Mobs</td>"
	dat += "<td>[metric.assess_all_living_mobs()]%</td>"
	dat += "</tr>"

	dat += "<tr>"
	dat += "<td>All Ghosts</td>"
	dat += "<td>[metric.assess_all_dead_mobs()]%</td>"
	dat += "</tr>"

	dat += "<tr>"
	dat += "<th colspan='2'>Departments</td>"
	dat += "</tr>"

	for(var/D in metric.departments)
		dat += "<tr>"
		dat += "<td>[D]</td>"
		dat += "<td>[metric.assess_department(D)]%</td>"
		dat += "</tr>"

	dat += "<tr>"
	dat += "<th colspan='2'>Players</td>"
	dat += "</tr>"

	for(var/P in player_list)
		var/mob/M = P
		dat += "<tr>"
		dat += "<td>[M] ([M.ckey])</td>"
		dat += "<td>[metric.assess_player_activity(M)]%</td>"
		dat += "</tr>"
	dat += "</table>"

	dat += "<h2>Events available:</h2>"

	dat += "<table border='1' style='width:100%'>"
	dat += "<tr>"
	dat += "<th>Event Name</th>"
	dat += "<th>Involved Departments</th>"
	dat += "<th>Chaos</th>"
	dat += "<th>Chaotic Threshold</th>"
	dat += "<th>Weight</th>"
	dat += "<th>Buttons</th>"
	dat += "</tr>"

	for(var/E in available_events)
		var/datum/event2/meta/event = E
		dat += "<tr>"
		if(!event.enabled)
			dat += "<td><strike>[event.name]</strike></td>"
		else
			dat += "<td>[event.name]</td>"
		dat += "<td>[english_list(event.departments)]</td>"
		dat += "<td>[event.chaos]</td>"
		dat += "<td>[event.chaotic_threshold]</td>"
		dat += "<td>[event.get_weight()]</td>"
		dat += "<td>[href(event, list("force" = 1), "\[Force\]")] [href(event, list("toggle" = 1), "\[Toggle\]")]</td>"
		dat += "</tr>"
	dat += "</table>"

	dat += "<h2>Events active:</h2>"

	dat += "Current time: [world.time]"
	dat += "<table border='1' style='width:100%'>"
	dat += "<tr>"
	dat += "<th>Event Type</th>"
	dat += "<th>Time Started</th>"
	dat += "<th>Time to Announce</th>"
	dat += "<th>Time to End</th>"
	dat += "<th>Announced</th>"
	dat += "<th>Started</th>"
	dat += "<th>Ended</th>"
	dat += "<th>Buttons</th>"
	dat += "</tr>"

	for(var/E in SSevent_ticker.active_events)
		var/datum/event2/event/event = E
		dat += "<tr>"
		dat += "<td>[event.type]</td>"
		dat += "<td>[event.time_started]</td>"
		dat += "<td>[event.time_to_announce ? event.time_to_announce : "NULL"]</td>"
		dat += "<td>[event.time_to_end ? event.time_to_end : "NULL"]</td>"
		dat += "<td>[event.announced ? "Yes" : "No"]</td>"
		dat += "<td>[event.started ? "Yes" : "No"]</td>"
		dat += "<td>[event.ended ? "Yes" : "No"]</td>"
		dat += "<td>[href(event, list("abort" = 1), "\[Abort\]")]</td>"
		dat += "</tr>"
	dat += "</table>"
	dat += "</body></html>"

	dat += "<h2>Events completed:</h2>"

	dat += "<table border='1' style='width:100%'>"
	dat += "<tr>"
	dat += "<th>Event Type</th>"
	dat += "<th>Start Time</th>"
	dat += "<th>Finish Time</th>"
	dat += "</tr>"

	for(var/E in SSevent_ticker.finished_events)
		var/datum/event2/event/event = E
		dat += "<tr>"
		dat += "<td>[event.type]</td>"
		dat += "<td>[event.time_started]</td>"
		dat += "<td>[event.time_finished]</td>"
		dat += "</tr>"

	dat += "</body></html>"

	var/datum/browser/popup = new(user, "game_master_debug", "Automated Game Master Event System", 800, 500, src)
	popup.set_content(dat.Join())
	popup.open()
	*/
	// Using lists for string tree conservation.
	var/list/dat = list("<html><head><meta charset=\"UTF-8\"><title>Автоматическая Система Гейм Мастера Эвентов</title></head><body>")

	// Makes the system turn on or off.
	dat += href(src, list("toggle" = 1), "\[Переключить ГМ\]")
	dat += " | "

	// Makes the system not care about staleness or being near round-end.
	dat += href(src, list("toggle_time_restrictions" = 1), "\[Переключить ограничение по времени\]")
	dat += " | "

	// Makes the system not care about how chaotic the round might be.
	dat += href(src, list("toggle_chaos_throttle" = 1), "\[Переключить ограничение хаоса\]")
	dat += " | "

	// Makes the system immediately choose an event, while still bound to factors like danger, weights, and department staffing.
	dat += href(src, list("force_choose_event" = 1), "\[Принудить к выбору эвента\]")
	dat += "<br>"

	// Swaps out the current GM for a new one with different ideas on what a good event might be.
	dat += href(src, list("change_gm" = 1), "\[Изменить ГМ\]")
	dat += "<br>"

	dat += "Тип текущего ГМ: [GM.type]<br>"
	dat += "Состояние: [can_fire ? "Активен": "Неактивен"]<br>"
	dat += "Статус: [pre_event_checks(TRUE) ? "Готов" : "Подавлен"]<br><br>"

	dat += "Скука: [staleness] "
	dat += href(src, list("set_staleness" = 1), "\[Установить\]")
	dat += "<br>"
	dat += "<i>Показатель скуки отражает, настолько застоялым может быть раунд, и стоит ли проводить эвент. Она увеличивается со временем, особенно когда люди стоят в АФК. \
	Она уменьшается, когда происходят эвенты и другие 'интересные' вещи.</i><br>"

	dat += "Опасность: [danger] "
	dat += href(src, list("set_danger" = 1), "\[Установить\]")
	dat += "<br>"
	dat += "<i>Опасность отражает, насколько раунд был до этого момента хаотичным. Она уменьшается со временем, и увеличивается, когда \
	выбираются хаотичные эвенты или происходят хаотичные вещи. Чрезмерно высокое значение принудит систему избегать деструктивные эвенты, дабы слишком сильно не душить станцию.</i><br>"

	dat += "<h2>Игровая активность:</h2>"

	dat += "<table border='1' style='width:100%'>"
	dat += "<tr>"
	dat += "<th>Категория</th>"
	dat += "<th>Процент активности</th>"
	dat += "</tr>"

	dat += "<tr>"
	dat += "<td>Все живые мобы</td>"
	dat += "<td>[metric.assess_all_living_mobs()]%</td>"
	dat += "</tr>"

	dat += "<tr>"
	dat += "<td>Все призраки</td>"
	dat += "<td>[metric.assess_all_dead_mobs()]%</td>"
	dat += "</tr>"

	dat += "<tr>"
	dat += "<th colspan='2'>Отделы</td>"
	dat += "</tr>"

	for(var/D in metric.departments)
		dat += "<tr>"
		dat += "<td>[D]</td>"
		dat += "<td>[metric.assess_department(D)]%</td>"
		dat += "</tr>"

	dat += "<tr>"
	dat += "<th colspan='2'>Игроки</td>"
	dat += "</tr>"

	for(var/P in player_list)
		var/mob/M = P
		dat += "<tr>"
		dat += "<td>[M] ([M.ckey])</td>"
		dat += "<td>[metric.assess_player_activity(M)]%</td>"
		dat += "</tr>"
	dat += "</table>"

	dat += "<h2>Доступные эвенты:</h2>"

	dat += "<table border='1' style='width:100%'>"
	dat += "<tr>"
	dat += "<th>Название эвента</th>"
	dat += "<th>Участвующие отделы</th>"
	dat += "<th>Хаос</th>"
	dat += "<th>Хаотический лимит</th>"
	dat += "<th>Вес</th>"
	dat += "<th>Кнопки</th>"
	dat += "</tr>"

	for(var/E in available_events)
		var/datum/event2/meta/event = E
		dat += "<tr>"
		if(!event.enabled)
			dat += "<td><strike>[event.name]</strike></td>"
		else
			dat += "<td>[event.name]</td>"
		dat += "<td>[english_list(event.departments)]</td>"
		dat += "<td>[event.chaos]</td>"
		dat += "<td>[event.chaotic_threshold]</td>"
		dat += "<td>[event.get_weight()]</td>"
		dat += "<td>[href(event, list("force" = 1), "\[Принудить\]")] [href(event, list("toggle" = 1), "\[Переключить\]")]</td>"
		dat += "</tr>"
	dat += "</table>"

	dat += "<h2>Активные эвенты:</h2>"

	dat += "Текущее время: [world.time]"
	dat += "<table border='1' style='width:100%'>"
	dat += "<tr>"
	dat += "<th>Тип эвента</th>"
	dat += "<th>Время запуска</th>"
	dat += "<th>Время объявления</th>"
	dat += "<th>Время окончания</th>"
	dat += "<th>Объявлен</th>"
	dat += "<th>Начат</th>"
	dat += "<th>Завершен</th>"
	dat += "<th>Кнопки</th>"
	dat += "</tr>"

	for(var/E in SSevent_ticker.active_events)
		var/datum/event2/event/event = E
		dat += "<tr>"
		dat += "<td>[event.type]</td>"
		dat += "<td>[event.time_started]</td>"
		dat += "<td>[event.time_to_announce ? event.time_to_announce : "НЕТ"]</td>"
		dat += "<td>[event.time_to_end ? event.time_to_end : "НЕТ"]</td>"
		dat += "<td>[event.announced ? "Да" : "Нет"]</td>"
		dat += "<td>[event.started ? "Да" : "Нет"]</td>"
		dat += "<td>[event.ended ? "Да" : "Нет"]</td>"
		dat += "<td>[href(event, list("abort" = 1), "\[Прекратить\]")]</td>"
		dat += "</tr>"
	dat += "</table>"
	dat += "</body></html>"

	dat += "<h2>Завершенные эвенты:</h2>"

	dat += "<table border='1' style='width:100%'>"
	dat += "<tr>"
	dat += "<th>Тип эвента</th>"
	dat += "<th>Дата начала</th>"
	dat += "<th>Дата окончания</th>"
	dat += "</tr>"

	for(var/E in SSevent_ticker.finished_events)
		var/datum/event2/event/event = E
		dat += "<tr>"
		dat += "<td>[event.type]</td>"
		dat += "<td>[event.time_started]</td>"
		dat += "<td>[event.time_finished]</td>"
		dat += "</tr>"

	dat += "</body></html>"

	var/datum/browser/popup = new(user, "game_master_debug", "Автоматическая Система Гейм Мастера Эвентов", 800, 500, src)
	popup.set_content(dat.Join())
	popup.open()
	// End of Bastion of Endeavor Translation


/datum/controller/subsystem/game_master/Topic(href, href_list)
	if(..())
		return

	if(href_list["close"]) // Needed or the window re-opens after closing, making it last forever.
		return

	/* Bastion of Endeavor Translation
	if(!check_rights(R_ADMIN|R_EVENT|R_DEBUG))
		message_admins("[usr] has attempted to modify the Game Master values without sufficent privilages.")
		return

	if(href_list["toggle"])
		can_fire = !can_fire
		message_admins("GM was [!can_fire ? "dis" : "en"]abled by [usr.key].")

	if(href_list["toggle_time_restrictions"])
		GM.ignore_time_restrictions = !GM.ignore_time_restrictions
		message_admins("GM event time restrictions was [GM.ignore_time_restrictions ? "dis" : "en"]abled by [usr.key].")

	if(href_list["toggle_chaos_throttle"])
		GM.ignore_round_chaos = !GM.ignore_round_chaos
		message_admins("GM event chaos restrictions was [GM.ignore_round_chaos ? "dis" : "en"]abled by [usr.key].")

	if(href_list["force_choose_event"])
		do_event_decision()
		message_admins("[usr.key] forced the Game Master to choose an event immediately.")

	if(href_list["change_gm"])
		choose_game_master(usr)

	if(href_list["set_staleness"])
		var/amount = input(usr, "How much staleness should there be?", "Game Master") as null|num
		if(!isnull(amount))
			staleness = amount
			message_admins("GM staleness was set to [amount] by [usr.key].")

	if(href_list["set_danger"])
		var/amount = input(usr, "How much danger should there be?", "Game Master") as null|num
		if(!isnull(amount))
			danger = amount
			message_admins("GM danger was set to [amount] by [usr.key].")
	*/
	if(!check_rights(R_ADMIN|R_EVENT|R_DEBUG))
		message_admins("[usr] попытался изменить значения в Гейм Мастере без необходимых прав.")
		return

	if(href_list["toggle"])
		can_fire = !can_fire
		message_admins("[usr.key] [!can_fire ? "от" : "в"]ключил Гейм Мастер.")

	if(href_list["toggle_time_restrictions"])
		GM.ignore_time_restrictions = !GM.ignore_time_restrictions
		message_admins("[usr.key] [GM.ignore_time_restrictions ? "от" : "в"]ключил ограничения по времени для Гейм Мастера.")

	if(href_list["toggle_chaos_throttle"])
		GM.ignore_round_chaos = !GM.ignore_round_chaos
		message_admins("[usr.key] [GM.ignore_round_chaos ? "от" : "в"]ключил ограничения по хаосу для Гейм Мастера.")

	if(href_list["force_choose_event"])
		do_event_decision()
		message_admins("[usr.key] принудил Гейм Мастер сейчас выбрать эвент.")

	if(href_list["change_gm"])
		choose_game_master(usr)

	if(href_list["set_staleness"])
		var/amount = input(usr, "Каков должен быть показатель скуки?", "Гейм Мастер") as null|num
		if(!isnull(amount))
			staleness = amount
			message_admins("[usr.key] установил показатель скуки Гейм Мастера на [amount].")

	if(href_list["set_danger"])
		var/amount = input(usr, "Каков должен быть показатель опасности?", "Гейм Мастер") as null|num
		if(!isnull(amount))
			danger = amount
			message_admins("[usr.key] установил показатель опасности Гейм Мастера на [amount].")
	// End of Bastion of Endeavor Translation

	interact(usr) // To refresh the UI.