proc/sql_poll_population()
	if(!sqllogging)
		return
	var/admincount = GLOB.admins.len
	var/playercount = 0
	for(var/mob/M in player_list)
		if(M.client)
			playercount += 1
	establish_db_connection()
	if(!dbcon.IsConnected())
		/* Bastion of Endeavor Translation
		log_game("SQL ERROR during population polling. Failed to connect.")
		*/
		log_game("ОШИБКА SQL во время замера активности. Не удалось установить соединение.")
		// End of Bastion of Endeavor Translation
	else
		var/sqltime = time2text(world.realtime, "YYYY-MM-DD hh:mm:ss")
		var/DBQuery/query = dbcon_old.NewQuery("INSERT INTO `tgstation`.`population` (`playercount`, `admincount`, `time`) VALUES ([playercount], [admincount], '[sqltime]')")
		if(!query.Execute())
			var/err = query.ErrorMsg()
			/* Bastion of Endeavor Translation
			log_game("SQL ERROR during population polling. Error : \[[err]\]\n")
			*/
			log_game("ОШИБКА SQL во время замера активности. Ошибка: \[[err]\]\n")
			// End of Bastion of Endeavor Translation

proc/sql_report_round_start()
	// TODO
	if(!sqllogging)
		return
proc/sql_report_round_end()
	// TODO
	if(!sqllogging)
		return

proc/sql_report_death(var/mob/living/carbon/human/H)
	if(!sqllogging)
		return
	if(!H)
		return
	if(!H.key || !H.mind)
		return

	var/area/placeofdeath = get_area(H)
	/* Bastion of Endeavor Translation
	var/podname = placeofdeath ? placeofdeath.name : "Unknown area"
	*/
	var/podname = placeofdeath ? placeofdeath.name : "Неизвестное место"
	// End of Bastion of Endeavor Translation

	var/sqlname = sanitizeSQL(H.real_name)
	var/sqlkey = sanitizeSQL(H.key)
	var/sqlpod = sanitizeSQL(podname)
	var/sqlspecial = sanitizeSQL(H.mind.special_role)
	var/sqljob = sanitizeSQL(H.mind.assigned_role)
	var/laname
	var/lakey
	if(H.lastattacker)
		laname = sanitizeSQL(H.lastattacker:real_name)
		lakey = sanitizeSQL(H.lastattacker:key)
	var/sqltime = time2text(world.realtime, "YYYY-MM-DD hh:mm:ss")
	var/coord = "[H.x], [H.y], [H.z]"
	//to_world("INSERT INTO death (name, byondkey, job, special, pod, tod, laname, lakey, gender, bruteloss, fireloss, brainloss, oxyloss) VALUES ('[sqlname]', '[sqlkey]', '[sqljob]', '[sqlspecial]', '[sqlpod]', '[sqltime]', '[laname]', '[lakey]', '[H.gender]', [H.bruteloss], [H.getFireLoss()], [H.brainloss], [H.getOxyLoss()])")
	establish_db_connection()
	if(!dbcon.IsConnected())
		/* Bastion of Endeavor Translation
		log_game("SQL ERROR during death reporting. Failed to connect.")
		*/
		log_game("ОШИБКА SQL во время отчёта о смерти. Не удалось установить соединение.")
		// End of Bastion of Endeavor Translation
	else
		var/DBQuery/query = dbcon.NewQuery("INSERT INTO death (name, byondkey, job, special, pod, tod, laname, lakey, gender, bruteloss, fireloss, brainloss, oxyloss, coord) VALUES ('[sqlname]', '[sqlkey]', '[sqljob]', '[sqlspecial]', '[sqlpod]', '[sqltime]', '[laname]', '[lakey]', '[H.gender]', [H.getBruteLoss()], [H.getFireLoss()], [H.brainloss], [H.getOxyLoss()], '[coord]')")
		if(!query.Execute())
			var/err = query.ErrorMsg()
			/* Bastion of Endeavor Translation
			log_game("SQL ERROR during death reporting. Error : \[[err]\]\n")
			*/
			log_game("ОШИБКА SQL во время отчёта о смерти. Ошибка : \[[err]\]\n")
			// End of Bastion of Endeavor Translation


