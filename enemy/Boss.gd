extends "res://enemy/mob.gd"

var x_range=0.8
var shootNum = 3

func _ready():
	$MusicController.bossBgmPlayCircle()
	add_to_group('CanShoot')

func _init():
	speed = 10
	HP = 2000

func _process(delta):
	if position.x<=0.5*(1-x_range)*get_viewport_rect().size.x||position.x>=0.5*(1+x_range)*get_viewport_rect().size.x:
		speed=-speed
	var velocity = Vector2.RIGHT * speed
	position += velocity * delta

var bullet_scene = preload("res://bullet/EnemyBullet.tscn") 
func shoot():
#	var bullet = bullet_scene.instance()
#	bullet.position.x = position.x
#	bullet.position.y = position.y
#	bullet.speedY = 1000
#	# Add bullet
#	return [bullet]
	return $BulletStrategy.multiShoot(shootNum,self)

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

func explore():
	if(HP>500):
		HP-=500
	else:
		HP=0
		GlobalVar.score+=1
		$MusicController.bossBgmStop()
		GlobalVar.have_boss = 0

func _on_Boss_body_entered(body):
	super._on_Mob_body_entered(body)
	if HP <= 0:
		GlobalVar.score+=1
		$MusicController.bossBgmStop()
		#$BossBgmMusic.stop()
		GlobalVar.have_boss = 0

func _on_Boss_area_entered(area):
	# check if the area is bullet, send to body entered handler
	if area.is_in_group("PlayerBullet") or area.is_in_group("player_bullets"):
		_on_Boss_body_entered(area)
