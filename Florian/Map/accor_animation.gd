extends AnimationPlayer

var already_played = false

func _ready():
	#_play_animation()
	pass

func _play_animation():
	if already_played:
		return
	already_played = true
	self.play("accordGoesOnStage")
