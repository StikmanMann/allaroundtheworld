extends Node

var picture_takables : Array[PointPicture] = []

func _add_point_picture(point_picture: PointPicture):
	print("Adding picture takeable")
	picture_takables.append(point_picture)
	print(len(picture_takables))
