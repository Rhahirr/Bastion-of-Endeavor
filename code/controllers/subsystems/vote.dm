SUBSYSTEM_DEF(vote)
	/* Bastion of Endeavor Translation
	name = "Vote"
	*/
	name = "Голосование"
	// End of Bastion of Endeavor Translation
	wait = 10
	priority = FIRE_PRIORITY_VOTE
	runlevels = RUNLEVEL_LOBBY | RUNLEVELS_DEFAULT
	flags = SS_KEEP_TIMING | SS_NO_INIT
	var/list/round_voters = list()

	//Current vote
	var/initiator
	var/started_time
	var/time_remaining
	var/duration
	var/mode
	var/question
	var/gamemode_vote_called = FALSE // Have we had a gamemode vote this round?  Only auto-call if we haven't
	var/list/choices = list()
	var/list/gamemode_names = list()
	var/list/voted = list()
	var/list/current_votes = list()
	var/list/additional_text = list()

/datum/controller/subsystem/vote/fire(resumed)
	if(mode)
		time_remaining = round((started_time + duration - world.time)/10)
		if(mode == VOTE_GAMEMODE && ticker.current_state >= GAME_STATE_SETTING_UP)
			/* Bastion of Endeavor Translation
			to_chat(world, "<b>Gamemode vote aborted: Game has already started.</b>")
			*/
			to_chat(world, "<b>Голосование за режим игры отменено: игра уже началась.</b>")
			// End of Bastion of Endeavor Translation
			reset()
			return
		if(time_remaining <= 0)
			result()
			reset()

/datum/controller/subsystem/vote/proc/autotransfer()
	// Before doing the vote, see if anyone is playing.
	// If not, just do the transfer.
	var/players_are_in_round = FALSE
	for(var/a in player_list) // Mobs with clients attached.
		var/mob/living/L = a
		if(!istype(L)) // Exclude ghosts and other weird things.
			continue
		if(L.stat == DEAD) // Dead mobs aren't playing.
			continue
		// Everything else is, however.
		players_are_in_round = TRUE
		break

	/* Bastion of Endeavor Translation
	if(!players_are_in_round)
		log_debug("The crew transfer shuttle was automatically called at vote time due to no players being present.")
		init_shift_change(null, 1)
		return

	initiate_vote(VOTE_CREW_TRANSFER, "the server", 1)
	log_debug("The server has called a crew transfer vote.")
	*/
	if(!players_are_in_round)
		log_debug("Шаттл трансфера персонала был автоматически вызван во время голосания в связи с отсутствием игроков.")
		init_shift_change(null, 1)
		return

	initiate_vote(VOTE_CREW_TRANSFER, "Сервер", 1)
	log_debug("Сервер инициировал голосование за трансфер персонала.")
	// End of Bastion of Endeavor Translation

/datum/controller/subsystem/vote/proc/autogamemode()
	/* Bastion of Endeavor Translation
	initiate_vote(VOTE_GAMEMODE, "the server", 1)
	log_debug("The server has called a gamemode vote.")
	*/
	initiate_vote(VOTE_GAMEMODE, "Сервер", 1)
	log_debug("Сервер инициировал голосование за режим игры.")
	// End of Bastion of Endeavor Translation

/datum/controller/subsystem/vote/proc/reset()
	initiator = null
	started_time = null
	duration = null
	time_remaining = null
	mode = null
	question = null
	choices.Cut()
	voted.Cut()
	current_votes.Cut()
	additional_text.Cut()

