//Used to process objects. Fires once every second.

SUBSYSTEM_DEF(processing)
	/* Bastion of Endeavor Translation
	name = "Processing"
	*/
	name = "Обработка"
	// End of Bastion of Endeavor Translation
	priority = FIRE_PRIORITY_PROCESS
	flags = SS_BACKGROUND|SS_POST_FIRE_TIMING|SS_NO_INIT
	wait = 10

	/* Bastion of Endeavor Translation
	var/stat_tag = "P" //Used for logging
	*/
	var/stat_tag = "П"
	// End of Bastion of Endeavor Translation
	var/list/processing = list()
	var/list/currentrun = list()
	var/process_proc = /datum/proc/process

	var/debug_last_thing
	var/debug_original_process_proc // initial() does not work with procs
	var/datum/current_thing

/datum/controller/subsystem/processing/Recover()
	/* Bastion of Endeavor Translation
	log_debug("[name] subsystem Recover().")
	if(SSprocessing.current_thing)
		log_debug("current_thing was: (\ref[SSprocessing.current_thing])[SSprocessing.current_thing]([SSprocessing.current_thing.type]) - currentrun: [SSprocessing.currentrun.len] vs total: [SSprocessing.processing.len]")
	*/
	log_debug("Recover() подсистемы '[name]'.")
	if(SSprocessing.current_thing)
		log_debug("current_thing было: (\ref[SSprocessing.current_thing])[SSprocessing.current_thing]([SSprocessing.current_thing.type]) - currentrun: [SSprocessing.currentrun.len] против [SSprocessing.processing.len] в общей сложности")
	// End of Bastion of Endeavor Translation
	var/list/old_processing = SSprocessing.processing.Copy()
	for(var/datum/D in old_processing)
		if(CHECK_BITFIELD(D.datum_flags, DF_ISPROCESSING))
			processing |= D

/datum/controller/subsystem/processing/stat_entry()
	..("[stat_tag]:[processing.len]")

/datum/controller/subsystem/processing/fire(resumed = 0)
	if (!resumed)
		currentrun = processing.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/current_run = currentrun

	while(current_run.len)
		current_thing = current_run[current_run.len]
		current_run.len--
		if(QDELETED(current_thing))
			processing -= current_thing
		else if(current_thing.process(wait) == PROCESS_KILL)
			// fully stop so that a future START_PROCESSING will work
			STOP_PROCESSING(src, current_thing)
		if (MC_TICK_CHECK)
			current_thing = null
			return

	current_thing = null

/datum/controller/subsystem/processing/proc/toggle_debug()
	if(!check_rights(R_DEBUG))
		return

	if(debug_original_process_proc)
		process_proc = debug_original_process_proc
		debug_original_process_proc = null
	else
		debug_original_process_proc	= process_proc
		process_proc = /datum/proc/DebugSubsystemProcess

	/* Bastion of Endeavor Translation
	to_chat(usr, "[name] - Debug mode [debug_original_process_proc ? "en" : "dis"]abled")
	*/
	to_chat(usr, "[name] - Режим дебаггинга [debug_original_process_proc ? "вк" : "вык"]лючен")
	// End of Bastion of Endeavor Translation

/datum/proc/DebugSubsystemProcess(var/wait, var/times_fired, var/datum/controller/subsystem/processing/subsystem)
	subsystem.debug_last_thing = src
	var/start_tick = world.time
	var/start_tick_usage = world.tick_usage
	. = call(src, subsystem.debug_original_process_proc)(wait, times_fired)

	var/tick_time = world.time - start_tick
	var/tick_use_limit = world.tick_usage - start_tick_usage - 100 // Current tick use - starting tick use - 100% (a full tick excess)
	/* Bastion of Endeavor Translation
	if(tick_time > 0)
		crash_with("[log_info_line(subsystem.debug_last_thing)] slept during processing. Spent [tick_time] tick\s.")
	if(tick_use_limit > 0)
		crash_with("[log_info_line(subsystem.debug_last_thing)] took longer than a tick to process. Exceeded with [tick_use_limit]%")
	*/
	if(tick_time > 0)
		crash_with("[log_info_line(subsystem.debug_last_thing)] спал во время обработки. [ru_count(tick_time, "Потрачен", "Потрачено", "Потрачено", 1)] [ru_count(tick_time, "тик", "тика", "тиков")].")
	if(tick_use_limit > 0)
		crash_with("[log_info_line(subsystem.debug_last_thing)] занял на обработку больше тика. Превышено на [tick_use_limit]%")
	// End of Bastion of Endeavor Translation

/datum/proc/process()
	set waitfor = 0
	return PROCESS_KILL
