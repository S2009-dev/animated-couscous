extends Node

signal click
signal start_game
signal update_score
signal update_errors
signal store_item(player_id: int, item: Color)

var music_player  = AudioStreamPlayer.new()
var sfx_player = AudioStreamPlayer.new()

func _ready():
	add_child(music_player)
	add_child(sfx_player)

	music_player.name = "Music"
	music_player.stream = load("res://assets/musics/main_menu.mp3")
	music_player.stream.loop = true

	music_player.play()

func _on_start_game():
	music_player.stop()

	music_player.stream = load("res://assets/musics/game.mp3")
	music_player.stream.loop = true

	music_player.play()

func _on_click():
	sfx_player.stop()

	sfx_player.stream = load("res://assets/SFX/click.mp3")

	sfx_player.play()
