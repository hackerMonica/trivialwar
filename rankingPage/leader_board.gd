extends ScrollContainer

func display(data_array: Array):
	# Remove all old entries
	for child in get_children():
		child.queue_free()
		
	# create table
	var grid = GridContainer.new()
	grid.columns = 3
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid.add_theme_constant_override("h_separation", 50)
	grid.add_theme_constant_override("v_separation", 20)
	add_child(grid)
	
	var add_cell = func(text):
		var label = Label.new()
		label.text = str(text)
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.add_theme_font_size_override("font_size", 30)
		grid.add_child(label)

	add_cell.call("Name")
	add_cell.call("Score")
	add_cell.call("Date")
	
	for item in data_array:
		add_cell.call(item.get("UserName", "Unknown"))
		add_cell.call(item.get("Score", "0"))
		
		var date_str = item.get("Date", "")
		if "T" in date_str:
			date_str = date_str.split("T")[0].replace("-", "/")
		add_cell.call(date_str)
