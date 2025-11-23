extends "res://enemy/mob.gd"
var shootNum = 1

func _init():
	speed = 700
	HP = 200
	
func _ready():
	add_to_group("CanShoot")

var bullet_scene = preload("res://bullet/EnemyBullet.tscn") 
func shoot():
#	var bullet = bullet_scene.instance()
#	bullet.position.x = position.x
#	bullet.position.y = position.y
#	bullet.speedY = 1000
#	# Add bullet
#	return [bullet]
	return $BulletStrategy.straightShoot(shootNum,self)

func getProp():
	var string
	var rand = randf()
	if(rand < 0.4):
		string = "Blood"
	elif(rand>=0.4&&rand<0.6):
		string = "Bullet"
	elif(rand>=0.6&&rand<0.8):
		string = "Bomb"
	else:
		return null
	
	var props_scene = load("res://props/"+string+".tscn")
	var props = props_scene.instantiate()
	props.position.x = position.x
	props.position.y = position.y
	return props
