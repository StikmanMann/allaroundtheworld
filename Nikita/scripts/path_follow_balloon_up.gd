extends PathFollow3D

func _process(delta: float) -> void:
	progress += 2 * delta
