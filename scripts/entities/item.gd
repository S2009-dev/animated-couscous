class_name Item
extends Area2D

@export_range(0, 2) var type: int = 0

func _ready() -> void:
	var colors = [Color(1, 0, 0, 1), Color(0, 1, 0, 1), Color(0, 0, 1, 1)]
	$ColorRect.modulate = colors[type]

func remove() -> void:
	var id = name.get_slice("_", 1)
	
	for path in get_tree().get_nodes_in_group("items_path"):
		if path.name.get_slice("_", 1) == id:
			path.queue_free()
			break
	
	queue_free()