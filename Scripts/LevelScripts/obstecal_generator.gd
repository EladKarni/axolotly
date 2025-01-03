extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer

@export var piller_scene : PackedScene
@export var piller_movement_speed : float = 1
var rng = RandomNumberGenerator.new()

func set_random_height_offset() -> int:
	rng.randomize()
	var rand_offset_code = rng.randi_range(0, 5) 
	match rand_offset_code:
		0:
			return 100
		1:
			return 50
		2:
			return 0
		3:
			return -50
		4:
			return -100
	return 0
		
func _ready() -> void:
	rng.randomize()
	spawn_timer.timeout.connect(_spawn_piller)
	spawn_timer.start()
	
func _spawn_piller() -> void:
	var piller = piller_scene.instantiate()
	piller.movement_speed = piller_movement_speed
	piller.position.y = set_random_height_offset()
	add_child(piller)
	spawn_timer.start()
