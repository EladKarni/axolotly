extends State
class_name Swimming

@export var animatedSprite: AnimatedSprite2D
@export var swim_speed : int
@onready var character: Axolotl = $"../.."

@onready var label: RichTextLabel = $"../../RichTextLabel"
@onready var sleep_timer = Timer.new()

var move_direction: Vector2
var wonder_time: float
var next_decision_change : int
var idle_timer := 120

func randomize_swimming():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wonder_time = randf_range(3, 10)
	next_decision_change = randi_range(0, 2)


func Enter():
	add_child(sleep_timer)
	sleep_timer.wait_time = idle_timer
	sleep_timer.one_shot = true
	sleep_timer.start()
	animatedSprite.play("swimming")
	label.hide()
	randomize_swimming()

func Update(delta: float):
	if wonder_time > 0:
		wonder_time -= delta

	else:
		if next_decision_change == 0:
			randomize_swimming()
		elif next_decision_change == 1:
			animatedSprite.play_backwards("swim_prep")
			await animatedSprite.animation_finished
			Transitioned.emit(self, "Floating")
		else:
			if not sleep_timer.is_stopped():
				randomize_swimming()
			else:
				animatedSprite.play_backwards("swim_prep")
				await animatedSprite.animation_finished
				Transitioned.emit(self, "Idle Floating")

func Physics_Update(delta: float):
	if wonder_time <= 0:
		character.velocity = Vector2.ZERO
		return
	
	if move_direction.x > 0:
		animatedSprite.flip_h = true
	else:
		animatedSprite.flip_h = false
		
	if character:
		character.velocity = move_direction * swim_speed
