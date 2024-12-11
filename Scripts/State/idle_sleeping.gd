extends State
class_name Idle_Sleeping

@export var sleep_strength : int

@onready var character: CharacterBody2D = $"../.."
@onready var axolotly_animated_sprite: AnimatedSprite2D = $"../../AxolotlyAnimatedSprite"
@onready var sleep_timer = Timer.new()

var current_nudge_attempt: int

func Enter():
	current_nudge_attempt = 0
	axolotly_animated_sprite.play("idle_resting")

func Update(delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		current_nudge_attempt += 1
		
	
	if current_nudge_attempt == sleep_strength:
		add_child(sleep_timer)
		sleep_timer.wait_time = character.wakeup_delay
		sleep_timer.one_shot = true
		sleep_timer.start()
		await sleep_timer.timeout
		axolotly_animated_sprite.play("getting_up")
		await axolotly_animated_sprite.animation_finished
		
		Transitioned.emit(self, "Floating")
