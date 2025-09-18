extends RigidBody3D

@export var speed: float = 20.0
@export var curve_strength: float = 0.5
@export var lifetime: float = 3.0
@onready var particle_emitter: GPUParticles3D = $GPUParticles3D
@onready var explosion_points: PointPicture = $ExplosionPoints

var time_alive: float = 0.0
var initial_position: Vector3

func _ready() -> void:
	initial_position = global_position
	# Set the initial velocity to shoot upwards
	linear_velocity = Vector3(0, speed, 0)

func _process(delta: float) -> void:
	time_alive += delta
	if time_alive < lifetime:
		# Apply a slight curve to the trajectory
		var curve_offset = Vector3(curve_strength * sin(time_alive * 2.0), 0, curve_strength * cos(time_alive * 2.0))
		linear_velocity += curve_offset * delta
		# Update the position
		global_position += linear_velocity * delta
	else:
		explode()  # Call the explode function when the firework reaches its lifetime

func explode() -> void:
	explosion_points.show()
	if particle_emitter:
		particle_emitter.emitting = true  # Start emitting particles  # Mark as exploded
	# Start a timer to free the firework after the explosion duration
	await get_tree().create_timer(1).timeout
	queue_free()  # Remove the firework after expl