/datum/controller/subsystem/vote/proc/get_result() // Get the highest number of votes
	var/greatest_votes = 0
	var/total_votes = 0

	for(var/option in choices)
		var/votes = choices[option]
		total_votes += votes
		if(votes > greatest_votes)
			greatest_votes = votes

	if(!config.vote_no_default && choices.len) // Default-vote for everyone who didn't vote
		var/non_voters = (GLOB.clients.len - total_votes)
		if(non_voters > 0)
			if(mode == VOTE_RESTART)
				/* Bastion of Endeavor Translation
				choices["Continue Playing"] += non_voters
				if(choices["Continue Playing"] >= greatest_votes)
					greatest_votes = choices["Continue Playing"]
				*/
				choices["Продолжить игру"] += non_voters
				if(choices["Продолжить игру"] >= greatest_votes)
					greatest_votes = choices["Продолжить игру"]
				// End of Bastion of Endeavor Translation
			else if(mode == VOTE_GAMEMODE)
				if(master_mode in choices)
					choices[master_mode] += non_voters
					if(choices[master_mode] >= greatest_votes)
						greatest_votes = choices[master_mode]
			else if(mode == VOTE_CREW_TRANSFER)
				var/factor = 0.5
				switch(world.time / (10 * 60)) // minutes
					if(0 to 60)
						factor = 0.5
					if(61 to 120)
						factor = 0.8
					if(121 to 240)
						factor = 1
					if(241 to 300)
						factor = 1.2
					else
						factor = 1.4
				/* Bastion of Endeavor Translation
				choices["Initiate Crew Transfer"] = round(choices["Initiate Crew Transfer"] * factor)
				to_world("<font color='purple'>Crew Transfer Factor: [factor]</font>")
				greatest_votes = max(choices["Initiate Crew Transfer"], choices["Extend the Shift"]) //VOREStation Edit
				*/
				choices["Начать трансфер персонала"] = round(choices["Начать трансфер персонала"] * factor)
				to_world("<font color='purple'>Фактор трансфера персонала: [factor]</font>")
				greatest_votes = max(choices["Начать трансфер персонала"], choices["Продлить смену"]) //VOREStation Edit
				// End of Bastion of Endeavor Translation

	. = list() // Get all options with that many votes and return them in a list
	if(greatest_votes)
		for(var/option in choices)
			if(choices[option] == greatest_votes)
				. += option

/datum/controller/subsystem/vote/proc/announce_result()
	var/list/winners = get_result()
	var/text
	if(winners.len > 0)
		if(winners.len > 1)
			if(mode != VOTE_GAMEMODE || ticker.hide_mode == 0) // Here we are making sure we don't announce potential game modes
				/* Bastion of Endeavor Translation
				text = "<b>Vote Tied Between:</b>\n"
				*/
				text = "<b>Голосование завершилось ничьёй между:</b>\n"
				// End of Bastion of Endeavor Translation
				for(var/option in winners)
					text += "\t[option]\n"
		. = pick(winners)

		for(var/key in current_votes)
			if(choices[current_votes[key]] == .)
				round_voters += key // Keep track of who voted for the winning round.
		/* Bastion of Endeavor Translation
		if(mode != VOTE_GAMEMODE || . == "Extended" || ticker.hide_mode == 0) // Announce Extended gamemode, but not other gamemodes
			text += "<b>Vote Result: [mode == VOTE_GAMEMODE ? gamemode_names[.] : .]</b>"
		else
			text += "<b>The vote has ended.</b>"
		*/
		if(mode != VOTE_GAMEMODE || . == "Длительный" || ticker.hide_mode == 0) // Announce Extended gamemode, but not other gamemodes
			text += "<b>Результат голосования: [mode == VOTE_GAMEMODE ? gamemode_names[.] : .]</b>"
		else
			text += "<b>Голосование завершено.</b>"
		// End of Bastion of Endeavor Translation

	else
		/* Bastion of Endeavor Translation
		text += "<b>Vote Result: Inconclusive - No Votes!</b>"
		*/
		text += "<b>Результат голосования не определён — нет голосов!</b>"
		// End of Bastion of Endeavor Translation
		if(mode == VOTE_ADD_ANTAGONIST)
			antag_add_failed = 1
	log_vote(text)
	to_chat(world, "<font color='purple'>[text]</font>")

