extends Area2D

var HP = 100
var speed = 600

func _process(delta):
	var velocity = Vector2.DOWN * speed
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.


func _on_Mob_body_entered(body):
	#print("mob body entered")
	if not body.is_in_group("PlayerBullet"):
		return
	$MusicController.bulletHitMusicPlay()
	#$BulletHitMusic.playing = 1
	HP -= body.damage
	body.queue_free()
	if HP <= 0:
		GlobalVar.score+=1
	pass # Replace with function body.

func _on_Mob_area_entered(area):
	# check if the area is bullet, send to body entered handler
	if area.is_in_group("PlayerBullet") or area.is_in_group("player_bullets"):
		_on_Mob_body_entered(area)

func getProp():
	pass

func explore():
	HP=0
	GlobalVar.score+=1
