extends CanvasLayer
signal restart_game
signal back_home
signal successMusic_Play
signal successMusic_Stop

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	# GlobalVar.connect("backend_leaderboard_callback", Callable($LeaderBoard, "display"))
	$NameButton.pressed.connect(_on_NameButton_pressed)
	$NameInput.hide()
	$NameButton.hide()
	
func game_over_entrypoint():
	emit_signal("successMusic_Play")
	#$SuccessMusic.playing = 1
	show_message("GAME OVER")
	#GlobalVar.backend_report_score()
	#var wsreq = {'type': GlobalVar.GetLeaderBoard,'param':'0'}
	#GlobalVar.send_message(JSON.stringify(wsreq))
	$LeaderBoard.visible = false
	$NameInput.show()
	$NameInput.clear()
	$NameInput.grab_focus()
	$NameButton.show()
	$RestartButton.hide()
	$HomeButton.hide()
	# $LeaderBoard.visible = true

func _on_NameButton_pressed():
	var input_name = $NameInput.text.strip_edges()
	if input_name == "":
		return
		
	GlobalVar.userName = input_name

	_save_and_show_leaderboard()
	$NameInput.hide()
	$NameButton.hide()
	
func _save_and_show_leaderboard():
	GlobalVar.save_ranking_data(GlobalVar.userName, GlobalVar.score)
	var json_data = GlobalVar.load_ranking_data()

	$LeaderBoard.display(json_data)
	$LeaderBoard.visible = true
	$RestartButton.show()
	$HomeButton.show()

func show_message(text):
	$Message.text = text
	$Message.show()
	



func _on_MessageTimer_timeout():
	$Message.hide()

# MessageTimer is set to oneshot
# means do not need to stop after timeout
func _on_RestartButton_pressed():
	emit_signal("successMusic_Stop")
	#$SuccessMusic.playing = 0
	GlobalVar.score = 0
	$RestartButton.hide()
	$HomeButton.hide()
	emit_signal("restart_game")
	$MessageTimer.start()
	$LeaderBoard.visible = false


func _on_HomeButton_pressed():
	emit_signal("successMusic_Stop")
	#$SuccessMusic.playing = 0
	GlobalVar.score = 0
	$RestartButton.hide()
	$HomeButton.hide()
	$Message.hide()
	emit_signal("back_home")
	$MessageTimer.start()
	$LeaderBoard.visible = false
