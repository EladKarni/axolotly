extends Node2D

@onready var hat_sprite: Sprite2D = $HatSprite
@onready var previous_btn: Button = $"../../Panel/VBoxContainer/HatSelector/HBoxContainer/PreviousBtn"
@onready var next_btn: Button = $"../../Panel/VBoxContainer/HatSelector/HBoxContainer/NextBtn"

var hat_keys = []
var current_hat_index := 0

func _ready() -> void:
	set_sprite_keys()
	update_sprite()
	next_btn.pressed.connect(_get_next_hat_sprite)
	previous_btn.pressed.connect(_get_previous_hat_sprite)

func set_sprite_keys() -> void:
	hat_keys = CustomizationOptions.hat_collection.keys()

func update_sprite() -> void:
	hat_sprite.texture = CustomizationOptions.hat_collection[current_hat_index]

func _get_next_hat_sprite() -> void:
	current_hat_index += 1
	if current_hat_index > hat_keys.size() - 1:
		current_hat_index = 0
	update_sprite()

func _get_previous_hat_sprite() -> void:
	current_hat_index -= 1
	if current_hat_index < 0:
		current_hat_index = hat_keys.size() - 1
	update_sprite()
