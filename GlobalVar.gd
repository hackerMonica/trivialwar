extends Node
var Difficulty
var score = 0
var have_boss = 0
var GameLevel = 0 # 0, 1, 2 for easy normal hard

# Multi-player
var is_multiplayer_mode = true
var is_login = false

# Signals
signal update_multi_player_score(raw_data)
signal backend_login_callback(message)
signal backend_signup_callback(message)
signal backend_leaderboard_callback(data)

var screen_size

var userName: String
var passWord: String

# Commands
const GetAllUsers = 0
const JoinUser = 1
const StartMultiplayerGame = 2
const ReportScore = 3
const GetLeaderBoard = 4
const Login = 5
const Signup = 6


func _ready():
	screen_size = get_viewport().get_visible_rect().size
	print("Screen size" + str(screen_size))
	
