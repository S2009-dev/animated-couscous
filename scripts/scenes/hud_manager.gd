extends Control

@export var max_errors: int = 10

@onready var best_score_label: Label = %BestScore
@onready var score_label: Label = %Score
@onready var game_over: Control = %GameOver
@onready var errors_label: Label = %Errors

var score: int = 0
var best_score: int = 0
var errors: int = 0
var config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	var conf_load = config.load("user://scores.cfg")

	GameManager.connect("update_score", self._on_update_score)
	GameManager.connect("update_errors", self._on_update_errors)

	if conf_load == OK and config.has_section_key("scores", "best_score"):
		best_score = config.get_value("scores", "best_score")
		best_score_label.text = "BEST SCORE: " + str(best_score)

	config.set_value("scores", "best_score", best_score)
	config.save("user://best_score.cfg")

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

func _on_update_errors() -> void:
	errors += 1
	errors_label.text = "ERRORS: " + str(errors) + "/10"

	if errors >= max_errors:
		get_tree().paused = true
		game_over.show()


func _on_retry_btn_pressed() -> void:
	GameManager._click()
	GameManager._start_game()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://objects/scenes/world.tscn")


func _on_quit_btn_pressed() -> void:
	GameManager._click()
	GameManager._main()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://objects/menus/main_menu.tscn")
