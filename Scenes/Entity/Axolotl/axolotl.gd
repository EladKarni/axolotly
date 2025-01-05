extends CharacterBody2D
class_name Axolotl

@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _physics_process(delta: float) -> void:
	move_and_slide()
