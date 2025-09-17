class_name PointPicture
extends Node3D

@onready var red_circle: Sprite3D = $RedCircle
@onready var on_screen: VisibleOnScreenNotifier3D = $VisibleOnScreenNotifier3D
@export var points_worth : int= 10
@export var points_name = "Debug Object"
@export var points_multiplier : float = 1

func _ready() -> void:
	PictureTakeablesArray._add_point_picture(self)

func picture_taken() -> bool:
	var in_picture = on_screen.is_on_screen()
	hide_red_circle()
	#print(in_picture)

	return in_picture
	
func show_red_cicle():
	#print("Showing red circle")
	red_circle.show()

func hide_red_circle():
	#print("Hiding red circle")
	red_circle.hide()
