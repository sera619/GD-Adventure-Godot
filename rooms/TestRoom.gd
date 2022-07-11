extends YSort

onready var mob_spawner := $Mobs/SpawnerMob

func _ready():
	mob_spawner.spawn()
