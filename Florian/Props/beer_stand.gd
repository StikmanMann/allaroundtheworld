extends Node3D

@onready var sub_viewport: SubViewport = $CSGCombiner3D/SubViewport
@onready var interactable: Interactable = $CSGCombiner3D/Interactable
@onready var beer_spawner: Node3D = $CSGCombiner3D/BeerSpawner
@onready var timer: Timer = $Timer

@export var beer_cooldown = 3
var can_spawn = true

const PHYSICS_BEER = preload("res://Florian/PhysicsProps/physics_beer.tscn")
func _ready() -> void:
	interactable.interact.connect(_spawn_beer)
	timer.timeout.connect(_can_spawn_beer_true)
	

func _spawn_beer() -> void:
	if not can_spawn:
		return
	var beer = PHYSICS_BEER.instantiate()
	beer_spawner.add_child(beer)
	can_spawn=false
	timer.start(3)
	timer.paused = false
	pass

func _can_spawn_beer_true():
	
	can_spawn = true
