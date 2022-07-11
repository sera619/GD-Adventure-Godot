extends Spell
class_name IcePunshSpell

var spell_time = 3

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and _cooldown_timer.is_stopped():
		shoot()

func shoot() -> void:
	for i in spell_time:
		.shoot()
	_cooldown_timer.start()
