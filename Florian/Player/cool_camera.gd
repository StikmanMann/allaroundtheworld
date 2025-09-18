extends Node3D
#@onready var label: Label = $Control/Label
@export var player : PlayerRB = null


@onready var flash_camera: AudioStreamPlayer = $"Flash-camera"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("take_picture"):
		_take_picture()

func _take_picture():
	flash_camera.play()

	_calculate_points()
	await get_tree().create_timer(0.1).timeout
	PictureTakeablesArray.calcualtion_finished.emit()
	pass

var points_string = ""
var total_points = 0
var total_points_multipliers = 1

func _calculate_points():
	points_string = ""
	total_points = 0
	total_points_multipliers = 1
	print("Taking Picture!!!")
	_calculate_picture_objects()
	_calculate_picture_spots()
	PictureTakeablesArray.points = total_points
	#label.text = "%s\nTotal points: %d x %.2f = %.2f" % [points_string, total_points, total_points_multipliers, total_points * total_points_multipliers]

var acceptable_length = 1

func _calculate_picture_objects():
	var duplicates: Dictionary = {}
	for takeable in PictureTakeablesArray.picture_takables:
		if not takeable:
			continue
		#print("Checking takeable")
		if takeable.picture_taken():
			var raycast = RayCast3D.new()
			raycast.top_level = true
			add_child(raycast)
			raycast.global_position = get_viewport().get_camera_3d().global_position
			
			raycast.target_position = takeable.global_position - self.global_position
			raycast.force_raycast_update()
			raycast.collide_with_bodies = true
			raycast.debug_shape_thickness = 2
			if raycast.is_colliding():
				#print("raycast hit")
				var raycast_hit = raycast.get_collision_point()
				#print(str((raycast_hit - takeable.global_position).length()))
				if (raycast_hit - takeable.global_position).length() > acceptable_length:
					#print("Not in range!")
					raycast.queue_free()
					continue
			raycast.queue_free()
			
			var points = takeable.points_worth
			var label = Label3D.new()
			label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
			label.fixed_size = true
			label.font_size = 100
			label.pixel_size = 0.001
			
			if duplicates.get(takeable.points_name):
				points = int(points * 0.2)
				#points_string += "Duplicate: {name} {points}\n".format(
				#	{"name" : takeable.points_name, "points": points}
				#	)
			else:
				duplicates[takeable.points_name] = true
				label.font_size = 150
				label.modulate = "#ffff00"
				#points_string += "{name} {points}\n".format(
				#	{"name" : takeable.points_name, "points": points}
				#	)
			if takeable.points_multiplier != 1:
				label.text = "{points} + X{mult}".format(
					{"points": points, "mult":takeable.points_multiplier}
				)
			else:
				label.text = "{points}".format(
					{"points": points}
				)
			takeable.add_child(label)
			label.position += Vector3(0, 1, 0)
			total_points += points
			total_points_multipliers *= takeable.points_multiplier
			takeable.show_red_cicle()

func _calculate_picture_spots():
	for spot in PictureTakeablesArray.picture_spots:
		if not spot:
			return
		if spot.picture_taken(player):
			points_string += "{name} {points}\n".format(
				{"name" : spot.points_name, "points": spot.points_worth}
				)
			total_points += spot.points_worth
			total_points_multipliers *= spot.points_multiplier
