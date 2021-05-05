GLOBAL_REAL(GLOB, /datum/controller/global_vars)

/datum/controller/global_vars
	/* Bastion of Endeavor Translation
	name = "Global Variables"
	*/
	name = "Глобальные Переменные"
	// End of Bastion of Endeavor Translation

	var/list/gvars_datum_protected_varlist
	var/list/gvars_datum_in_built_vars
	var/list/gvars_datum_init_order

/datum/controller/global_vars/New()
	if(GLOB)
		/* Bastion of Endeavor Translation
		CRASH("Multiple instances of global variable controller created")
		*/
		CRASH("Создано несколько инстанций контроллера глобальных переменных")
		// End of Bastion of Endeavor Translation
	GLOB = src

	var/datum/controller/exclude_these = new
	gvars_datum_in_built_vars = exclude_these.vars + list("gvars_datum_protected_varlist", "gvars_datum_in_built_vars", "gvars_datum_init_order")

	/* Bastion of Endeavor Translation
	log_world("[vars.len - gvars_datum_in_built_vars.len] global variables")
	*/
	log_world("[ru_count((vars.len - gvars_datum_in_built_vars.len), "глобальная переменная", "глобальных переменных", "глобальных переменных")]")
	// End of Bastion of Endeavor Translation

	Initialize(exclude_these)

/datum/controller/global_vars/Destroy(force)
	/* Bastion of Endeavor Translation
	crash_with("There was an attempt to qdel the global vars holder!")
	*/
	crash_with("Попытка qdel'нуть холдер глобальных переменных!")
	// End of Bastion of Endeavor Translation
	if(!force)
		return QDEL_HINT_LETMELIVE

	QDEL_NULL(statclick)
	gvars_datum_protected_varlist.Cut()
	gvars_datum_in_built_vars.Cut()

	GLOB = null

	return ..()

/datum/controller/global_vars/stat_entry()
	/* Bastion of Endeavor Translation
	if(!statclick)
		statclick = new/obj/effect/statclick/debug(null, "Initializing...", src)

	stat("Globals:", statclick.update("Edit"))
	*/
	if(!statclick)
		statclick = new/obj/effect/statclick/debug(null, "Инициализация...", src)

	stat("Глобальные:", statclick.update("Редактировать"))
	// End of Bastion of Endeavor Translation

/datum/controller/global_vars/vv_edit_var(var_name, var_value)
	if(gvars_datum_protected_varlist[var_name])
		return FALSE
	return ..()

/datum/controller/global_vars/Initialize(var/exclude_these)
	gvars_datum_init_order = list()
	gvars_datum_protected_varlist = list("gvars_datum_protected_varlist")

	//See https://github.com/tgstation/tgstation/issues/26954
	for(var/I in typesof(/datum/controller/global_vars/proc))
		var/CLEANBOT_RETURNS = "[I]"
		pass(CLEANBOT_RETURNS)

	for(var/I in (vars - gvars_datum_in_built_vars))
		var/start_tick = world.time
		call(src, "InitGlobal[I]")()
		var/end_tick = world.time
		if(end_tick - start_tick)
			/* Bastion of Endeavor Translation
			warning("Global [I] slept during initialization!")
			*/
			warning("Глобальная переменная [I] спала во время инициализации!")
			// End of Bastion of Endeavor Translation
	QDEL_NULL(exclude_these)