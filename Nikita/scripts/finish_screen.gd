extends Control

signal retry
signal exit

func _on_retry_pressed() -> void:
	emit_signal("retry")


func _on_exit_pressed() -> void:
	emit_signal("exit")
