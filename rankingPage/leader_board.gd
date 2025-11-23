extends ScrollContainer


func parse_date(iso_date: String) -> String:
	var date := iso_date.split("T")[0].split("-")
	var time := iso_date.split("T")[1].trim_suffix("Z").split(":")

	return str(date[0]) + "-" + str(date[1]) + "-" + str(date[2])


var entry_scene = preload("res://rankingPage/LeaderBoardEntry.tscn")
func display(json_raw):
	# Remove all old entries
	for child in get_children():
		remove_child(child)
		
	var height = 0
	var header = entry_scene.instantiate()
	header.position.y = height
	header.set_text("Name   Score   Date")
	add_child(header)
	height += 100
		
	# Add new entries
	var test_json_conv = JSON.new()
	test_json_conv.parse(json_raw)
	var json_res = test_json_conv.get_data()
	print(json_res)
	for item in json_res:
		var entry = entry_scene.instantiate()
		entry.position.y = height
		entry.set_text(str(item['UserName']) + "   " + str(item['Score']) + "   " + parse_date(item["Date"]))
		add_child(entry)
		height += 100
