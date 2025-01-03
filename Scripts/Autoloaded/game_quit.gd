extends Node

signal add_score
signal game_paused


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
