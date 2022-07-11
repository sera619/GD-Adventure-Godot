## Shoots a bunch of fire pellets in a spray area
class_name SpellFire
extends Spell

export (float, 100.0, 2000.0, 1.0) var min_range := 200.0
export (float, 100.0, 3000.0, 1.0) var min_bullet_speed := 800.0

export (int, 1, 30) var min_amount := 6
export (int, 1, 30) var max_amount := 9


func _init() -> void:
	assert(min_range < max_range)
	assert(min_bullet_speed < max_bullet_speed)
	assert(min_amount < max_amount)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and _cooldown_timer.is_stopped():
		shoot()


func shoot() -> void:
	_cooldown_timer.start()
	
	# We want to shoot a random number of bullets
	var bullet_count := rand_range(min_amount, max_amount + 1)
	
	for index in bullet_count:
		# The code to spawn each bullet is similar to the original shoot()
		# code
		var bullet: Bullet = bullet_scene.instance()
		get_tree().root.add_child(bullet)
		var fire_range := rand_range(min_range, max_range)
		var speed := rand_range(min_bullet_speed, max_bullet_speed)
		bullet.global_transform = global_transform
		bullet.max_range = fire_range
		bullet.speed = speed
		bullet.randomize_rotation(deg2rad(random_angle_degrees))

	# We only want to play audio once, otherwise, if we played it on each
	# bullet, all sounds would stack up and be really loud and ugly.
	_audio.play()
