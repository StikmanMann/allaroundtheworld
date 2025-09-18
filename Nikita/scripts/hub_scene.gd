extends Node3D

var paused = false
var main_scene : PackedScene

func _ready() -> void:
	$PauseMenu.hide()
	$PauseMenu.resume.connect(_on_resume_button_pressed)
	$PauseMenu.main_menu.connect(_on_menu_button_pressed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_menu()

func pause_menu():
	if paused:
		$PauseMenu.hide()
		Engine.time_scale = 1
	else:
		$PauseMenu.show()
		Engine.time_scale = 0
	paused = !paused

func _on_resume_button_pressed():
	pause_menu()

func _on_menu_button_pressed():
	pause_menu()
