extends Node

signal add_score
signal game_paused

var axolotl_body_collection = {
	0 : preload("res://Assets/Axolotl/Spritesheets/Axolotl_Albino_Dash.png"),
	1 : preload("res://Assets/Axolotl/Spritesheets/Axolotl_Black_Dash.png"),
	2 : preload("res://Assets/Axolotl/Spritesheets/Axolotl_Blue_Dash.png"),
	3 : preload("res://Assets/Axolotl/Spritesheets/Axolotl_Brown_Dash.png"),
	4 : preload("res://Assets/Axolotl/Spritesheets/Axolotl_Deep_Sea_Dash.png"),
	5 : preload("res://Assets/Axolotl/Spritesheets/Axolotl_Pink_Dash.png"),
	6 : preload("res://Assets/Axolotl/Spritesheets/Axolotl_Purple_Dash.png"),
	7 : preload("res://Assets/Axolotl/Spritesheets/Axolotl_Red_Dash.png"),
}

var hat_collection = {
	0 : preload("res://Assets/Axolotl/Santa Hats/Isophene_Santa_Hat.png"),
	1 : preload("res://Assets/Axolotl/Santa Hats/Roscoe_Santa_Hat.png"),
	2 : preload("res://Assets/Axolotl/Santa Hats/Sylvis_Santa_Hat.png"),
}

# Called when the node enters the scene tree for the first time.
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("Quit"):
		game_paused.emit()
		get_tree().paused = true

func _pause_game() -> void:
	game_paused.emit()
	get_tree().paused = true

func unpause_game() -> void:
	get_tree().paused = false
