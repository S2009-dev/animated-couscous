extends TileMapLayer

@export var item_scene: PackedScene # Items scene
@export var speed: int = 8
@export var item_spawn_interval: float = 1.0

@onready var paths: Path2D = %Path2D
@onready var items: Node2D = %Items
@onready var timer: Timer = %ItemSpawnInterval

func _ready() -> void:
	timer.wait_time = item_spawn_interval
	timer.start()

func _process(delta: float) -> void:
	for item in items.get_children():
		var id = item.name.get_slice("_", 1)
		var path_follow = paths.get_node("PathFollow_" + str(id))

		path_follow.progress_ratio += delta * speed / 100
		item.position = path_follow.position

		if path_follow.progress_ratio >= 1:
			get_node("/root/World").emit_signal("update_errors")
			await item.remove()


func _on_item_spawn_interval_timeout() -> void:
	var item = item_scene.instantiate()
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
