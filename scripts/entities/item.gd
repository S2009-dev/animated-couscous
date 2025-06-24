class_name Item
extends Area2D

# Debugging
func _ready() -> void:
	$ColorRect.modulate = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1)

func remove() -> void:
	var id = name.get_slice("_", 1)
	
	for path in get_tree().get_nodes_in_group("items_path"):
		if path.name.get_slice("_", 1) == id:
			path.queue_free()
			break
	
	queue_free()