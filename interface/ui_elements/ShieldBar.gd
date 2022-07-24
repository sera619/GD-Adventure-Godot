# A health bar for the player. This component connects to the global events bus
# and updates automatically (see Events.gd for more information).
#
# The health bar uses the tool mode so that you can directly test it in the
# editor and see how it looks with different amounts of health.
#
# To draw the health, we instantiate one TextureRect for each health point.
tool
class_name UIShieldBar
extends HBoxContainer

export var shield_full: Texture
export var shield_empty: Texture

export var max_shield := 5 setget set_max_shield
export var shield := 0 setget set_shield


func _ready() -> void:
	set_shield(0)
	_redraw_mana_bar()


# Called when modifying the health property or when Events emits the
# "player_health_changed" signal.
func set_shield(new_shield: int) -> void:
	# The clamp() function prevents the new_health from going over max_health or
	# below 0.
	shield = clamp(new_shield, 0, max_shield)
	_redraw_mana_bar()


# Setter for max_health. We need a setter because we need to redraw the bar when
# max_health changes.
func set_max_shield(new_max_shield: int) -> void:
	max_shield = new_max_shield
	_redraw_mana_bar()

func hide_shield_bar():
	self.visible = false

func _redraw_mana_bar() -> void:
	# Because we use individual TextureRect nodes to draw health points, to
	# redraw the bar, we delete all the existing nodes and create new ones with
	# the appropriate texture.
	for child in get_children():
		child.queue_free()

	# We need as many nodes as there is max_health: one texture per health
	# point.
	for index in max_shield:
		var heart := TextureRect.new()
		# As long as index is below or equal to health, draw a full heart.
		if index < shield:
			heart.texture = shield_full
		# When index is higher than health, draw an empty heart.
		else:
			heart.texture = shield_empty
		add_child(heart)
