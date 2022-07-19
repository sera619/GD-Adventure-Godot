extends Control

onready var _button_restart := $CenterContainer/VBoxContainer/RestartButton
onready var _button_quit := $CenterContainer/VBoxContainer/QuitButton


func _ready() -> void:
	_button_restart.connect("pressed", self, "_on_RestartButton_pressed")
	_button_quit.connect("pressed", self, "_on_QuitButton_pressed")

	_button_restart.grab_focus()


func _on_RestartButton_pressed() -> void:
	get_tree().change_scene("res://game/Main.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().change_scene("res://interface/MainMenu.tscn")
