extends Sprite3D
@onready var asian_gong: AudioStreamPlayer3D = $"Asian-gong"

func _play_gong_sound():
	asian_gong.play()
