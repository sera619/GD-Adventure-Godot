extends Node

signal mob_died(score_value)
signal player_health_changed(new_health)
signal player_buff_active(bufftime, bufftype)
signal selected_spell_changed(new_selected_spell_scene)
signal save_game(player_score)
signal player_died

var current_score: int
var highscore_name: String
var current_player: String
const game_version = '1.2.5'
const Save_File = "user://game-data.save"

func _ready():
	self.connect("save_game", self, "save_score")


func save_score(new_score: int, playername: String):
	var save_game = File.new()
	save_game.open(Save_File, File.WRITE)
	var data := {
		"name": playername,
		"score": new_score
	}
	save_game.store_line(to_json(data))
	save_game.close()

func load_score():
	var save_game = File.new()
	if not save_game.file_exists(Save_File):
		return
	save_game.open(Save_File, File.READ)
	var data = parse_json(save_game.get_line())
	print(data)
	current_score = int(data['score'])
	highscore_name = str(data['name'])
