extends CharacterBody2D

@onready var jump_timer: Timer = $JumpTimer

@export var JUMP_VELOCITY := -7.0
@export var SPEED := 300.0
@export var jump_cooldown := 0.2

var collision_data : KinematicCollision2D
var can_jump := true

func _ready() -> void:
	jump_timer.wait_time = jump_cooldown
	jump_timer.timeout.connect(_reset_jump)
	
	

func _physics_process(delta: float) -> void:
	velocity.y += 0.4  
	
	if Input.is_action_just_pressed("Dash") && can_jump:
		velocity.y = JUMP_VELOCITY
		can_jump = false
		jump_timer.start()

	collision_data = move_and_collide(velocity)
	if collision_data && collision_data.get_collider().name == "Piller":
		GlobalGameObject._pause_game()

func _reset_jump() -> void:
	can_jump = true
