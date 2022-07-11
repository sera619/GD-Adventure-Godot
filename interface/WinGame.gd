extends Control

onready var _button_restart := $CenterContainer/VBoxContainer/RestartButton
onready var _button_quit := $CenterContainer/VBoxContainer/QuitButton


func _ready() -> void:
	_button_restart.connect("pressed", get_tree(), "change_scene", ["res://Main.tscn"])
	_button_quit.connect("pressed", get_tree(), "quit")
	_button_restart.grab_focus()
