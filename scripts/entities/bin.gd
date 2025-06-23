extends Area2D

func _ready() -> void:
	var screen_size = get_viewport_rect().size
	position = screen_size / 2
