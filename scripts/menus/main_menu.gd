extends Control

var config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	var conf_load = config.load("user://options.cfg")
	var volume = 50

	if conf_load == OK and config.has_section_key("settings", "volume"):
		volume = config.get_value("settings", "volume")
	
	AudioServer.set_bus_volume_db(0, linear_to_db(volume / 100))

	config.set_value("settings", "volume", volume)
	config.save("user://options.cfg")

func _on_start_btn_pressed() -> void:
	GameManager.emit_signal("click")
	GameManager.emit_signal("start_game")
	get_tree().change_scene_to_file("res://objects/scenes/world.tscn")

func _on_options_btn_pressed() -> void:
	GameManager.emit_signal("click")
	get_tree().change_scene_to_file("res://objects/menus/options_menu.tscn")

func _on_credits_btn_pressed() -> void:
	GameManager.emit_signal("click")
	get_tree().change_scene_to_file("res://objects/menus/credits_menu.tscn")
