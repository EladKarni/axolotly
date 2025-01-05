extends State
class_name Swimming

@onready var axolotly_animated_sprite: AnimatedSprite2D = $"../../AxolotlyAnimatedSprite"
@onready var character: Axolotl = $"../.."
@onready var santa_hat: Node2D = $"../../SantaHat"
@onready var label: RichTextLabel = $"../../RichTextLabel"
@onready var sleep_timer: Timer = $"../../Sleep_Timer"

var swim_speed := 10
var move_direction: Vector2
var wonder_time: float
var next_decision_change : int
var idle_timer := 120

func randomize_swimming():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wonder_time = randf_range(3, 10)
	next_decision_change = randi_range(0, 2)


func Enter():
	santa_hat.show()
	randomize_swimming()
	label.hide()
	axolotly_animated_sprite.play("swimming")
	sleep_timer.wait_time = idle_timer
	sleep_timer.one_shot = true
	sleep_timer.start()

func Update(delta: float):
	if wonder_time > 0:
		wonder_time -= delta

	else:
		if next_decision_change == 0:
			randomize_swimming()
		elif next_decision_change == 1:
			santa_hat.hide()
			axolotly_animated_sprite.play_backwards("swim_prep")
			await axolotly_animated_sprite.animation_finished
			Transitioned.emit(self, "Floating")
		else:
			if not sleep_timer.is_stopped():
				randomize_swimming()
			else:
				axolotly_animated_sprite.play_backwards("swim_prep")
				await axolotly_animated_sprite.animation_finished
				Transitioned.emit(self, "Idle Floating")

func Physics_Update(delta: float):
	if wonder_time <= 0:
		character.velocity = Vector2.ZERO
		return
	
	if move_direction.x > 0:
		axolotly_animated_sprite.flip_h = true
		santa_hat.scale.x =  -1
	else:
		axolotly_animated_sprite.flip_h = false
		santa_hat.scale.x = 1
		
	if character:
		character.velocity = move_direction * swim_speed
