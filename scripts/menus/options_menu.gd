extends Control

signal click

@onready var volume_container: Control = %Volume

var config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	config.load("user://options.cfg")
	volume_container.get_node("Slider").value = config.get_value("settings", "volume")

func _on_back_btn_pressed() -> void:
	click.emit()
	get_tree().change_scene_to_file("res://objects/menus/main_menu.tscn")

func _on_slider_drag_ended(value_changed: bool) -> void:
	click.emit()
	
	if value_changed:
		AudioServer.set_bus_volume_db(0, linear_to_db(volume_container.get_node("Slider").value / 100))
		save_options()

func _on_slider_value_changed(value: float) -> void:
	volume_container.get_node("Label").text = "VOLUME: " + str(roundi(value)) + "%"

func save_options() -> void:
	var volume = volume_container.get_node("Slider").value
	
	config.set_value("settings", "volume", volume)
	config.save("user://options.cfg")
