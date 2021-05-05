SUBSYSTEM_DEF(nightshift)
	/* Bastion of Endeavor Translation
	name = "Night Shift"
	*/
	name = "Ночная Смена"
	// End of Bastion of Endeavor Translation
	init_order = INIT_ORDER_NIGHTSHIFT
	priority = FIRE_PRIORITY_NIGHTSHIFT
	wait = 60 SECONDS
	flags = SS_NO_TICK_CHECK

	var/nightshift_active = FALSE
	var/nightshift_first_check = 30 SECONDS

	var/high_security_mode = FALSE

/datum/controller/subsystem/nightshift/Initialize()
	if(!config.enable_night_shifts)
		can_fire = FALSE
	/*
	if(config.randomize_shift_time)
		GLOB.gametime_offset = rand(0, 23) HOURS
	*/
	return ..()

/datum/controller/subsystem/nightshift/fire(resumed = FALSE)
	if(round_duration_in_ds < nightshift_first_check)
		return
	check_nightshift()

/datum/controller/subsystem/nightshift/proc/announce(message)
	var/announce_z
	if(using_map.station_levels.len)
		announce_z = pick(using_map.station_levels)
	//VOREStation Edit - TTS
	var/pickedsound
	if(!high_security_mode)
		if(nightshift_active)
			pickedsound = 'sound/AI/dim_lights.ogg'
		else
			pickedsound = 'sound/AI/bright_lights.ogg'
	/* Bastion of Endeavor Translation
	priority_announcement.Announce(message, new_title = "Automated Lighting System Announcement", new_sound = pickedsound, zlevel = announce_z)
	*/
	priority_announcement.Announce(message, new_title = "Автоматизированное Объявление Системы Освещения", new_sound = pickedsound, zlevel = announce_z)
	// End of Bastion of Endeavor Translation
	//VOREStation Edit End

/datum/controller/subsystem/nightshift/proc/check_nightshift(check_canfire=FALSE) //This is called from elsewhere, like setting the alert levels
	if(check_canfire && !can_fire)
		return
	var/emergency = security_level > SEC_LEVEL_GREEN
	var/announcing = TRUE
	var/night_time = using_map.get_nightshift()
	if(high_security_mode != emergency)
		high_security_mode = emergency
		if(night_time)
			announcing = FALSE
			/* Bastion of Endeavor Translation
			if(!emergency)
				announce("Restoring night lighting configuration to normal operation.")
			else
				announce("Disabling night lighting: Station is in a state of emergency.")
			*/
			if(!emergency)
				announce("Произведена смена ночного освещения на дневное.")
			else
				announce("Система ночного освещения отключена: на станции чрезвычайная ситуация.")
			// End of Bastion of Endeavor Translation
	if(emergency)
		night_time = FALSE
	if(nightshift_active != night_time)
		update_nightshift(night_time, announcing)

/datum/controller/subsystem/nightshift/proc/update_nightshift(active, announce = TRUE)
	nightshift_active = active
	if(announce)
		/* Bastion of Endeavor Translation
		if(active)
			announce("Good evening, crew. To reduce power consumption and stimulate the circadian rhythms of some species, all of the lights aboard the station have been dimmed for the night.")
		else
			announce("Good morning, crew. As it is now day time, all of the lights aboard the station have been restored to their former brightness.")
		*/
		if(active)
			announce("Добрый вечер, персонал. В целях энергосбережения и стимуляции циркадных ритмов некоторых рас, всё освещение на станции будет затемнено на ночь.")
		else
			announce("Доброе утро, персонал. Освещение на станции вновь восстановлено до дневной нормы яркости.")
		// End of Bastion of Endeavor Translation
	for(var/obj/machinery/power/apc/apc in GLOB.apcs)
		if(apc.z in using_map.station_levels)
			apc.set_nightshift(active, TRUE)
			CHECK_TICK
