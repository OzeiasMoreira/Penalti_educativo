extends Sprite2D

var start_position
var moving = false
var target_position
var speed = 500

func _ready():
	start_position = global_position

func kick_to(pos, is_goal):
	target_position = pos
	moving = true

func _process(delta):
	if moving:
		global_position = global_position.move_toward(target_position, speed * delta)

		if global_position.distance_to(target_position) < 5:
			moving = false
			await get_tree().create_timer(0.5).timeout
			global_position = start_position	
