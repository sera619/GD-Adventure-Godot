# The pause screen. It should exist in the main game scene but start hidden.
#
# Pressing the "pause" input action will show this screen and pause everything
# else.
extends Control

onready var _button_continue := $CenterContainer/VBoxContainer/ContinueButton
onready var _button_restart := $CenterContainer/VBoxContainer/RestartButton
onready var _button_quit := $CenterContainer/VBoxContainer/QuitButton

var paused: bool = false setget set_paused


func _ready():
	_button_continue.connect("pressed", self, "set_paused", [false])
	_button_restart.connect("pressed", self, "_restart_game")
	_button_quit.connect("pressed", self, "quit_game")

func quit_game():
	set_paused(not paused)
	Events.emit_signal("player_died")
	get_tree().change_scene("res://interface/MainMenu.tscn")

func _restart_game() -> void:
	set_paused(false)
	get_tree().reload_current_scene()

func _input(event: InputEvent) -> void:
	if event.is_action_released("pause_toggle"):
		set_paused(not paused)

func set_paused(new_pause_state: bool) -> void:
	paused = new_pause_state
	visible = paused
	get_tree().paused = paused
	if visible:
		_button_continue.grab_focus()
	
	AudioServer.set_bus_effect_enabled(1, 0, paused)


