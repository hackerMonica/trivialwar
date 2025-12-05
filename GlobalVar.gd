extends Node
var Difficulty
var score = 0
var have_boss = 0
var GameLevel = 0 # 0, 1, 2 for easy normal hard

# Multi-player
var is_multiplayer_mode = true
var is_login = false

# Signals
# signal update_multi_player_score(raw_data)
# signal backend_login_callback(message)
# signal backend_signup_callback(message)
# signal backend_leaderboard_callback(data)

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
	
const RankingFile = "user://ranking_data.json"
func save_ranking_data(username, score_value):
	var content = []
	var file
	if FileAccess.file_exists(RankingFile):
		file = FileAccess.open(RankingFile, FileAccess.READ)
		var content_ = file.get_as_text()
		if content_!="":
			var json = JSON.new()
			json.parse(content_)
			content = json.get_data()
			file.close()
	var time = Time.get_datetime_dict_from_system()
	content.append({"UserName":username, "Score":score_value, "Date": str(time.month)+"/"+str(time.day)})
	#only keep top 10
	content.sort_custom(func(a,b):
		return float(a["Score"]) > float(b["Score"])
	)
	if content.size()>10:
		content = content.slice(0,10)

	file = FileAccess.open(RankingFile, FileAccess.WRITE)
	var content_str = JSON.stringify(content)
	file.store_string(content_str)
	file.close()

func load_ranking_data()->Array:
	var content = []
	if FileAccess.file_exists(RankingFile):
		var file = FileAccess.open(RankingFile, FileAccess.READ)
		var content_ = file.get_as_text()
		if content_!="":
			var json = JSON.new()
			json.parse(content_)
			content = json.get_data()
			content.sort_custom(func(a,b):
				return float(b["Score"]) < float(a["Score"])
			)
			file.close()
	return content
