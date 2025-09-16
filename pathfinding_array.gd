extends Node

@export var path_3d_array : Array[Path3D] = []

func add_path(path: Path3D):
	path_3d_array.append(path)
