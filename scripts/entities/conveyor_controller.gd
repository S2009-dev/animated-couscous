extends TileMapLayer

@export var item_object: PackedScene # Items scene
@export var speed: int = 8

@onready var paths: Path2D = %Path2D
@onready var items: Node2D = %Items

func _process(delta: float) -> void:
	for item in items.get_children():
		var id = item.name.get_slice("_", 1)
		var path_follow = paths.get_node("PathFollow_" + str(id))

		path_follow.progress_ratio += delta * speed / 100
		item.position = path_follow.position

		if path_follow.progress_ratio >= 1:
			await item.remove()


func _on_item_spawn_interval_timeout() -> void:
	var item = item_object.instantiate()
	var path_follow = PathFollow2D.new()
	var id = generate_uuid()
	
	item.name = "Item_" + str(id)
	item.type = randi() % 3
	item.position = path_follow.position

	path_follow.name = "PathFollow_" + str(id)
	path_follow.loop = false
	path_follow.add_to_group("items_path")

	items.add_child(item)
	paths.add_child(path_follow)

func generate_uuid() -> String:
	var characters = "0123456789abcdef"
	var uuid = ""

	for i in range(36):
		if i == 8 or i == 13 or i == 18 or i == 23:
			uuid += "-"
		else:
			var random_index = randi() % characters.length()
			uuid += characters[random_index]

	return uuid
