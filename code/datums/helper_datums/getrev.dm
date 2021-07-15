GLOBAL_DATUM(revdata, /datum/getrev)

/datum/getrev
	var/branch
	var/revision
	var/date
	var/showinfo
	var/list/testmerge = list()

/datum/getrev/New()
	if(world.TgsAvailable()) // Try TGS maybe
		testmerge = world.TgsTestMerges()
		var/datum/tgs_revision_information/REV = world.TgsRevision()
		if(REV)
			revision = REV.origin_commit || REV.commit
			/* Bastion of Endeavor Translation
			branch = "-Using TGS-" // TGS doesn't provide branch info yet
			date = "-Using TGS-" // Or date
			*/
			branch = "-Используется TGS-" // TGS doesn't provide branch info yet
			date = "-Используется TGS-" // Or date
			// End of Bastion of Endeavor Translation
	
	if(!revision) // File parse method
		var/list/head_branch = file2list(".git/HEAD", "\n")
		if(head_branch.len)
			branch = copytext(head_branch[1], 17)

		var/list/head_log = file2list(".git/logs/HEAD", "\n")
		for(var/line=head_log.len, line>=1, line--)
			if(head_log[line])
				var/list/last_entry = splittext(head_log[line], " ")
				if(last_entry.len < 2)	continue
				revision = last_entry[2]
				// Get date/time
				if(last_entry.len >= 5)
					var/unix_time = text2num(last_entry[5])
					if(unix_time)
						date = unix2date(unix_time)
				break

	/* Bastion of Endeavor Translation
	to_world_log("-Revision Info-")
	to_world_log("Branch: [branch]")
	to_world_log("Date: [date]")
	to_world_log("Revision: [revision]")
	*/
	to_world_log("-Информация о билде-")
	to_world_log("Ветка: [branch]")
	to_world_log("Дата: [date]")
	to_world_log("Ревизия: [revision]")
	// End of Bastion of Endeavor Translation

/datum/getrev/proc/GetTestMergeInfo(header = TRUE)
	. = list()
	if(!testmerge.len)
		return
	if(header)
		/* Bastion of Endeavor Translation
		. += "The following pull requests are currently test merged:"
		*/
		. += "Следующие пулл-реквесты в тестовом мерже:"
		// End of Bastion of Endeavor Translation
	for(var/line in testmerge)
		var/datum/tgs_revision_information/test_merge/tm = line
		var/cm = tm.pull_request_commit
		/* Bastion of Endeavor Translation
		var/details = ": '" + html_encode(tm.title) + "' by " + html_encode(tm.author) + " at commit " + html_encode(copytext_char(cm, 1, 11))
		*/
		var/details = ": '" + html_encode(tm.title) + "' от " + html_encode(tm.author) + " в коммите " + html_encode(copytext_char(cm, 1, 11))
		// End of Bastion of Endeavor Translation
		if(details && findtext(details, "\[s\]") && (!usr || !usr.client.holder))
			continue
		. += "<a href=\"[config.githuburl]/pull/[tm.number]\">#[tm.number][details]</a>"

client/verb/showrevinfo()
	/* Bastion of Endeavor Translation
	set category = "OOC"
	set name = "Show Server Revision"
	set desc = "Check the current server code revision"
	*/
	set category = "OOC"
	set name = "Показать Ревизию Сервера"
	set desc = "Проверить текущую ревизию кода сервера."
	// End of Bastion of Endeavor Translation

	if(!GLOB.revdata)
		/* Bastion of Endeavor Translation
		to_chat(src, "<span class='warning'>Please wait until server initializations are complete.</span>")
		*/
		to_chat(src, "<span class='warning'>Пожалуйста, дождитесь окончания инициализации сервера.</span>")
		// End of Bastion of Endeavor Translation
		return
	
	var/list/msg = list()
	
	/* Bastion of Endeavor Translation
	if(GLOB.revdata.revision)
		msg += "<b>Server revision:</b> B:[GLOB.revdata.branch] D:[GLOB.revdata.date]"
		if(config.githuburl)
			msg += "<b>Commit:</b> <a href='[config.githuburl]/commit/[GLOB.revdata.revision]'>[GLOB.revdata.revision]</a>"
		else
			msg += "<b>Commit:</b> GLOB.revdata.revision"
	else
		msg += "<b>Server revision:</b> Unknown"
	*/
	if(GLOB.revdata.revision)
		msg += "<b>Ревизия сервера:</b> В:[GLOB.revdata.branch] Д:[GLOB.revdata.date]"
		if(config.githuburl)
			msg += "<b>Коммит:</b> <a href='[config.githuburl]/commit/[GLOB.revdata.revision]'>[GLOB.revdata.revision]</a>"
		else
			msg += "<b>Коммит:</b> [GLOB.revdata.revision]"
	else
		msg += "<b>Ревизия сервера:</b> Неизвестна"
	// End of Bastion of Endeavor Translation

	if(world.TgsAvailable())
		/* Bastion of Endeavor Translation
		var/datum/tgs_version/version = world.TgsVersion()
		msg += "<b>TGS version:</b> [version.raw_parameter]"
		var/datum/tgs_version/api_version = world.TgsApiVersion()
		msg += "<b>DMAPI version:</b> [api_version.raw_parameter]"
		*/
		var/datum/tgs_version/version = world.TgsVersion()
		msg += "<b>Версия TGS:</b> [version.raw_parameter]"
		var/datum/tgs_version/api_version = world.TgsApiVersion()
		msg += "<b>Версия DMAPI:</b> [api_version.raw_parameter]"
		// End of Bastion of Endeavor Translation

	if(GLOB.revdata.testmerge.len)
		msg += GLOB.revdata.GetTestMergeInfo()

	to_chat(src, msg.Join("<br>"))
