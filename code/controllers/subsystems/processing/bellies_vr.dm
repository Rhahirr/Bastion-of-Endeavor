//
// Bellies subsystem - Process vore bellies
//

PROCESSING_SUBSYSTEM_DEF(bellies)
	/* Bastion of Endeavor Translation
	name = "Bellies"
	*/
	name = "Животы"
	// End of Bastion of Endeavor Translation
	wait = 6 SECONDS
	flags = SS_KEEP_TIMING|SS_NO_INIT
	runlevels = RUNLEVEL_GAME|RUNLEVEL_POSTGAME

/datum/controller/subsystem/processing/bellies/Recover()
	/* Bastion of Endeavor Translation
	log_debug("[name] subsystem Recover().")
	if(SSbellies.current_thing)
		log_debug("current_thing was: (\ref[SSbellies.current_thing])[SSbellies.current_thing]([SSbellies.current_thing.type]) - currentrun: [SSbellies.currentrun.len] vs total: [SSbellies.processing.len]")
	var/list/old_processing = SSbellies.processing.Copy()
	for(var/datum/D in old_processing)
		if(!isbelly(D))
			log_debug("[name] subsystem Recover() found inappropriate item in list: [D.type]")
		if(CHECK_BITFIELD(D.datum_flags, DF_ISPROCESSING))
			processing |= D
	*/
	log_debug("Вызван Recover() подсистемы '[name]'.")
	if(SSbellies.current_thing)
		log_debug("Current_thing было: (\ref[SSbellies.current_thing])[SSbellies.current_thing]([SSbellies.current_thing.type]) - currentrun: [SSbellies.currentrun.len] против [SSbellies.processing.len] в общей сложности")
	var/list/old_processing = SSbellies.processing.Copy()
	for(var/datum/D in old_processing)
		if(!isbelly(D))
			log_debug("Recover() подсистемы '[name]' обнаружил недопустимый элемент в листе: [D.type]")
		if(CHECK_BITFIELD(D.datum_flags, DF_ISPROCESSING))
			processing |= D
	// End of Bastion of Endeavor Translation
