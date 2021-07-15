// The default game master tries to choose events with these goals in mind.
// * Don't choose an event if the crew can't take it. E.g. no meteors after half of the crew died.
// * Try to involve lots of people, particuarly in active departments.
// * Avoid giving events to the same department multiple times in a row.
/datum/game_master/default
	// If an event was done for a specific department, it is written here, so it doesn't do it again.
	var/last_department_used = null


/datum/game_master/default/choose_event()
	/* Bastion of Endeavor Translation: Look, let me be clear. I have absolutely no telling if this will be ticked in the future.
	log_game_master("Now starting event decision.")
	*/
	log_game_master("Начинается выбор эвента.")
	// End of Bastion of Endeavor Translation

	var/list/most_active_departments = metric.assess_all_departments(3, list(last_department_used))
	var/list/best_events = decide_best_events(most_active_departments)

	if(LAZYLEN(best_events))
		/* Bastion of Endeavor Translation
		log_game_master("Got [best_events.len] choice\s for the next event.")
		*/
		log_game_master("[best_events.len==1? "Найден" : "Найдено"] [ru_count(best_events.len, "вариант", "варианта", "вариантов")] на следующий эвент.")
		// End of Bastion of Endeavor Translation
		var/list/weighted_events = list()

		for(var/E in best_events)
			var/datum/event2/meta/event = E
			var/weight = event.get_weight()
			if(weight <= 0)
				continue
			weighted_events[event] = weight
		/* Bastion of Endeavor Translation
		log_game_master("Filtered down to [weighted_events.len] choice\s.")
		*/
		log_game_master("[weighted_events.len==1? "Остался" : "Осталось"] [ru_count(weighted_events.len, "вариант", "варианта", "вариантов")] на следующий эвент после фильтрации.")
		// End of Bastion of Endeavor Translation

		var/datum/event2/meta/choice = pickweight(weighted_events)

		if(choice)
			/* Bastion of Endeavor Translation
			log_game_master("[choice.name] was chosen, and is now being ran.")
			*/
			log_game_master("Выбран и запущен эвент [choice.name].")
			// End of Bastion of Endeavor Translation
			last_department_used = LAZYACCESS(choice.departments, 1)
			return choice

/datum/game_master/default/proc/decide_best_events(list/most_active_departments)
	if(!LAZYLEN(most_active_departments)) // Server's empty?
		/* Bastion of Endeavor Translation
		log_game_master("Game Master failed to find any active departments.")
		*/
		log_game_master("Гейм Мастер не нашел никаких активных отделов.")
		// End of Bastion of Endeavor Translation
		return list()

	var/list/best_events = list()
	if(most_active_departments.len >= 2)
		var/list/top_two = list(most_active_departments[1], most_active_departments[2])
		best_events = filter_events_by_departments(top_two)

		if(LAZYLEN(best_events)) // We found something for those two, let's do it.
			return best_events

	// Otherwise we probably couldn't find something for the second highest group, so let's ignore them.
	best_events = filter_events_by_departments(most_active_departments[1])

	if(LAZYLEN(best_events))
		return best_events

	// At this point we should expand our horizons.
	best_events = filter_events_by_departments(list(DEPARTMENT_EVERYONE))

	if(LAZYLEN(best_events))
		return best_events

	// Just give a random event if for some reason it still can't make up its mind.
	best_events = filter_events_by_departments()

	if(LAZYLEN(best_events))
		return best_events

	/* Bastion of Endeavor Translation
	log_game_master("Game Master failed to find a suitable event, something very wrong is going on.")
	*/
	log_game_master("Гейм Мастер не смог найти подходящий эвент, что-то пошло не так.")
	// End of Bastion of Endeavor Translation
	return list()

// Filters the available events down to events for specific departments.
// Pass DEPARTMENT_EVERYONE if you want events that target the general population, like gravity failure.
// If no list is passed, all the events will be returned.
/datum/game_master/default/proc/filter_events_by_departments(list/departments)
	. = list()
	for(var/E in SSgame_master.available_events)
		var/datum/event2/meta/event = E
		if(!event.enabled)
			continue
		if(event.chaotic_threshold && !ignore_round_chaos)
			if(SSgame_master.danger > event.chaotic_threshold)
				continue
		// An event has to involve all of these departments to pass.
		var/viable = TRUE
		if(LAZYLEN(departments))
			for(var/department in departments)
				if(!LAZYFIND(departments, department))
					viable = FALSE
					break
		if(viable)
			. += event