/datum/controller/subsystem/vote/proc/result()
	. = announce_result()
	var/restart = 0
	if(.)
		switch(mode)
			if(VOTE_RESTART)
				/* Bastion of Endeavor Translation
				if(. == "Restart Round")
				*/
				if(. == "Перезапустить раунд")
				// End of Bastion of Endeavor Translation
					restart = 1
			if(VOTE_GAMEMODE)
				if(master_mode != .)
					world.save_mode(.)
					if(ticker && ticker.mode)
						restart = 1
					else
						master_mode = .
			if(VOTE_CREW_TRANSFER)
				/* Bastion of Endeavor Translation
				if(. == "Initiate Crew Transfer")
				*/
				if(. == "Начать трансфер пероснала")
				// End of Bastion of Endeavor Translation
					init_shift_change(null, 1)
			if(VOTE_ADD_ANTAGONIST)
				/* Bastion of Endeavor Translation
				if(isnull(.) || . == "None")
				*/
				if(isnull(.) || . == "Нет")
				// End of Bastion of Endeavor Translation
					antag_add_failed = 1
				else
					additional_antag_types |= antag_names_to_ids[.]

	if(mode == VOTE_GAMEMODE) //fire this even if the vote fails.
		if(!round_progressing)
			round_progressing = 1
			/* Bastion of Endeavor Translation
			to_world("<font color='red'><b>The round will start soon.</b></font>")
			*/
			to_world("<font color='red'><b>Раунд начнётся в ближайшее время.</b></font>")
			// End of Bastion of Endeavor Translation

	if(restart)
		/* Bastion of Endeavor Translation
		to_world("World restarting due to vote...")
		feedback_set_details("end_error", "restart vote")
		if(blackbox)
			blackbox.save_all_data_to_sql()
		sleep(50)
		log_game("Rebooting due to restart vote")
		world.Reboot()
		*/
		to_world("Перезапуск мира на основе голосования...")
		feedback_set_details("end_error", "Голосование за перезапуск")
		if(blackbox)
			blackbox.save_all_data_to_sql()
		sleep(50)
		log_game("Перезапуск мира на основе голосования.")
		world.Reboot()
		// End of Bastion of Endeavor Translation

/datum/controller/subsystem/vote/proc/submit_vote(ckey, newVote)
	if(mode)
		if(config.vote_no_dead && usr.stat == DEAD && !usr.client.holder)
			return
		if(current_votes[ckey])
			choices[choices[current_votes[ckey]]]--
		if(newVote && newVote >= 1 && newVote <= choices.len)
			choices[choices[newVote]]++
			current_votes[ckey] = newVote
		else
			current_votes[ckey] = null

