extends Node2D

signal world_loaded

@export var player_object: PackedScene

func _ready() -> void:
	create_player(1, Vector2(-600, 270))
	create_player(2, Vector2(600, 270))
	emit_signal("world_loaded")

func create_player(id: int, start_pos: Vector2 = position) -> void:
	var player = player_object.instantiate()

	player.id = clampi(id, 1, 2)
	player.position = start_pos

	$Cameras/SubViewportContainer/Viewport1/Players.add_child(player)
