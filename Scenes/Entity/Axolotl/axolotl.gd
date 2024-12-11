extends CharacterBody2D
class_name Axolotl

@export_range(0, 5) var wakeup_delay : int

@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _physics_process(delta: float) -> void:
	move_and_slide()
