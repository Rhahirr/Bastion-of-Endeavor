
/*
 * lbnesquik - Github
 * Provided massive components of this. Polaris PR #5720.
 */

//This is for the round end stats system.

//roundstat is used for easy finding of the variables, if you ever want to delete all of this,
//just search roundstat and you'll find everywhere this thing reaches into.
//It used to be bazinga but it only fly with microwaves.

GLOBAL_VAR_INIT(cans_opened_roundstat, 0)
GLOBAL_VAR_INIT(lights_switched_on_roundstat, 0)
GLOBAL_VAR_INIT(turbo_lift_floors_moved_roundstat, 0)
GLOBAL_VAR_INIT(lost_limbs_shift_roundstat, 0)
GLOBAL_VAR_INIT(seed_planted_shift_roundstat, 0)
GLOBAL_VAR_INIT(step_taken_shift_roundstat, 0)
GLOBAL_VAR_INIT(destroyed_research_items_roundstat, 0)
GLOBAL_VAR_INIT(items_sold_shift_roundstat, 0)
GLOBAL_VAR_INIT(disposals_flush_shift_roundstat, 0)
GLOBAL_VAR_INIT(rocks_drilled_roundstat, 0)
GLOBAL_VAR_INIT(mech_destroyed_roundstat, 0)

/hook/roundend/proc/RoundTrivia()//bazinga
	var/list/valid_stats_list = list() //This is to be populated with the good shit

	/* Bastion of Endeavor Translation
	if(GLOB.lost_limbs_shift_roundstat > 1)
		valid_stats_list.Add("[GLOB.lost_limbs_shift_roundstat] limbs left their owners bodies this shift, oh no!")
	else if(GLOB.destroyed_research_items_roundstat > 13)
		valid_stats_list.Add("[GLOB.destroyed_research_items_roundstat] objects were destroyed in the name of Science! Keep it up!")
	else if(GLOB.mech_destroyed_roundstat > 1)
		valid_stats_list.Add("[GLOB.mech_destroyed_roundstat] mechs were destroyed this shift. What did you do?")
	else if(GLOB.seed_planted_shift_roundstat > 20)
		valid_stats_list.Add("[GLOB.seed_planted_shift_roundstat] seeds were planted according to our sensors this shift.")
	*/
	if(GLOB.lost_limbs_shift_roundstat > 1)
		valid_stats_list.Add("За эту смену [ru_count(GLOB.lost_limbs_shift_roundstat, "конечность покинула своего хозяина", "конечности покинуло своих хозяев", "конечностей покинуло своих хозяев")], о ужас!")
	else if(GLOB.destroyed_research_items_roundstat > 13)
		valid_stats_list.Add("[ru_count(GLOB.destroyed_research_items_roundstat, "объект был уничтожен", "объекта было уничтожено", "объектов было уничтожено")] во имя науки! Так держать!")
	else if(GLOB.mech_destroyed_roundstat > 1)
		valid_stats_list.Add("[ru_count(GLOB.mech_destroyed_roundstat, "мех был уничтожен", "меха было уничтожено", "мехов было уничтожено")] за эту смену. Как это произошло?")
	else if(GLOB.seed_planted_shift_roundstat > 20)
		valid_stats_list.Add("Согласно нашим датчикам, [ru_count(GLOB.seed_planted_shift_roundstat, "семя было посажено", "семени было посажено", "семян было посажено")] за эту смену.")
	// End of Bastion of Endeavor Translation

	/* Bastion of Endeavor Translation
	if(GLOB.rocks_drilled_roundstat > 80)
		valid_stats_list.Add("Our strong miners pulverized a whole [GLOB.rocks_drilled_roundstat] piles of pathetic rubble.")
	else if(GLOB.items_sold_shift_roundstat > 15)
		valid_stats_list.Add("The vending machines sold [GLOB.items_sold_shift_roundstat] items today.")
	else if(GLOB.step_taken_shift_roundstat > 900)
		valid_stats_list.Add("The employees walked a total of [GLOB.step_taken_shift_roundstat] steps for this shift! It should put them on the road to fitness!")
	*/
	if(GLOB.rocks_drilled_roundstat > 80)
		valid_stats_list.Add("Наши сильные шахтёры сегодня пробурили аж [ru_count(GLOB.rocks_drilled_roundstat, "груду камней", "груды камней", "груд камней")].")
	else if(GLOB.items_sold_shift_roundstat > 15)
		valid_stats_list.Add("Торговые автоматы за сегодня продали [ru_count(GLOB.items_sold_shift_roundstat, "товар", "товара", "товаров")].")
	else if(GLOB.step_taken_shift_roundstat > 900)
		valid_stats_list.Add("Сотрудниками за сегодня [ru_count(GLOB.step_taken_shift_roundstat, "был пройден", "было пройдено", "было пройдено", 1)] [ru_count(GLOB.step_taken_shift_roundstat, "шаг", "шага", "шагов")]! Не забывайте поддерживать форму!")
	// End of Bastion of Endeavor Translation

/* Bastion of Endeavor Translation
	if(GLOB.cans_opened_roundstat > 0)
		valid_stats_list.Add("[GLOB.cans_opened_roundstat] cans were drank today!")
	else if(GLOB.lights_switched_on_roundstat > 0)
		valid_stats_list.Add("[GLOB.lights_switched_on_roundstat] light switches were flipped today!")
	else if(GLOB.turbo_lift_floors_moved_roundstat > 20)
		valid_stats_list.Add("The elevator moved up [GLOB.turbo_lift_floors_moved_roundstat] floors today!")
	else if(GLOB.disposals_flush_shift_roundstat > 40)
		valid_stats_list.Add("The disposal system flushed a whole [GLOB.disposals_flush_shift_roundstat] times for this shift. We should really invest in waste treatement.")

*/
	if(GLOB.cans_opened_roundstat > 0)
		valid_stats_list.Add("За сегодня [ru_count(GLOB.cans_opened_roundstat, "была выпита", "было выпито", "было выпито")] [ru_count(GLOB.cans_opened_roundstat, "банка", "банки", "банок")] напитков!")
	else if(GLOB.lights_switched_on_roundstat > 0)
		valid_stats_list.Add("За сегодня свет был включён или выключен [ru_count(GLOB.lights_switched_on_roundstat, "раз", "раза", "раз")]!")
	else if(GLOB.turbo_lift_floors_moved_roundstat > 20)
		valid_stats_list.Add("Сегодня лифт поднялся и опустился на [ru_count(GLOB.turbo_lift_floors_moved_roundstat, "этаж", "этажа", "этажей")]!")
	else if(GLOB.disposals_flush_shift_roundstat > 40)
		valid_stats_list.Add("Мусоропроводная система была активирована [ru_count(GLOB.disposals_flush_shift_roundstat, "раз", "раза", "раз")] за эту смену. Пора бы вложиться в утилизацию.")

// End of Bastion of Endeavor Translation
	if(LAZYLEN(valid_stats_list))
		/* Bastion of Endeavor Translation
		to_world("<B>Shift trivia!</B>")
		*/
		to_world("<B>А теперь, интересные факты об этой смене!</B>")
		// End of Bastion of Endeavor Translation

		for(var/body in valid_stats_list)
			to_world("[body]")
