extends Control

@onready var player1_item: ColorRect = %Player1Item
@onready var player2_item: ColorRect = %Player2Item
@onready var best_score_label: Label = %BestScore
@onready var score_label: Label = %Score
@onready var game_over: Control = %GameOver

var score: int = 0
var best_score: int = 0
var config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	var conf_load = config.load("user://scores.cfg")

	if conf_load == OK and config.has_section_key("scores", "best_score"):
		best_score = config.get_value("scores", "best_score")
		best_score_label.text = "BEST SCORE: " + str(best_score)

	config.set_value("scores", "best_score", best_score)
	config.save("user://best_score.cfg")

func _on_store_item(player_id: int, item: Color) -> void:
	if player_id == 1:
		player1_item.modulate = item
	elif player_id == 2:
		player2_item.modulate = item

func _on_update_score() -> void:
	score += 1
	score_label.text = "SCORE: " + str(score)

	if score > best_score:
		update_best_score()

func update_best_score() -> void:
	best_score = score
	best_score_label.text = "BEST SCORE: " + str(best_score)
	
	config.set_value("scores", "best_score", best_score)
	config.save("user://scores.cfg")