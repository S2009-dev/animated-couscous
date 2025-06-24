extends TileMapLayer

@export var item_object: PackedScene # Items scene
@export var speed: int = 8

@onready var paths: Path2D = %Path2D
@onready var items: Node2D = %Items

func _process(delta: float) -> void:
	for i in range(items.get_child_count()):
		var item = items.get_child(i)
		var path_follow = paths.get_child(i)

		path_follow.progress_ratio += delta * speed / 100
		item.position = path_follow.position

		if path_follow.progress_ratio >= 1:
			item.queue_free()
			path_follow.queue_free()


func _on_item_spawn_interval_timeout() -> void:
	var item = item_object.instantiate()
	var path_follow = PathFollow2D.new()
	var id = items.get_child_count() + 1
	
	item.name = "Item" + str(id)
	item.position = path_follow.position

	path_follow.name = "PathFollow" + str(id)
	path_follow.loop = false
	path_follow.add_to_group("items_path")

	items.add_child(item)
	paths.add_child(path_follow)
