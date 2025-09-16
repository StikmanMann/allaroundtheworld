extends Node3D

@export var day_length_minutes: float = 1.0  # 1-minute full day cycle
@export var min_light_energy := 0.1
@export var max_light_energy := 1.0
@export var sun: DirectionalLight3D
@export var environment: WorldEnvironment

var time_of_day := 0.0  # 0 to 1, where 0 is midnight, 0.5 is noon, 1 is midnight again

func _process(delta: float) -> void:
	if day_length_minutes <= 0:
		return

	var day_speed = 1.0 / (day_length_minutes * 60.0)
	time_of_day = fmod(time_of_day + delta * day_speed, 1.0)

	
	#_update_sun_rotation()
	#_update_light_intensity()
	#_update_sky_color()
	
func _update_sun_rotation():
	var angle = time_of_day * 360.0
	rotation_degrees.x = angle - 90.0  # Rotate around X to simulate rising and setting

func _update_light_intensity():
	# Use cosine to simulate brightness change
	var sun_height = clamp(sin(time_of_day * PI * 2.0), 0.0, 1.0)
	var intensity = lerp(min_light_energy, max_light_energy, sun_height)
	sun.light_energy = intensity

func _update_sky_color():
	var sky_mat = environment.environment.sky.sky_material as ProceduralSkyMaterial
	if sky_mat:
		var horizon_day = Color(0.4, 0.7, 1.0)
		var horizon_night = Color(0.02, 0.02, 0.1)
		
		var blend = clamp(sin(time_of_day * PI * 2.0), 0.0, 1.0)
		sky_mat.sky_horizon_color = horizon_night.lerp(horizon_day, blend)
		sky_mat.sky_top_color = horizon_night.lerp(horizon_day, blend)
