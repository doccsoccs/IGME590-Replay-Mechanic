extends Node

var recording: bool = true
var position_record: Array[Vector2] = []
@onready var entity = $".."

func _process(_delta):
	if recording:
		position_record.push_back(entity.position)

func _input(event):
	if event.is_action_pressed("Rewind"):
		recording = false
		entity.init_rewind(position_record)
	elif event.is_action_released("Rewind"):
		entity.end_rewind()
		recording = true
