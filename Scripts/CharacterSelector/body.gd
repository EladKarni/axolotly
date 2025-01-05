extends Node2D


@onready var body_sprite: Sprite2D = $BodySprite
@onready var previous_btn: Button = $"../../Panel/VBoxContainer/ColorSelector/HBoxContainer/PreviousBtn"
@onready var next_btn: Button = $"../../Panel/VBoxContainer/ColorSelector/HBoxContainer/NextBtn"

var body_keys = []
var current_body_index := 0

func _ready() -> void:
	set_sprite_keys()
	update_sprite()
	next_btn.pressed.connect(_get_next_body_sprite)
	previous_btn.pressed.connect(_get_previous_body_sprite)

func set_sprite_keys() -> void:
	body_keys = CustomizationOptions.body_collection.keys()

func update_sprite() -> void:
	body_sprite.texture = CustomizationOptions.body_collection[current_body_index]

func _get_next_body_sprite() -> void:
	current_body_index += 1
	if current_body_index > body_keys.size() - 1:
		current_body_index = 0
	update_sprite()

func _get_previous_body_sprite() -> void:
	current_body_index -= 1
	if current_body_index < 0:
		current_body_index = body_keys.size() - 1
	update_sprite()
