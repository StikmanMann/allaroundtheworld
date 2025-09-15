extends Node3D

var rotation_speed = PI/2
var min_zoom = 1.3
var max_zoom = 5.0
var zoom_speed = 0.2

var zoom = 2.0
var mouse_grab_sensitivity = 0.006
var grabbed : bool = false
var velocity_y = 0.0
var dampening_y = 0.3
var stop_threashold_y = 0.5
var velocity_x = 0.0
var dampening_x = 0.1
var stop_threashold_x = 0.3

func _process(delta: float) -> void:
	$XRotation.rotation.x = clamp($XRotation.rotation.x, -1.3, 1.3)
	scale = lerp(scale, Vector3.ONE * zoom, zoom_speed)
	velocity_y = clamp(velocity_y, -100.0, 100.0)
	velocity_x = clamp(velocity_x, -10.0, 10.0)
	if !grabbed:
		rotate_object_local(Vector3.UP, -1 * velocity_y * mouse_grab_sensitivity)
		if velocity_y > stop_threashold_y:
			velocity_y -= dampening_y
		elif velocity_y < -stop_threashold_y:
			velocity_y += dampening_y
		else:
			velocity_y = 0.0
		$XRotation.rotate_object_local(Vector3.RIGHT, -1 * velocity_x * mouse_grab_sensitivity)
		if velocity_x > stop_threashold_x:
			velocity_x -= dampening_x
		elif velocity_x < -stop_threashold_x:
			velocity_x += dampening_x
		else:
			velocity_x = 0.0
		$XRotation.rotation.x = clamp($XRotation.rotation.x, -1.3, 1.3)
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			grabbed = event.pressed
			if grabbed:
				velocity_x = 0.0
				velocity_y = 0.0
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom -= zoom_speed
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom += zoom_speed
	zoom = clamp(zoom, min_zoom, max_zoom)
	if event is InputEventMouseMotion and grabbed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		if event.relative.x != 0:
			var x_rotation = clamp(event.relative.x, -30, 30)
			if abs(event.relative.x - x_rotation) > 0:
				velocity_y = event.relative.x - x_rotation
			rotate_object_local(Vector3.UP, -1 * x_rotation * mouse_grab_sensitivity)
		if event.relative.y != 0:
			var y_rotation = clamp(event.relative.y, -10, 10)
			if abs(event.relative.y - y_rotation) > 0:
				velocity_x = event.relative.y - y_rotation
			$XRotation.rotate_object_local(Vector3.RIGHT, -1 * y_rotation * mouse_grab_sensitivity)
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func get_mouse_input(delta: float):
	return
