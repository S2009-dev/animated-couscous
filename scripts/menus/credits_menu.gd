extends Control

func _on_back_btn_pressed() -> void:
	GameManager.emit_signal("click")
	get_tree().change_scene_to_file("res://objects/menus/main_menu.tscn")
