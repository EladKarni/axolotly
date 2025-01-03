extends Control

@onready var restart_btn: Button = $CenterContainer/MarginContainer/VBoxContainer/RestartBtn
@onready var back_to_tank_btn: Button = $CenterContainer/MarginContainer/VBoxContainer/BackToTankBtn
@onready var quit_btn: Button = $CenterContainer/MarginContainer/VBoxContainer/QuitBtn
@onready var resume_btn: Button = $CenterContainer/MarginContainer/VBoxContainer/ResumeBtn

@export var target_scene : String
@export var target_text : String
@export var is_resume_enabled := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalGameObject.game_paused.connect(_game_paused)
	
	back_to_tank_btn.text = target_text
	
	if not is_resume_enabled:
		resume_btn.hide()
	else:
		restart_btn.hide()
		resume_btn.pressed.connect(_resume_game)
	
	restart_btn.pressed.connect(_restart_game)
	back_to_tank_btn.pressed.connect(_return_to_tank)
	quit_btn.pressed.connect(_quit_game)

func _resume_game() -> void:
	hide()
	GlobalGameObject.unpause_game()

func _game_paused() -> void:
	show()

func _restart_game() -> void:
	GlobalGameObject.unpause_game()
	get_tree().reload_current_scene()

func _return_to_tank() -> void:
	GlobalGameObject.unpause_game()
	get_tree().change_scene_to_file(target_scene)

func _quit_game() -> void:
	get_tree().quit()
