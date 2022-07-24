extends Sprite
class_name ShieldBuff



export(int, 1, 5) var shield_charges
export (bool) var shield_active

onready var shield_collider = $ShieldArea

var current_charges: int = 0


func _ready():
	set_shield_active(false)


func set_shield_active(new_shield_state: bool):
	shield_active = new_shield_state
	if shield_active:
		self.visible = true
		current_charges = shield_charges
		Events.emit_signal('player_shield_changed', current_charges)
		shield_collider.monitoring = true
	else:
		self.visible = false
		shield_collider.monitoring = true

func is_shield_active() -> bool:
	return shield_active

func remove_shield_charge(value: int):
	current_charges -= value
	Events.emit_signal("player_shield_changed", current_charges)
	if current_charges <= 0:
		set_shield_active(false)



func _on_ShieldArea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if not shield_active or area.is_in_group('pickup') or area.is_in_group('spellholder') or area.is_in_group('mobshape'):
		return
	else:
		match local_shape_index:
			00:
				self.material.set_shader_param("center", Vector2(-0.3, -0.3))
			01:
				self.material.set_shader_param("center", Vector2(0.3, -0.3))
			02:
				self.material.set_shader_param("center", Vector2(-0.3, 0.3))
			03:
				self.material.set_shader_param("center", Vector2(0.3, 0.3))
		remove_shield_charge(1)
		$ShieldAnimator.play("shock")
		if area.is_in_group('mobhurtbox'):
			return
		area.queue_free()
		
