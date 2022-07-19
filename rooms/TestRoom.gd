extends YSort

onready var mob_spawner := $Mobs/SpawnerMob
onready var mob_container := $Mobs


func _ready():
#	mob_spawner.spawn()
	spawn_mobs()


func spawn_mobs():
	var mob_spawns = mob_container.get_children()
	for mob in mob_spawns:
		mob.spawn()
