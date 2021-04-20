/proc/log_nsay(text, inside, mob/speaker)
	if (config.log_say)
		/* Bastion of Endeavor Translation
		WRITE_LOG(diary, "NSAY (NIF:[inside]): [speaker.simple_info_line()]: [html_decode(text)]")
		*/
		WRITE_LOG(diary, "НИФ-РЕЧЬ (НИФ:[inside]): [speaker.simple_info_line()]: [html_decode(text)]")
		// End of Bastion of Endeavor Edit

/proc/log_nme(text, inside, mob/speaker)
	if (config.log_emote)
		/* Bastion of Endeavor Translation
		WRITE_LOG(diary, "NME (NIF:[inside]): [speaker.simple_info_line()]: [html_decode(text)]")
		*/
		WRITE_LOG(diary, "НИФ-ЭМОУТ (НИФ:[inside]): [speaker.simple_info_line()]: [html_decode(text)]")
		// End of Bastion of Endeavor Edit

/proc/log_subtle(text, mob/speaker)
	if (config.log_emote)
		/* Bastion of Endeavor Translation
		WRITE_LOG(diary, "SUBTLE: [speaker.simple_info_line()]: [html_decode(text)]")
		*/
		WRITE_LOG(diary, "СКРЫТЫЙ ЭМОУТ: [speaker.simple_info_line()]: [html_decode(text)]")
		// End of Bastion of Endeavor Edit
