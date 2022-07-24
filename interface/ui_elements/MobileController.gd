extends CanvasLayer
class_name MobileController

signal joystick_move_vector(move_vector)

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $Joystick.is_pressed():
			var move_vector = calc_move_vector(event.position)
			print(move_vector)
			if move_vector.x > 0:
				Input.action_press("move_right")
			else:
				Input.action_release("move_right")
			
			if move_vector.x < 0:
				Input.action_press("move_left")
			else:
				Input.action_release("move_left")
			
			if move_vector.y > 0:
				Input.action_press("move_up")
			else:
				Input.action_release("move_up")
			
			if move_vector.y < 0:
				Input.action_press("move_down")
			else:
				Input.action_release("move_down")

func calc_move_vector(event_position):
	var texture_center = $Joystick.position + Vector2(64, 64)
	return (event_position - texture_center).normalized()
