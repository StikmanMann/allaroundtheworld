class_name NPCPathFollower
extends PathFollow3D

@export var speed = 3
@export var path : Path3D = null

func _ready():
	if path == null:
		path = get_parent()
	
func _process(delta: float):
		# Move along the path
		self.progress += speed * delta

		# Loop the path if we reach the end
		if self.progress >= path.curve.get_baked_length():
			self.progress = 0
