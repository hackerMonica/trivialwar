extends CanvasLayer
signal start_game
signal startOver_play
signal startOver_stop
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	show_message("Aircraft Battle")

func show_message(text):
	emit_signal("startOver_play")
	#$StartOver.play()
	$Message.text = text
	$Message.show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_EasyButton_pressed():
	emit_signal("startOver_stop")
	#$StartOver.playing = 0
	GlobalVar.Difficulty="easy"
	$EasyButton.hide()
	$NormalButton.hide()
	$HardButton.hide()
	emit_signal("start_game")
	$MessageTimer.start()

func _on_NormalButton_pressed():
	emit_signal("startOver_stop")
	#$StartOver.playing = 0
	GlobalVar.Difficulty="normal"
	$EasyButton.hide()
	$NormalButton.hide()
	$HardButton.hide()
	emit_signal("start_game")
	$MessageTimer.start()


func _on_HardButton_pressed():
	emit_signal("startOver_stop")
	#$StartOver.playing = 0
	GlobalVar.Difficulty="hard"
	$EasyButton.hide()
	$NormalButton.hide()
	$HardButton.hide()
	emit_signal("start_game")
	$MessageTimer.start()


func _on_MessageTimer_timeout():
	$Message.hide()
