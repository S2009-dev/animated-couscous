extends Control

var current_menu: String = "main"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_options_btn_pressed() -> void:
	current_menu = "options"

	$Title.text = "OPTIONS"
	$MainContainer.hide()
	$BackBtn.show()


func _on_credits_btn_pressed() -> void:
	current_menu = "credits"

	$Title.text = "CREDITS"
	$MainContainer.hide()
	$BackBtn.show()


func _on_back_btn_pressed() -> void:
	$Title.text = "ANIMATED-COUSCOUS"
	$MainContainer.show()
	$BackBtn.hide()