proc/sql_report_cyborg_death(var/mob/living/silicon/robot/H)
	if(!sqllogging)
		return
	if(!H)
		return
	if(!H.key || !H.mind)
		return

	var/area/placeofdeath = get_area(H)
	/* Bastion of Endeavor Translation
	var/podname = placeofdeath ? placeofdeath.name : "Unknown area"
	*/
	var/podname = placeofdeath ? placeofdeath.name : "Неизвестное место"
	// End of Bastion of Endeavor Translation

	var/sqlname = sanitizeSQL(H.real_name)
	var/sqlkey = sanitizeSQL(H.key)
	var/sqlpod = sanitizeSQL(podname)
	var/sqlspecial = sanitizeSQL(H.mind.special_role)
	var/sqljob = sanitizeSQL(H.mind.assigned_role)
	var/laname
	var/lakey
	if(H.lastattacker)
		laname = sanitizeSQL(H.lastattacker:real_name)
		lakey = sanitizeSQL(H.lastattacker:key)
	var/sqltime = time2text(world.realtime, "YYYY-MM-DD hh:mm:ss")
	var/coord = "[H.x], [H.y], [H.z]"
	//to_world("INSERT INTO death (name, byondkey, job, special, pod, tod, laname, lakey, gender, bruteloss, fireloss, brainloss, oxyloss) VALUES ('[sqlname]', '[sqlkey]', '[sqljob]', '[sqlspecial]', '[sqlpod]', '[sqltime]', '[laname]', '[lakey]', '[H.gender]', [H.bruteloss], [H.getFireLoss()], [H.brainloss], [H.getOxyLoss()])")
	establish_db_connection()
	if(!dbcon.IsConnected())
		/* Bastion of Endeavor Translation
		log_game("SQL ERROR during death reporting. Failed to connect.")
		*/
		log_game("ОШИБКА SQL во время отчёта о смерти. Не удалось установить соединение.")
		// End of Bastion of Endeavor Translation
	else
		var/DBQuery/query = dbcon.NewQuery("INSERT INTO death (name, byondkey, job, special, pod, tod, laname, lakey, gender, bruteloss, fireloss, brainloss, oxyloss, coord) VALUES ('[sqlname]', '[sqlkey]', '[sqljob]', '[sqlspecial]', '[sqlpod]', '[sqltime]', '[laname]', '[lakey]', '[H.gender]', [H.getBruteLoss()], [H.getFireLoss()], [H.brainloss], [H.getOxyLoss()], '[coord]')")
		if(!query.Execute())
			var/err = query.ErrorMsg()
			/* Bastion of Endeavor Translation
			log_game("SQL ERROR during death reporting. Error : \[[err]\]\n")
			*/
			log_game("ОШИБКА SQL во время отчёта о смерти. Ошибка: \[[err]\]\n")
			// End of Bastion of Endeavor Translation


proc/statistic_cycle()
	set waitfor = 0
	if(!sqllogging)
		return
	while(1)
		sql_poll_population()
		sleep(6000)

//This proc is used for feedback. It is executed at round end.
proc/sql_commit_feedback()
	if(!blackbox)
		/* Bastion of Endeavor Translation
		log_game("Round ended without a blackbox recorder. No feedback was sent to the database.")
		*/
		log_game("Раунд завершился без чёрного ящика. Фидбек не будет отослан в базу данных.")
		// End of Bastion of Endeavor Translation
		return

	//content is a list of lists. Each item in the list is a list with two fields, a variable name and a value. Items MUST only have these two values.
	var/list/datum/feedback_variable/content = blackbox.get_round_feedback()

	if(!content)
		/* Bastion of Endeavor Translation
		log_game("Round ended without any feedback being generated. No feedback was sent to the database.")
		*/
		log_game("Раунд завершился без какого-либо фидбека. Фидбек не будет отослан в базу данных.")
		// End of Bastion of Endeavor Translation
		return

	establish_db_connection()
	if(!dbcon.IsConnected())
		/* Bastion of Endeavor Translation
		log_game("SQL ERROR during feedback reporting. Failed to connect.")
		*/
		log_game("ОШИБКА SQL во время отсылки фидбека. Не удалось установить соединение.")
		// End of Bastion of Endeavor Translation
	else

		var/DBQuery/max_query = dbcon.NewQuery("SELECT MAX(roundid) AS max_round_id FROM erro_feedback")
		max_query.Execute()

		var/newroundid

		while(max_query.NextRow())
			newroundid = max_query.item[1]

		if(!(isnum(newroundid)))
			newroundid = text2num(newroundid)

		if(isnum(newroundid))
			newroundid++
		else
			newroundid = 1

		for(var/datum/feedback_variable/item in content)
			var/variable = item.get_variable()
			var/value = item.get_value()

			var/DBQuery/query = dbcon.NewQuery("INSERT INTO erro_feedback (id, roundid, time, variable, value) VALUES (null, [newroundid], Now(), '[variable]', '[value]')")
			if(!query.Execute())
				var/err = query.ErrorMsg()
				/* Bastion of Endeavor Translation
				log_game("SQL ERROR during death reporting. Error : \[[err]\]\n")
				*/
				log_game("ОШИБКА SQL во время отчёта о смерти. Ошибка : \[[err]\]\n")
				// End of Bastion of Endeavor Translation
