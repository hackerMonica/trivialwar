extends 'res://props/abstractProps.gd'


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	add_to_group("bullet")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
