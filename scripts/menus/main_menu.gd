extends Control

@onready var title: Label = %Title
@onready var main_container: Control  = %MainContainer
@onready var options_container: Control = %OptionsContainer
@onready var volume_label: Label = %Label
@onready var volume_slider: HSlider = %Slider
@onready var credits_container: Control = %CreditsContainer
@onready var back_button: Button = %BackBtn

var current_menu: String = "main"
var config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	var conf_load = config.load("user://options.cfg")
	var volume = 50

	if conf_load == OK and config.has_section_key("settings", "volume"):
		volume = config.get_value("settings", "volume")
	
	AudioServer.set_bus_volume_db(0, linear_to_db(volume / 100))
	volume_slider.value = volume

	save_options()

func _on_options_btn_pressed() -> void:
	current_menu = "options"

	title.text = "OPTIONS"
	main_container.hide()
	options_container.show()
	back_button.show()

func _on_credits_btn_pressed() -> void:
	current_menu = "credits"

	title.text = "CREDITS"
	main_container.hide()
	credits_container.show()
	back_button.show()

func _on_back_btn_pressed() -> void:
	if current_menu == "options":
		options_container.hide()
	elif current_menu == "credits":
		credits_container.hide()

	current_menu = "main"

	title.text = "ANIMATED-COUSCOUS"
	main_container.show()
	back_button.hide()

func _on_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		AudioServer.set_bus_volume_db(0, linear_to_db(volume_slider.value / 100))
		save_options()

func _on_slider_value_changed(value: float) -> void:
	volume_label.text = "VOLUME: " + str(roundi(value)) + "%"

func save_options() -> void:
	var volume = volume_slider.value
	
	config.set_value("settings", "volume", volume)
	config.save("user://options.cfg")
