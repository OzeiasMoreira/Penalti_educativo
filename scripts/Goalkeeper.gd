extends Sprite2D

var start_position

func _ready():
	start_position = global_position

func defend(pos):
	var original = global_position
	global_position = pos
	await get_tree().create_timer(0.7).timeout
	global_position = original
