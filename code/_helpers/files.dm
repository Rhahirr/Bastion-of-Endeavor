//checks if a file exists and contains text
//returns text as a string if these conditions are met
/proc/return_file_text(filename)
	if(fexists(filename) == 0)
		/* Bastion of Endeavor Translation
		error("File not found ([filename])")
		*/
		error("Файл не найден ([filename])")
		// End of Bastion of Endeavor Translation
		return

	var/text = file2text(filename)
	if(!text)
		/* Bastion of Endeavor Translation
		error("File empty ([filename])")
		*/
		error("Файл пуст ([filename])")
		// End of Bastion of Endeavor Translation
		return

	return text

//Sends resource files to client cache
/client/proc/getFiles()
	for(var/file in args)
		src << browse_rsc(file)

/client/proc/browse_files(root="data/logs/", max_iterations=10, list/valid_extensions=list(".txt",".log",".htm"))
	var/path = root

	for(var/i=0, i<max_iterations, i++)
		var/list/choices = sortList(flist(path))
		if(path != root)
			choices.Insert(1,"/")

		/* Bastion of Endeavor Translation
		var/choice = input(src,"Choose a file to access:","Download",null) as null|anything in choices
		*/
		var/choice = input(src,"Выберите файл, к которому хотите получить доступ:","Загрузка",null) as null|anything in choices
		// End of Bastion of Endeavor Translation
		switch(choice)
			if(null)
				return
			if("/")
				path = root
				continue
		path += choice

		/* Bastion of Endeavor Edit: Unlikely needed, but Unicode support.
		if(copytext(path,-1,0) != "/")		//didn't choose a directory, no need to iterate again
			break

	var/extension = copytext(path,-4,0)
	*/
		if(copytext_char(path,-1,0) != "/")		//didn't choose a directory, no need to iterate again
			break

	var/extension = copytext_char(path,-4,0)
		// End of Bastion of Endeavor Edit
	if( !fexists(path) || !(extension in valid_extensions) )
		/* Bastion of Endeavor Translation
		to_chat(src, "<font color='red'>Error: browse_files(): File not found/Invalid file([path]).</font>")
		*/
		to_chat(src, "<font color='red'>Ошибка: browse_files(): Файл не найден или недопустим ([path]).</font>")
		// End of Bastion of Endeavor Translation
		return

	return path

#define FTPDELAY 200	//200 tick delay to discourage spam
/*	This proc is a failsafe to prevent spamming of file requests.
	It is just a timer that only permits a download every [FTPDELAY] ticks.
	This can be changed by modifying FTPDELAY's value above.

	PLEASE USE RESPONSIBLY, Some log files canr each sizes of 4MB!	*/
/client/proc/file_spam_check()
	var/time_to_wait = fileaccess_timer - world.time
	if(time_to_wait > 0)
		/* Bastion of Endeavor Translation
		to_chat(src, "<font color='red'>Error: file_spam_check(): Spam. Please wait [round(time_to_wait/10)] seconds.</font>")
		*/
		to_chat(src, "<font color='red'>Ошибка: file_spam_check(): Спам. Пожалуйста, подождите [ru_count(round(time_to_wait/10), "секунду", "секунды", "секунд")].</font>")
		// End of Bastion of Endeavor Translation
		return 1
	fileaccess_timer = world.time + FTPDELAY
	return 0
#undef FTPDELAY
