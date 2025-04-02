extends Node

func _input(event):
	if event.is_action_pressed("Exit"):
		get_tree().quit()
