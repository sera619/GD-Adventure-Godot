extends Pickup


export var boost_speed: int


func _on_robot_pickup(body: Robot):
	body.speed_boost(boost_speed)
	_disable()
	_animation_player.play("destroy")
