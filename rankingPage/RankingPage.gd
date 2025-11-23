extends CanvasLayer
signal restart_game
signal back_home
signal successMusic_Play
signal successMusic_Stop

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	GlobalVar.connect("backend_leaderboard_callback", Callable($LeaderBoard, "display"))
	
func game_over_entrypoint():
	emit_signal("successMusic_Play")
	#$SuccessMusic.playing = 1
	show_message("GAME OVER")
	#GlobalVar.backend_report_score()
	#var wsreq = {'type': GlobalVar.GetLeaderBoard,'param':'0'}
	#GlobalVar.send_message(JSON.stringify(wsreq))
	$LeaderBoard.visible = true

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
