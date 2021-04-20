/proc/create_objects_in_loc(var/atom/loc, var/list/item_paths)
	/* Bastion of Endeavor Translation
	if(!istype(loc))
		CRASH("Inappropriate loction given.")
	if(!istype(item_paths))
		CRASH("Inappropriate item path list given.")
	*/
	if(!istype(loc))
		CRASH("Недопустимая локация.")
	if(!istype(item_paths))
		CRASH("Недопустимый путь к элементу.")
	// End of Bastion of Endeavor Translation

	for(var/item_path in item_paths)
		for(var/i = 1 to max(1, item_paths[item_path]))
			new item_path(loc)
