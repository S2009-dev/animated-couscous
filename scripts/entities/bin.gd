class_name Bin
extends Area2D

@export_range(0, 2) var type: int = 0

func _ready() -> void:
	var colors = [Color(1, 0, 0, 1), Color(0, 1, 0, 1), Color(0, 0, 1, 1)]
	$ColorRect.modulate = colors[type]

func throw_item(item: Color) -> void:
	if item == $ColorRect.modulate:
		get_node("/root/World").emit_signal("update_score")
	else:
		get_node("/root/World").emit_signal("update_errors")