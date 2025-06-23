extends Control

var current_menu: String = "main"
var config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	var conf_load = config.load("user://options.cfg")
	var volume = 50

	if conf_load == OK and config.has_section_key("settings", "volume"):
		volume = config.get_value("settings", "volume")
	
	AudioServer.set_bus_volume_db(0, linear_to_db(volume / 100))
	$OptionsContainer/Volume/Slider.value = volume

	save_options()

func _on_options_btn_pressed() -> void:
	current_menu = "options"

	$Title.text = "OPTIONS"
	$MainContainer.hide()
	$OptionsContainer.show()
	$BackBtn.show()

func _on_credits_btn_pressed() -> void:
	current_menu = "credits"

	$Title.text = "CREDITS"
	$MainContainer.hide()
	$BackBtn.show()

func _on_back_btn_pressed() -> void:
	if current_menu == "options":
		$OptionsContainer.hide()
	elif current_menu == "credits":
		pass

	current_menu = "main"

	$Title.text = "ANIMATED-COUSCOUS"
	$MainContainer.show()
	$BackBtn.hide()

func _on_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		AudioServer.set_bus_volume_db(0, linear_to_db($OptionsContainer/Volume/Slider.value / 100))
		save_options()

func _on_slider_value_changed(value: float) -> void:
	$OptionsContainer/Volume/Label.text = "VOLUME: " + str(roundi(value)) + "%"

func save_options() -> void:
	var volume = $OptionsContainer/Volume/Slider.value
	
	config.set_value("settings", "volume", volume)
	config.save("user://options.cfg")
