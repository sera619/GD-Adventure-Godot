extends Control

var _score := 0
onready var _health_bar := $HealthBar
onready var _score_label := $ScoreLabel

onready var mobile_controller = preload("res://interface/ui_elements/MobileController.tscn")



func _ready():
#	var controller = mobile_controller.instance()
#	self.add_child(controller)
	_set_score(0)
	Events.connect("mob_died", self,"_on_Events_mob_died")
	Events.connect("player_health_changed", self, "_on_player_health_changed")
	Events.connect("player_died",self, "save")
	
	
func _set_score(new_score: int) -> void:
	_score = new_score
	_score_label.text = str(_score).pad_zeros(5)


func _on_Events_mob_died(mob_score_value: int) -> void:
	_set_score(_score + mob_score_value)


func _on_player_health_changed(new_health: int) -> void:
	_health_bar.health = new_health

func save():
	if _score > Events.current_score:
		Events.emit_signal('save_game', _score, Events.current_player)
	else: 
		return
