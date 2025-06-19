extends Node2D

@export var player_object: PackedScene

func _ready() -> void:
	create_player(1, Vector2(100, 100))
	create_player(2, Vector2(200, 200))

func create_player(id: int, start_pos: Vector2 = position) -> void:
	var player = player_object.instantiate()

	player.id = clampi(id, 1, 2)
	player.position = start_pos

	add_child(player)
