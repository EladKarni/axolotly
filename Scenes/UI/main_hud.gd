extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var score := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalGameObject.add_score.connect(update_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_score() -> void:
	score += 1
	score_label.text = "Score: %s" % score
