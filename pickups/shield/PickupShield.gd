extends Pickup




func _on_robot_pickup(body: Robot):
	body.activate_shield()
	_disable()
	_animation_player.play("destroy")
