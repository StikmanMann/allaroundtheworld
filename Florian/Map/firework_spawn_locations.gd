extends Node3D

const FIREWORK = preload("res://Florian/PhysicsProps/firework.tscn")

func _spawn_fireworks():
	for child in self.get_children():
		var firework = FIREWORK.instantiate()
		child.add_child(firework)
