//Fires five times every second.

PROCESSING_SUBSYSTEM_DEF(fastprocess)
	/* Bastion of Endeavor Translation
	name = "Fast Processing"
	wait = 2
	stat_tag = "FP"
	*/
	name = "Быстрая Обработка"
	wait = 2
	stat_tag = "БО"
	// End of Bastion of Endeavor Translation

/datum/controller/subsystem/processing/fastprocess/Recover()
	/* Bastion of Endeavor Translation
	log_debug("[name] subsystem Recover().")
	if(SSfastprocess.current_thing)
		log_debug("current_thing was: (\ref[SSfastprocess.current_thing])[SSfastprocess.current_thing]([SSfastprocess.current_thing.type]) - currentrun: [SSfastprocess.currentrun.len] vs total: [SSfastprocess.processing.len]")
	*/
	log_debug("Recover() подсистемы '[name]'.")
	if(SSfastprocess.current_thing)
		log_debug("Current_thing было: (\ref[SSfastprocess.current_thing])[SSfastprocess.current_thing]([SSfastprocess.current_thing.type]) - currentrun: [SSfastprocess.currentrun.len] против [SSfastprocess.processing.len] в общей сложности")
	// End of Bastion of Endeavor Translation
	var/list/old_processing = SSfastprocess.processing.Copy()
	for(var/datum/D in old_processing)
		if(CHECK_BITFIELD(D.datum_flags, DF_ISPROCESSING))
			processing |= D