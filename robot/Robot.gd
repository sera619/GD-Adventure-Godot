# The player class.
#
# The node only does two things:
#
# 1. It moves and collides
# 2. It handles health, and dying
#
# The shooting is handled by a completely different node with completely
# independent code.
#
# The Sprite direction is handled automatically, also independently
class_name Robot
extends KinematicBody2D

# This controls both the character's maximum and starting health.
export var max_health := 5
export var max_shield := 5
# The character's speed in pixels per second.
export var speed := 650.0
# Controls how quickly the body reaches its desired velocity. A value of 1 makes
# the character move instantly at its maximum speed.
export(float, 0.01, 1.0) var drag_factor := 0.12

# The health property uses a setter to ensure that it never goes above
# max_health or below 0.
var health := max_health setget set_health
var velocity := Vector2.ZERO
var normal_speed
onready var _camera: ShakingCamera2D = $ShakingCamera2D
onready var _damage_audio = $DamageAudio
onready var _death_audio = $DeathAudio
onready var _skin := $Skin
onready var _smoke_particles := $SmokeParticles
onready var _spell_holder := $SpellHolder
onready var _speed_timer := $SpeedTimer
onready var _buff_effects := $BuffEffects
onready var _shield_holder := $Shield


func _ready() -> void:
	normal_speed = speed
	# When the death audio finished playing, we go to the game over screen by
	# calling get_tree().change_scene().
	_death_audio.connect("finished", get_tree(), "change_scene", ["res://interface/GameOver.tscn"])
	_speed_timer.connect("timeout", self, "_reset_speed")

# This is the same steering movement code you used since the start of the
# course.
func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_velocity := speed * direction
	var steering := desired_velocity - velocity
	velocity += steering * drag_factor
	velocity = move_and_slide(velocity, Vector2.ZERO)
	_smoke_particles.emitting = velocity.length() > speed / 2.0

	
	
# Health setter, we make sure health is always between 0 and max
func set_health(new_health: int) -> void:
	health = clamp(new_health, 0, max_health)

func activate_shield():
	_shield_holder.set_shield_active(true)


# Called by the Teleport node when we walk over it. This jumps to the win screen
# scene.
func teleport() -> void:
	get_tree().change_scene("res://interface/WinGame.tscn")

func speed_boost(new_speed: int) -> void:
	_buff_effects.play("SpeedBuffEffect")
	_speed_timer.start(4.0)
	Events.emit_signal("player_buff_active", 4.0, "speed")
	speed = new_speed

func _reset_speed() -> void:
	_buff_effects.play("RESET")
	speed = normal_speed

# Called by enemy bullets when they hit the robot.
func take_damage(amount: int) -> void:
	if _shield_holder.is_shield_active():
		return
	if health <= 0:
		
		return

	set_health(health - amount)
	Events.emit_signal("player_health_changed", health)
	# If the health is lower or equal to zero, we're dead, so we disable
	# movement.
	if health <= 0:
		Events.emit_signal("player_died")
		_disable()
		# We play the death animation and sound too.
		_skin.die()
		_death_audio.play()
		_spell_holder.hide()
	else:
		_damage_audio.play()
		_camera.shake_intensity += 0.6


# Makes the player interact with nothing and stop receiving inputs
func _disable() -> void:
	set_process(false)
	set_physics_process(false)
	collision_layer = 0
	collision_mask = 0



