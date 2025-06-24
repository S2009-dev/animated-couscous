class_name Bin
extends Area2D

func _ready() -> void:
	var screen_size = get_viewport_rect().size
	position = screen_size / 2

func throw_item(item: Color) -> void:
	$ColorRect.modulate = item