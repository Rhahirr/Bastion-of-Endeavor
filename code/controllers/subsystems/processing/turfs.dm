PROCESSING_SUBSYSTEM_DEF(turfs)
	/* Bastion of Endeavor Translation
	name = "Turf Processing"
	*/
	name = "Обработчик Тюрфов"
	// End of Bastion of Endeavor Translation
	wait = 20

/datum/controller/subsystem/processing/turfs/Recover()
	/* Bastion of Endeavor Translation
	log_debug("[name] subsystem Recover().")
	if(SSturfs.current_thing)
		log_debug("current_thing was: (\ref[SSturfs.current_thing])[SSturfs.current_thing]([SSturfs.current_thing.type]) - currentrun: [SSturfs.currentrun.len] vs total: [SSturfs.processing.len]")
	var/list/old_processing = SSturfs.processing.Copy()
	for(var/datum/D in old_processing)
		if(!isturf(D))
			log_debug("[name] subsystem Recover() found inappropriate item in list: [D.type]")
		if(CHECK_BITFIELD(D.datum_flags, DF_ISPROCESSING))
			processing |= D
	*/
	log_debug("Recover() подсистемы '[name]'.")
	if(SSturfs.current_thing)
		log_debug("Current_thing было: (\ref[SSturfs.current_thing])[SSturfs.current_thing]([SSturfs.current_thing.type]) - currentrun: [SSturfs.currentrun.len] против [SSturfs.processing.len] в общей сложности")
	var/list/old_processing = SSturfs.processing.Copy()
	for(var/datum/D in old_processing)
		if(!isturf(D))
			log_debug("Recover() подсистемы '[name]' обнаружил недопустимый элемент в листе: [D.type]")
		if(CHECK_BITFIELD(D.datum_flags, DF_ISPROCESSING))
			processing |= D
	// End of Bastion of Endeavor Translation