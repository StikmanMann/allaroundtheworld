extends Node3D
@onready var label: Label = $Control/Label

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("take_picture"):
		print("Taking Picture!!!")
		var points_string = ""
		var total_points = 0
		for takeable in PictureTakeablesArray.picture_takables:
			print("Checking takeable")
			if takeable.picture_taken():
				points_string += "%s %d\n" % [str(takeable.point_id), int(takeable.points_worth)]
				total_points += takeable.points_worth
		label.text = "%s\nTotal points: %d" % [points_string, total_points]
