extends Node

signal update_score
signal update_errors

var music_player  = AudioStreamPlayer.new()
var sfx_player = AudioStreamPlayer.new()

func _ready():
	music_player.name = "Music"

	add_child(music_player)
	add_child(sfx_player)
	_main()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)

func _main() -> void:
	music_player.stop()

	music_player.stream = load("res://assets/musics/main_menu.mp3")
	music_player.stream.loop = true

	music_player.play()

func _start_game():
	music_player.stop()

	music_player.stream = load("res://assets/musics/game.mp3")
	music_player.stream.loop = true

	music_player.play()

func _click():
	sfx_player.stop()

	sfx_player.stream = load("res://assets/SFX/click.mp3")

	sfx_player.play()

func _update_score():
	update_score.emit()

func _update_errors():
	update_errors.emit()
