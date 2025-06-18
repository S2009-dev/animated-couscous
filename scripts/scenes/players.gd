extends Node2D

@export var player1_start_pos = Vector2.ZERO
@export var player2_start_pos = Vector2.ZERO

func _ready() -> void:
	$Player1.position = player1_start_pos
	$Player2.position = player2_start_pos
