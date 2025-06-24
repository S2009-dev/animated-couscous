extends Control

signal click

func _on_back_btn_pressed() -> void:
	click.emit()
	get_tree().change_scene_to_file("res://objects/menus/main_menu.tscn")
