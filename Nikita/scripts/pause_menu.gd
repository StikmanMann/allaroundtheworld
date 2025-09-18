extends Control

signal resume
signal main_menu

func _on_resume_pressed() -> void:
	emit_signal("resume")


func _on_main_menu_pressed() -> void:
	emit_signal("main_menu")


func _on_quit_pressed() -> void:
	get_tree().quit()
