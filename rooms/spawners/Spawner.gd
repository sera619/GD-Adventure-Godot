class_name Spawner
extends Sprite

export(Array, PackedScene) var list := []
export(int, 0,100) var spwan_chance: int = 100

func _ready() -> void:
	texture = null

func spawn() -> void:
	if not list:
		return
	
	var will_spawn := rand_range(0,99) < spwan_chance
	if not will_spawn:
		return
	
	var random_scene_index := randi() % list.size()
	var scene: PackedScene = list[random_scene_index]
	if not scene:
		return
	
	var node: Node2D = scene.instance()
	get_parent().add_child(node)
	node.global_position = global_position


