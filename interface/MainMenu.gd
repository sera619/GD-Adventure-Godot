extends Control


onready var _load_button := $Menu/VBoxContainer/LoadButton
onready var _start_button := $Menu/VBoxContainer/StartButton
onready var _info_button := $Menu/VBoxContainer/InfoButton
onready var _exit_button := $Menu/VBoxContainer/ExitButton
onready var _highscore_button := $Menu/VBoxContainer/HighscoreButton
onready var _music_player := $MusicPlayer
onready var _version_label := $Header/V/VersionLabel
onready var _score_board := $Scores
onready var _name_board := $NamePanel
onready var _game_start_button := $NamePanel/V/H/StartGame
onready var _cancel_start_button := $NamePanel/V/H/Cancel
onready var _menu_container := $Menu
onready var _name_edit := $NamePanel/V/NameEdit
onready var _name_infolabel := $NamePanel/V/NameInfolabel

func _ready():
	randomize()
	_score_board.visible = false
	_name_board.visible = false
	_start_button.connect('pressed', self ,'show_nameboard')
	_info_button.connect('pressed', self, 'show_information')
	_exit_button.connect('pressed', self, 'exit_game')
	_highscore_button.connect('pressed', self, 'show_highscore')
	_cancel_start_button.connect('pressed', self, 'show_nameboard')
	_game_start_button.connect('pressed', self, 'start_game')
	_version_label.text = 'Version ' + Events.game_version
	_music_player.play()

func exit_game():
	get_tree().quit()

func show_nameboard():
	if _name_board.visible:
		_name_board.visible = false
		_menu_container.visible = true
	else:
		_name_board.visible = true
		_menu_container.visible = false

func show_highscore():
	set_highscore()
	if !_score_board.visible:
		_score_board.visible = true
	else:
		_score_board.visible = false

func set_highscore():
	var score_label = $Scores/V/HighscoreLabel
	var score_playername = ""
	Events.load_score()
	if str(Events.highscore_name) == "":
		score_playername = "Anonymous"
	else:
		score_playername = Events.highscore_name
	score_label.text = "The actual highscore is claimed by\n" + score_playername +"\nwith\n" + str(Events.current_score)+"\npoints."

func show_information():
	OS.shell_open("https://github.com/sera619/GD-Adventure-Godot")
	

func get_player_name():
	if _name_edit.text == "":
		_name_infolabel.text = "Enter a valid name!"
		return
	Events.current_player = _name_edit.text

func start_game():
	get_player_name()
	get_tree().change_scene("res://game/Main.tscn")
