extends Node

signal update_score
signal update_errors
signal store_item(player_id: int, item: Color)

var music_player  = AudioStreamPlayer.new()
var sfx_player = AudioStreamPlayer.new()

func _ready():
	music_player.name = "Music"

	add_child(music_player)
	add_child(sfx_player)
	_main()

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

func _store_item(player_id: int, item: Color):
	store_item.emit(player_id, item)
