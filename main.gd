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

var main_game_scene = preload("res://MainGame.tscn")
func _on_ChoosePVP_multiPlay():
	GlobalVar.is_multiplayer_mode = true
	var mainGame = main_game_scene.instantiate()
	add_child(mainGame)
	remove_child($ChoosePVP)
	pass # Replace with function body.


func _on_ChoosePVP_singlePlay():
	GlobalVar.is_multiplayer_mode = false
	var mainGame = main_game_scene.instantiate()
	add_child(mainGame)
	remove_child($ChoosePVP)
	pass # Replace with function body.

var choose_PVP_scene = preload("res://choosePVP/ChoosePVP.tscn")
func _on_loginPage_confirmAccount():
	var choosePVP = choose_PVP_scene.instantiate()
	add_child(choosePVP)
	choosePVP.connect("singlePlay", Callable(self, "_on_ChoosePVP_singlePlay"))
	choosePVP.connect("multiPlay", Callable(self, "_on_ChoosePVP_multiPlay"))
	remove_child($loginPage)
	pass # Replace with function body.

var loginPage_scene = preload("res://loginPage/LoginPage.tscn")
var loginPage
func _on_signinPage_signinConfirm():
	loginPage = loginPage_scene.instantiate()
	remove_child($SigninPage)
	add_child(loginPage)
	loginPage.connect("confirmAccount", Callable(self, "_on_loginPage_confirmAccount"))
	loginPage.connect("signinAccount", Callable(self, "_on_loginPage_signinAccount"))

var signinPage_scene = preload("res://signinPage/SigninPage.tscn")
var signinPage
func _on_loginPage_signinAccount():
	signinPage = signinPage_scene.instantiate()
	add_child(signinPage)
	GlobalVar.connect("backend_signup_callback", Callable(signinPage, "backend_callback"))
	signinPage.connect("signinConfirm", Callable(self, "_on_signinPage_signinConfirm"))
	signinPage.connect("signinBack", Callable(self, "_on_signinPage_signinBack"))
	remove_child($loginPage)
	pass # Replace with function body.

func _on_signinPage_signinBack():
	loginPage = loginPage_scene.instantiate()
	remove_child($SigninPage)
	add_child(loginPage)
	loginPage.connect("confirmAccount", Callable(self, "_on_loginPage_confirmAccount"))
	loginPage.connect("signinAccount", Callable(self, "_on_loginPage_signinAccount"))
