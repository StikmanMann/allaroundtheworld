extends Node3D

var to_earth
var toggle_popup : bool = false

func _ready() -> void:
	get_node("Popup").visible = toggle_popup
	var cam = get_viewport().get_camera_3d()
	to_earth = (get_parent().global_position - global_position).normalized()
	look_at(cam.global_position, Vector3.UP)

func _process(delta):
	var cam = get_viewport().get_camera_3d()
	var to_camera = (cam.global_position - global_position).normalized()
	var cos_similarity = to_camera.dot(to_earth)
	#print(cos_similarity)
	if abs(cos_similarity) < 0.75:
		# Construct desired basis (local -Z facing camera)
		var z_axis = -to_camera
		var up_axis = Vector3.UP
		var x_axis = up_axis.cross(z_axis).normalized()
		var y_axis = z_axis.cross(x_axis).normalized()
		var desired_basis = Basis(x_axis, y_axis, z_axis)
		# Extract current rotation (normalized) and scale
		var current_basis = global_transform.basis
		var current_scale = current_basis.get_scale()
		var current_q = Quaternion(current_basis.orthonormalized())
		var target_q = Quaternion(desired_basis.orthonormalized())
		# Interpolate smoothly
		var speed = 10.0
		var new_q = current_q.slerp(target_q, speed * delta)
		# Rebuild basis: pure rotation, then reapply scale
		var new_basis = Basis(new_q)
		new_basis = new_basis.scaled(current_scale)
		global_transform.basis = new_basis
	else:
		# Build basis: local -Z faces the camera, Y stays up
		to_camera.y = 0
		var z_axis = -to_camera
		var y_axis = Vector3.UP
		var x_axis = y_axis.cross(z_axis).normalized()
		y_axis = z_axis.cross(x_axis).normalized()
		var desired_basis = Basis(x_axis, y_axis, z_axis)
		# Extract current rotation (normalized) and scale
		var current_basis = global_transform.basis
		var current_scale = current_basis.get_scale()
		var current_q = Quaternion(current_basis.orthonormalized())
		var target_q = Quaternion(desired_basis.orthonormalized())
		# Interpolate smoothly
		var speed = 20.0
		var new_q = current_q.slerp(target_q, speed * delta)
		# Rebuild basis: pure rotation, then reapply scale
		var new_basis = Basis(new_q)
		new_basis = new_basis.scaled(current_scale)
		global_transform.basis = new_basis

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
		toggle_popup = !toggle_popup
		get_node("Popup").visible = toggle_popup
