extends Node

signal hour_signal
signal fifteen_minutes_signal
signal thirty_minutes_signal

var hour: int = 0
var minute: int = 0

@export var minutes_per_real_second: float = 1.0  # 1 in-game minute per second

var _accumulated_time := 0.0

func _process(delta: float) -> void:
	_accumulated_time += delta * minutes_per_real_second
	while _accumulated_time >= 1.0:
		_accumulated_time -= 1.0
		_add_minute()

func _add_minute():
	minute += 1
	if minute >= 60:
		hour_signal.emit()
		minute = 0
		hour += 1
		if hour >= 24:
			hour = 0
