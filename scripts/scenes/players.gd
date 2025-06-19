extends Node2D

@export var player_object: PackedScene

func _ready() -> void:
	create_player()
	create_player(2)

func create_player(id: int) -> void:
	var player = player_object.instantiate()

	player.id = id
	player.position = position

	add_child(player)
