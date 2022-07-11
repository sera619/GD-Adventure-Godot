extends Bullet

onready var _sprite := $Sprite
onready var _particles := $Particles2D


func _ready() -> void:
	_audio.connect("finished", self, "queue_free")


func _destroy() -> void:
	_disable()
	_sprite.hide()
	_particles.emitting = true
	speed = 0.0
	_audio.play()
