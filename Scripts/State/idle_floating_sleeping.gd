extends State
class_name Idle_Floating_Sleeping

@export var idle_timer: int

@onready var axolotly_animated_sprite: AnimatedSprite2D = $"../../AxolotlyAnimatedSprite"
@onready var sleep_timer: Timer = $"../../Sleep_Timer"

func Enter():
	axolotly_animated_sprite.play("idle_floating")
	sleep_timer.wait_time = idle_timer
	sleep_timer.one_shot = true
	sleep_timer.timeout.connect(on_sleep_timer_end)
	sleep_timer.start()

func on_sleep_timer_end():
	await axolotly_animated_sprite.animation_finished
	axolotly_animated_sprite.play_backwards("getting_up")
	await axolotly_animated_sprite.animation_finished
	Transitioned.emit(self, "Sleeping")
