extends Control


export (Texture ) var icon_texture

onready var _buff_icon := $HBoxContainer/BuffIcon
onready var _buff_label := $HBoxContainer/Label
onready var _animation := $AnimationPlayer
onready var _buff_timer := $Timer

func _ready():
	self.visible = false
	_buff_icon.texture = icon_texture
	Events.connect("player_buff_active", self, "_buff_active")
	_buff_timer.connect("timeout", self, "hide_buffbar")


func _buff_active(bufftime, bufftype):
	self.visible = true
	_animation.play("active")
	_buff_timer.start(bufftime)
	if bufftype == "speed":
		_buff_label.text = "Speedboost"
	
	
func hide_buffbar():
	_animation.play("RESET")
	self.visible = false
	
