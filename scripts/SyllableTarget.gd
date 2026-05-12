extends Area2D

signal target_pressed(syllable, target_position)

@onready var label = $Label

var syllable = ""

func set_syllable(value):
	syllable = value
	label.text = value

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		target_pressed.emit(syllable, global_position)
