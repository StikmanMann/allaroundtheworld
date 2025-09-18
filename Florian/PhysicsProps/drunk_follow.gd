extends RigidBody3D

@export var item_want : RigidBody3D = null
@export var speed : int = 10
@onready var see_area: Area3D = $SeeArea

var following_item : RigidBody3D = null


func _ready() -> void:
	see_area.body_entered.connect(check_for_item_want)
	see_area.body_exited.connect(check_for_item_want)
	assert(item_want)

func _process(delta: float) -> void:
	_follow_item_want()

func check_for_item_want(obj):
	print("Checking for item")
	var bodies = see_area.get_overlapping_bodies()
	for body in bodies:
		if body == item_want:
			following_item = body
			return
	following_item = null  # Reset if no valid item is found


func _follow_item_want():
	
	if not following_item:
		return
	print("Checking for item")
	var wish_dir = (following_item.global_position - self.global_position).normalized()
	var velocity = wish_dir * speed
	self.linear_velocity = velocity 
