extends State
class_name Floating

@export var idle_timer := 1

@onready var axolotly_animated_sprite: AnimatedSprite2D = $"../../AxolotlyAnimatedSprite"
@onready var sleep_timer: Timer = $"../../Sleep_Timer"
@onready var santa_hat: Node2D = $"../../SantaHat"

func Enter():
	axolotly_animated_sprite.play("floating")
	sleep_timer.wait_time = idle_timer
	sleep_timer.one_shot = true
	sleep_timer.start()
	santa_hat.hide()

func _on_sleep_timer_timeout():
	axolotly_animated_sprite.play("swim_prep")
	await axolotly_animated_sprite.animation_finished
	Transitioned.emit(self, "Swimming")
