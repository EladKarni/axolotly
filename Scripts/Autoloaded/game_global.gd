extends Node

signal add_score
signal game_paused

var saved_axolotls_data : Array = []

func _ready() -> void:
	var dir = DirAccess.open("res://Saves/Axolotls/")
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while true:
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		else:
			saved_axolotls_data.append(file_name)

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
