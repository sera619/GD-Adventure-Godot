extends YSort



export(Array, PackedScene) var rooms := []
export var grid_width := 2
export var grid_height := 2
export var room_size := Vector2(13, 13) * 128

onready var _pause_screen := $UILayer/PauseScreen
onready var _music_player := $MusicPlayer

func _ready():
	randomize()
	_pause_screen.hide()
	_music_player.play()
	generate_level()

func generate_level() -> void:
	var last_room_index := (grid_width * grid_height) - 1
	var current_room_index := 0
	for x in grid_width:
		for y in grid_height:
			var room_position := Vector2(x,y)
			var RoomScene: PackedScene = rooms[randi() % rooms.size()]
			var room: BaseRoom = RoomScene.instance()
			room.global_position = room_size * room_position
			add_child(room)
			
			if current_room_index == 0:
				room.spawn_robot()
				room.spawn_items()
			elif current_room_index == last_room_index:
				room.spawn_teleporter()
				room.spawn_mobs()
			else:
				room.spawn_items()
				room.spawn_mobs()
				
			if x == 0:
				room.hide_left_bridge()
			elif x == grid_width -1:
				room.hide_right_bridge()
			
			if y == 0:
				room.hide_top_bridge()
			elif y == grid_height - 1:
				room.hide_bottom_bridge()
				
			current_room_index += 1
