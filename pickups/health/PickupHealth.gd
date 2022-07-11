extends Pickup

export var heal_amount: int = 2

func _on_robot_pickup(robot: Robot) -> void:
	robot.health += heal_amount
	_disable()
	_animation_player.play("destroy")
