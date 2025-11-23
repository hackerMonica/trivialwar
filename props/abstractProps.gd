extends Area2D
var speedY = 400
var speedX = (randf() - 0.5) * 2 * speedY
var direction = -1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group('props')

func _process(delta):
	var velocity = Vector2.UP * abs(speedY) * direction
	velocity += Vector2.RIGHT * speedX
	position += velocity * delta
	if(position.x>=GlobalVar.screen_size.x || position.x<=0):
		speedX=-speedX


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
