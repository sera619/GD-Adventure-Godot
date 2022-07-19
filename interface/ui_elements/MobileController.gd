extends CanvasLayer
class_name MobileController


func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $TouchScreenButton.is_pressed():
			var move_vector = calc_move_vector(event.position)
			print(move_vector)


func calc_move_vector(event_position):
	var texture_center = $TouchScreenButton.position + Vector2(64, 64)
	return (event_position - texture_center).normalized()
