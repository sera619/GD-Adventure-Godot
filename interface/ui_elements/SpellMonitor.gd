extends HBoxContainer

onready var flame_icon := $Flame/LitIcon
onready var ice_icon := $Ice/LitIcon
onready var light_icon := $Lightning/LitIcon



func _ready():
	Events.connect("selected_spell_changed", self, "_show_spell_icon")


func _show_spell_icon(icon: int) -> void:
	_reset_icons()
	if icon == 1:
		flame_icon.visible = true
	elif icon == 2:
		ice_icon.visible = true
	elif icon == 3:
		light_icon.visible = true
	else:
		return

func _reset_icons():
	ice_icon.visible = false
	flame_icon.visible = false
	light_icon.visible = false
