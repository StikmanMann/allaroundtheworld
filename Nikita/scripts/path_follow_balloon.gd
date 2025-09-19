extends PathFollow3D

var pause_timer : Timer
var flying  = true

func _ready() -> void:
	pause_timer = Timer.new()
	pause_timer.wait_time = 10.0
	pause_timer.one_shot = true
	add_child(pause_timer)
	pause_timer.timeout.connect(_on_timer_timeout)

func _process(delta: float) -> void:
	if flying:
		progress += 5 * delta
		if progress_ratio <= 0.001:
			#progress_ratio == 1.0
			flying = false
			pause_timer.start()

func _on_timer_timeout():
	flying = true
	progress_ratio = 0.001001
