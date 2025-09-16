class_name PictureSpot
extends Area3D

@export var points_multiplier := 1
@export var points_worth := 10
@export var points_name := "Debug Points Area"

func _ready() -> void:
	PictureTakeablesArray._add_picture_spot(self)
	
func picture_taken(player: PlayerRB) -> bool:
	var bodies = get_overlapping_bodies()
	if player in bodies:
		return true
	return false
