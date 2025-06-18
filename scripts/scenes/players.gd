extends Node2D

@export var player_object: PackedScene

func _ready() -> void:
	create_player()
	create_player(2)

func create_player(id: int = 1) -> void:
	var player = player_object.instantiate()

	player.id = id
	player.position = Vector2(100, 100) if id == 1 else Vector2(700, 100)

	add_child(player)
