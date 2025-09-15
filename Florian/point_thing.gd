class_name PointPicture
extends Node3D
@onready var on_screen: VisibleOnScreenNotifier3D = $VisibleOnScreenNotifier3D
@export var points_worth = 10
@export var point_id = "Debug Object"

func _ready() -> void:
	PictureTakeablesArray._add_point_picture(self)

func picture_taken() -> bool:
	print(on_screen.is_on_screen())
	return on_screen.is_on_screen()
