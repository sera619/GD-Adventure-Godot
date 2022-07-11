extends Mob
class_name MobShield

onready var _cannon := $Cannon
onready var _raycast := $RayCast2D

var canSeePlayer: bool = false
export var multiple_fire: bool
export var cast_times: int
func _physics_process(delta: float) -> void:
	if not _target:
		return
	
	_raycast.look_at(_target.global_position)
	_raycast.force_raycast_update()
	
	_cannon.look_at(_target.global_position)
	
	if not _raycast.get_collider() is KinematicBody2D:
		return
	if _target_within_range:
		orbit_target()
		_prepare_to_attack()
	else:
		follow(_target.global_position)



func _prepare_to_attack() -> void:
	if not is_ready_to_attack():
		return
	_before_attack_timer.start()

func _on_BeforeAttackTimer_timeout() -> void:
	if not _target:
		return
	if multiple_fire:
		for i in cast_times:
			_cannon.shoot_at_target(_target)
	else:
		_cannon.shoot_at_target(_target)
	_cooldown_timer.start()
