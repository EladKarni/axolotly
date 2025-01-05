class_name Axolotl_Spawner
extends Node2D

const BASE_AXOLOTL : PackedScene = preload("res://Scenes/Entity/Axolotl/axolotl.tscn")

func _ready() -> void:
	var saved_axolotls = GlobalGameObject.saved_axolotls_data
	for axolotl_res_path in saved_axolotls:
		var axolotl_data = load(axolotl_res_path)
		var animation_player = axolotl_data.body
		var animation_player_scene = animation_player.instantiate()
		
		var axolotl : Axolotl = BASE_AXOLOTL.instantiate()
		axolotl.add_child(animation_player_scene)
		
		add_child(axolotl)
