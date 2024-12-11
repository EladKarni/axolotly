extends State
class_name Floating

@export var idle_timer: int

@onready var axolotly_animated_sprite: AnimatedSprite2D = $"../../AxolotlyAnimatedSprite"
@onready var sleep_timer = Timer.new()

func Enter():
	axolotly_animated_sprite.play("floating")
	add_child(sleep_timer)
	sleep_timer.wait_time = idle_timer
	sleep_timer.one_shot = true
	sleep_timer.timeout.connect(on_sleep_timer_end)
	sleep_timer.start()

func on_sleep_timer_end():
	axolotly_animated_sprite.play("swim_prep")
	await axolotly_animated_sprite.animation_finished
	Transitioned.emit(self, "Swimming")
