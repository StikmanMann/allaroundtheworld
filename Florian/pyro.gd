extends Node3D

func _turn_on_off():
	if visible:
		hide()
	else:
		show()
