extends SubViewportContainer

func _ready() -> void:
	$SubViewport.size = get_viewport().size