/datum/controller/subsystem/vote/proc/initiate_vote(vote_type, initiator_key, automatic = FALSE, time = config.vote_period)
	if(!mode)
		if(started_time != null && !(check_rights(R_ADMIN|R_EVENT) || automatic))
			var/next_allowed_time = (started_time + config.vote_delay)
			if(next_allowed_time > world.time)
				return 0

		reset()

		switch(vote_type)
			if(VOTE_RESTART)
				/* Bastion of Endeavor Translation
				choices.Add("Restart Round", "Continue Playing")
				*/
				choices.Add("Перезапустить раунд", "Продолжить игру")
				// End of Bastion of Endeavor Translation
			if(VOTE_GAMEMODE)
				if(ticker.current_state >= GAME_STATE_SETTING_UP)
					return 0
				choices.Add(config.votable_modes)
				for(var/F in choices)
					var/datum/game_mode/M = gamemode_cache[F]
					if(!M)
						continue
					gamemode_names[M.config_tag] = capitalize(M.name) //It's ugly to put this here but it works
					additional_text.Add("<td align = 'center'>[M.required_players]</td>")
				/* Bastion of Endeavor Translation
				gamemode_names["secret"] = "Secret"
				*/
				gamemode_names["secret"] = "Секретный"
				// End of Bastion of Endeavor Translation
			if(VOTE_CREW_TRANSFER)
				/* Bastion of Endeavor Translation
				if(!check_rights(R_ADMIN|R_MOD|R_EVENT, 0)) // The gods care not for the affairs of the mortals
					if(get_security_level() == "red" || get_security_level() == "delta")
						to_chat(initiator_key, "The current alert status is too high to call for a crew transfer!")
						return 0
					if(ticker.current_state <= GAME_STATE_SETTING_UP)
						to_chat(initiator_key, "The crew transfer button has been disabled!")
						return 0
				question = "Your PDA beeps with a message from Central. Would you like an additional hour to finish ongoing projects?" //VOREStation Edit
				choices.Add("Initiate Crew Transfer", "Extend the Shift")  //VOREStation Edit
				*/
				if(!check_rights(R_ADMIN|R_MOD|R_EVENT, 0)) // The gods care not for the affairs of the mortals
					if(get_security_level() == "red" || get_security_level() == "delta")
						to_chat(initiator_key, "Текущий уровень тревоги слишком высок, чтобы вызывать трансфер персонажа!")
						return 0
					if(ticker.current_state <= GAME_STATE_SETTING_UP)
						to_chat(initiator_key, "Кнопка трансфера персонала отключена!")
						return 0
				question = "На Ваш КПК пришло сообщение от Центрального Командования. Необходим ли Вам ещё один час, чтобы завершить свои дела?" //VOREStation Edit
				choices.Add("Начать трансфер персонала", "Продлить смену")  //VOREStation Edit
				// End of Bastion of Endeavor Translation
			if(VOTE_ADD_ANTAGONIST)
				if(!config.allow_extra_antags || ticker.current_state >= GAME_STATE_SETTING_UP)
					return 0
				for(var/antag_type in all_antag_types)
					var/datum/antagonist/antag = all_antag_types[antag_type]
					if(!(antag.id in additional_antag_types) && antag.is_votable())
						choices.Add(antag.role_text)
				/* Bastion of Endeavor Translation
				choices.Add("None")
				*/
				choices.Add("Нет")
				// End of Bastion of Endeavor Translation
			if(VOTE_CUSTOM)
				/* Bastion of Endeavor Translation
				question = sanitizeSafe(input(usr, "What is the vote for?") as text|null)
				if(!question)
					return 0
				for(var/i = 1 to 10)
					var/option = capitalize(sanitize(input(usr, "Please enter an option or hit cancel to finish") as text|null))
					if(!option || mode || !usr.client)
						break
					choices.Add(option)
				*/
				question = sanitizeSafe(input(usr, "За что голосуем?") as text|null)
				if(!question)
					return 0
				for(var/i = 1 to 10)
					var/option = capitalize(sanitize(input(usr, "Пожалуйста, введите вариант, либо нажмите Отмена для завершения.") as text|null))
					if(!option || mode || !usr.client)
						break
					choices.Add(option)
				// End of Bastion of Endeavor Translation
			else
				return 0

		mode = vote_type
		initiator = initiator_key
		started_time = world.time
		duration = time
		/* Bastion of Endeavor Translation
		var/text = "[capitalize(mode)] vote started by [initiator]."
		*/
		var/text = "[(initiator == "Сервер")? "[initiator]" : "Игрок [initiator]"] инициировал [mode]."
		// End of Bastion of Endeavor Translation
		if(mode == VOTE_CUSTOM)
			text += "\n[question]"

		log_vote(text)

		/* Bastion of Endeavor Translation
		to_world("<font color='purple'><b>[text]</b>\nType <b>vote</b> or click <a href='?src=\ref[src]'>here</a> to place your votes.\nYou have [config.vote_period / 10] seconds to vote.</font>")
		*/
		to_world("<font color='purple'><b>[text]</b>\nВведите <b>Голосовать</b> или нажмите <a href='?src=\ref[src]'>здесь</a>, чтобы участвовать в голосовании.\nНа голосование отводится [ru_count(config.vote_period / 10, "секунда", "секунды", "секунд")].</font>")
		// End of Bastion of Endeavor Translation
		if(vote_type == VOTE_CREW_TRANSFER || vote_type == VOTE_GAMEMODE || vote_type == VOTE_CUSTOM)
			world << sound('sound/ambience/alarm4.ogg', repeat = 0, wait = 0, volume = 50, channel = 3)

		if(mode == VOTE_GAMEMODE && round_progressing)
			gamemode_vote_called = TRUE
			round_progressing = 0
			/* Bastion of Endeavor Translation
			to_world("<font color='red'><b>Round start has been delayed.</b></font>")
			*/
			to_world("<font color='red'><b>Начало раунда было отложено.</b></font>")
			// End of Bastion of Endeavor Translation

		time_remaining = round(config.vote_period / 10)
		return 1
	return 0

