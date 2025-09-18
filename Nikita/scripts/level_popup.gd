extends Node2D

signal enter_level

func _on_play_button_pressed() -> void:
	emit_signal("enter_level")
