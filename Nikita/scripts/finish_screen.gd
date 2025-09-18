extends Control

signal retry
signal exit

@onready var points: Label = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Points


func _on_retry_pressed() -> void:
	emit_signal("retry")


func _on_exit_pressed() -> void:
	emit_signal("exit")


func _on_visibility_changed() -> void:
	if not points:
		return
	points.text = str(PictureTakeablesArray.points)
	pass # Replace with function body.
