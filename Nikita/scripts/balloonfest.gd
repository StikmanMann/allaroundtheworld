extends Node3D

var paused = false
var finished = false
var main_scene : PackedScene

func _ready() -> void:
	$PauseMenu.hide()
	$PauseMenu.resume.connect(_on_resume_button_pressed)
	$PauseMenu.main_menu.connect(_on_menu_button_pressed)
	$FinishScreen.hide()
	$FinishScreen.retry.connect(_on_retry_button_pressed)
	$FinishScreen.exit.connect(_on_exit_button_pressed)
	main_scene = load("res://Nikita/hub_scene.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("take_picture"):
		await PictureTakeablesArray.calcualtion_finished
		finish()
	if Input.is_action_just_pressed("pause"):
		pause_menu()

func pause_menu():
	if paused:
		$PauseMenu.hide()
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		$PauseMenu.show()
		get_tree().paused = true
	paused = !paused

func finish():
	if finished:
		$FinishScreen.hide()
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		$FinishScreen.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
	finished = !finished

func _on_resume_button_pressed():
	pause_menu()

func _on_menu_button_pressed():
	pause_menu()
	get_tree().change_scene_to_packed(main_scene)

func _on_retry_button_pressed():
	finish()
	PictureTakeablesArray.picture_takables.clear()
	PictureTakeablesArray.picture_spots.clear()
	get_tree().reload_current_scene()

func _on_exit_button_pressed():
	finish()
	get_tree().change_scene_to_packed(main_scene)
