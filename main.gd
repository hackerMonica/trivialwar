extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVar.connect("backend_login_callback", Callable($loginPage, "login_callback"))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