/datum/controller/subsystem/vote/proc/interface(var/client/C)
	if(!istype(C))
		return
	var/admin = FALSE
	if(C.holder)
		if(C.holder.rights & R_ADMIN|R_EVENT)
			admin = TRUE

	/* Bastion of Endeavor Translation
	. = "<html><head><title>Voting Panel</title></head><body>"
	if(mode)
		if(question)
			. += "<h2>Vote: '[question]'</h2>"
		else
			. += "<h2>Vote: [capitalize(mode)]</h2>"
		. += "Time Left: [time_remaining] s<hr>"
		. += "<table width = '100%'><tr><td align = 'center'><b>Choices</b></td><td align = 'center'><b>Votes</b></td>"
		if(mode == VOTE_GAMEMODE)
			.+= "<td align = 'center'><b>Minimum Players</b></td></tr>"
	*/
	. = "<html><head><meta charset=\"UTF-8\"><title>Панель Голосований</title></head><body>"
	if(mode)
		if(question)
			. += "<h2>Опрос: '[question]'</h2>"
		else
			. += "<h2>Голосование: [capitalize(mode)]</h2>"
		. += "Осталось времени: [time_remaining] с.<hr>"
		. += "<table width = '100%'><tr><td align = 'center'><b>Варианты</b></td><td align = 'center'><b>Голоса</b></td>"
		if(mode == VOTE_GAMEMODE)
			.+= "<td align = 'center'><b>Минимум игроков</b></td></tr>"
	// End of Bastion of Endeavor Translation

		for(var/i = 1 to choices.len)
			var/votes = choices[choices[i]]
			if(!votes)
				votes = 0
			. += "<tr>"
			var/thisVote = (current_votes[C.ckey] == i)
			if(mode == VOTE_GAMEMODE)
				. += "<td>[thisVote ? "<b>" : ""]<a href='?src=\ref[src];vote=[i]'>[gamemode_names[choices[i]]]</a>[thisVote ? "</b>" : ""]</td><td align = 'center'>[votes]</td>"
			else
				. += "<td>[thisVote ? "<b>" : ""]<a href='?src=\ref[src];vote=[i]'>[choices[i]]</a>[thisVote ? "</b>" : ""]</td><td align = 'center'>[votes]</td>"
			if (additional_text.len >= i)
				. += additional_text[i]
			. += "</tr>"

		/* Bastion of Endeavor Translation
		. += "<tr><td><a href='?src=\ref[src];vote=unvote'>Unvote</a></td></tr>"

		. += "</table><hr>"
		if(admin)
			. += "(<a href='?src=\ref[src];vote=cancel'>Cancel Vote</a>) "
		*/
		. += "<tr><td><a href='?src=\ref[src];vote=unvote'>Отменить голос</a></td></tr>"

		. += "</table><hr>"
		if(admin)
			. += "(<a href='?src=\ref[src];vote=cancel'>Отменить голосование</a>) "
		// End of Bastion of Endeavor Translation
	else
		/* Bastion of Endeavor Translation
		. += "<h2>Start a vote:</h2><hr><ul><li>"
		if(admin || config.allow_vote_restart)
			. += "<a href='?src=\ref[src];vote=restart'>Restart</a>"
		else
			. += "<font color='grey'>Restart (Disallowed)</font>"
		. += "</li><li>"

		if(admin || config.allow_vote_restart)
			. += "<a href='?src=\ref[src];vote=crew_transfer'>Crew Transfer</a>"
		else
			. += "<font color='grey'>Crew Transfer (Disallowed)</font>"

		if(admin)
			. += "\t(<a href='?src=\ref[src];vote=toggle_restart'>[config.allow_vote_restart ? "Allowed" : "Disallowed"]</a>)"
		. += "</li><li>"

		if(admin || config.allow_vote_mode)
			. += "<a href='?src=\ref[src];vote=gamemode'>GameMode</a>"
		else
			. += "<font color='grey'>GameMode (Disallowed)</font>"

		if(admin)
			. += "\t(<a href='?src=\ref[src];vote=toggle_gamemode'>[config.allow_vote_mode ? "Allowed" : "Disallowed"]</a>)"
		. += "</li><li>"

		if(!antag_add_failed && config.allow_extra_antags)
			. += "<a href='?src=\ref[src];vote=add_antagonist'>Add Antagonist Type</a>"
		else
			. += "<font color='grey'>Add Antagonist (Disallowed)</font>"
		. += "</li>"

		if(admin)
			. += "<li><a href='?src=\ref[src];vote=custom'>Custom</a></li>"
		. += "</ul><hr>"

	. += "<a href='?src=\ref[src];vote=close' style='position:absolute;right:50px'>Close</a></body></html>"
		*/
		. += "<h2>Начать голосование:</h2><hr><ul><li>"
		if(admin || config.allow_vote_restart)
			. += "<a href='?src=\ref[src];vote=restart'>Перезапуск</a>"
		else
			. += "<font color='grey'>Перезапуск (Запрещено)</font>"
		. += "</li><li>"

		if(admin || config.allow_vote_restart)
			. += "<a href='?src=\ref[src];vote=crew_transfer'>Трансфер персонала</a>"
		else
			. += "<font color='grey'>Трансфер персонала (Запрещено)</font>"

		if(admin)
			. += "\t(<a href='?src=\ref[src];vote=toggle_restart'>[config.allow_vote_restart ? "Разрешено" : "Запрещено"]</a>)"
		. += "</li><li>"

		if(admin || config.allow_vote_mode)
			. += "<a href='?src=\ref[src];vote=gamemode'>Режим игры</a>"
		else
			. += "<font color='grey'>Режим игры (Запрещено)</font>"

		if(admin)
			. += "\t(<a href='?src=\ref[src];vote=toggle_gamemode'>[config.allow_vote_mode ? "Разрешено" : "Запрещено"]</a>)"
		. += "</li><li>"

		if(!antag_add_failed && config.allow_extra_antags)
			. += "<a href='?src=\ref[src];vote=add_antagonist'>Добавить тип антагониста</a>"
		else
			. += "<font color='grey'>Добавить тип антагониста (Запрещено)</font>"
		. += "</li>"

		if(admin)
			. += "<li><a href='?src=\ref[src];vote=custom'>Особый опрос</a></li>"
		. += "</ul><hr>"

	. += "<a href='?src=\ref[src];vote=close' style='position:absolute;right:50px'>Закрыть</a></body></html>"
		// End of Bastion of Endeavor Translation

