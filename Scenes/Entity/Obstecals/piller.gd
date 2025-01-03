extends StaticBody2D
class_name Piller

var movement_speed : float = 1.00

func _process(delta: float) -> void:
	if position.x > 2000:
		queue_free()
	position.x += movement_speed


func _on_score_area_body_exited(body: Node2D) -> void:
	GlobalGameObject.add_score.emit()
