extends Area2D

# Debugging
func _ready() -> void:
	$ColorRect.modulate = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1)
