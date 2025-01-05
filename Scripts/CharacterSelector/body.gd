extends Node2D

@onready var axolotl_name: Label = $"../../Panel/VBoxContainer/VBoxContainer2/CenterContainer/AxolotlName"
@onready var previous_btn: Button = $"../../Panel/VBoxContainer/VBoxContainer2/ColorSelector/HBoxContainer/PreviousBtn"
@onready var next_btn: Button = $"../../Panel/VBoxContainer/VBoxContainer2/ColorSelector/HBoxContainer/NextBtn"

@onready var cancel_btn: Button = $"../../Panel/VBoxContainer/VBoxContainer2/HBoxContainer/CancelBtn"
@onready var select_btn: Button = $"../../Panel/VBoxContainer/VBoxContainer2/HBoxContainer/SelectBtn"

const BASE_AXOLOTL : PackedScene = preload("res://Scenes/Entity/Axolotl/axolotl.tscn")

var axolotl_list := []
var currently_selected_index := 0

func _load_axolotl_options() -> void:
	var saved_axolotls = GlobalGameObject.saved_axolotls_data
	for axolotl_res_path in saved_axolotls:
		var axolotl_data = load(axolotl_res_path)
		var animation_player = axolotl_data.body
		var animation_player_scene = animation_player.instantiate()
		axolotl_list.append({
			"animation": animation_player_scene,
			"name": axolotl_data.name
		})


func _ready() -> void:
	_load_axolotl_options()
	set_sprite_keys()
	axolotl_name.text = axolotl_list[currently_selected_index].name

	next_btn.pressed.connect(_get_next_axolotl_sprite)
	previous_btn.pressed.connect(_get_previous_axolotl_sprite)
	cancel_btn.pressed.connect(_cancel_btn_action)
	select_btn.pressed.connect(_select_btn_action)

func _cancel_btn_action() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/tank.tscn")

func _select_btn_action() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/endless_running_world.tscn")

func set_sprite_keys() -> void:
	add_child(axolotl_list[currently_selected_index].animation)
	GlobalGameObject.selected_axolotl_index = currently_selected_index

func update_sprite(past_index: int) -> void:
	axolotl_name.text = axolotl_list[currently_selected_index].name
	remove_child(axolotl_list[past_index].animation)
	add_child(axolotl_list[currently_selected_index].animation)
	GlobalGameObject.selected_axolotl_index = currently_selected_index

func _get_next_axolotl_sprite() -> void:
	var past_index = currently_selected_index
	currently_selected_index += 1
	if currently_selected_index > axolotl_list.size() - 1:
		currently_selected_index = 0
	update_sprite(past_index)

func _get_previous_axolotl_sprite() -> void:
	var past_index = currently_selected_index
	currently_selected_index -= 1
	if currently_selected_index < 0:
		currently_selected_index = axolotl_list.size() - 1
	update_sprite(past_index)
