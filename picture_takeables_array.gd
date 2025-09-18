extends Node

var picture_takables : Array[PointPicture] = []
var picture_spots: Array[PictureSpot] = []
var points = 1

signal calcualtion_finished

func _add_point_picture(point_picture: PointPicture):
	print("Adding picture takeable")
	picture_takables.append(point_picture)
	print(len(picture_takables))
	

 
func _add_picture_spot(picture_spot: PictureSpot):
	print("Adding picture Spot")
	picture_spots.append(picture_spot)