/datum/controller/subsystem/vote/Topic(href, href_list[])
	if(!usr || !usr.client)
		return
	switch(href_list["vote"])
		if("close")
			usr << browse(null, "window=vote")
			return

		if("cancel")
			if(usr.client.holder)
				/* Bastion of Endeavor Translation
				if("Yes" == alert(usr, "You are about to cancel this vote. Are you sure?", "Cancel Vote", "No", "Yes"))
				*/
				if("Да" == alert(usr, "Вы действительно хотите отменить это голосование?", "Отмена Голосования", "Нет", "Да"))
				// End of Bastion of Endeavor Translation
					reset()
		if("toggle_restart")
			if(usr.client.holder)
				config.allow_vote_restart = !config.allow_vote_restart
		if("toggle_gamemode")
			if(usr.client.holder)
				config.allow_vote_mode = !config.allow_vote_mode

		/* Bastion of Endeavor Edit: This is done to have polished grammar in the announcement message without actually breaking things.
		if(VOTE_RESTART)
			if(config.allow_vote_restart || usr.client.holder)
				initiate_vote(VOTE_RESTART, usr.key)
		if(VOTE_GAMEMODE)
			if(config.allow_vote_mode || usr.client.holder)
				initiate_vote(VOTE_GAMEMODE, usr.key)
		if(VOTE_CREW_TRANSFER)
			if(config.allow_vote_restart || usr.client.holder)
				initiate_vote(VOTE_CREW_TRANSFER, usr.key)
		if(VOTE_ADD_ANTAGONIST)
			if(config.allow_extra_antags || usr.client.holder)
				initiate_vote(VOTE_ADD_ANTAGONIST, usr.key)
		if(VOTE_CUSTOM)
			if(usr.client.holder)
				initiate_vote(VOTE_CUSTOM, usr.key)
		*/
		if("restart")
			if(config.allow_vote_restart || usr.client.holder)
				initiate_vote(VOTE_RESTART, usr.key)
		if("gamemode")
			if(config.allow_vote_mode || usr.client.holder)
				initiate_vote(VOTE_GAMEMODE, usr.key)
		if("crew_transfer")
			if(config.allow_vote_restart || usr.client.holder)
				initiate_vote(VOTE_CREW_TRANSFER, usr.key)
		if("add_antagonist")
			if(config.allow_extra_antags || usr.client.holder)
				initiate_vote(VOTE_ADD_ANTAGONIST, usr.key)
		if("custom")
			if(usr.client.holder)
				initiate_vote(VOTE_CUSTOM, usr.key)
		// End of Bastion of Endeavor Edit

		if("unvote")
			submit_vote(usr.ckey, null)

		else
			var/t = round(text2num(href_list["vote"]))
			if(t) // It starts from 1, so there's no problem
				submit_vote(usr.ckey, t)
	usr.client.vote()

/client/verb/vote()
	/* Bastion of Endeavor Translation
	set category = "OOC"
	set name = "Vote"
	*/
	set category = "OOC"
	set name = "Голосование"
	// End of Bastion of Endeavor Translation

	if(SSvote)
		src << browse(SSvote.interface(src), "window=vote;size=500x[300 + SSvote.choices.len * 25]")
