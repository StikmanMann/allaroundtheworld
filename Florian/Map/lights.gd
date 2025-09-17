extends Node3D

func _turn_on_off_lights():
	if visible:
		hide()
	else:
		show()
