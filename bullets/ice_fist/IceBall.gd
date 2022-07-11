extends Bullet

onready var _animation_player := $AnimationPlayer as AnimationPlayer
var start_speed = 5
var max_speed
func _init():
	max_speed = speed
	speed = start_speed
func _ready() -> void:
	_animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	_animation_player.play("spawn")

func _move(delta: float) -> void:
	var distance := speed * delta
	var motion := transform.x * speed * delta
	
	position += motion

	_travelled_distance += distance
	if speed != max_speed:
		speed += .01
	if _travelled_distance > max_range:
		_destroy()

func _destroy():
	_disable()
	_audio.play()
	_animation_player.play("destroy")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "destroy":
		queue_free()
