extends TileMapLayer

@export var item_object: PackedScene # Items scene
@export var items_name: PackedStringArray # What items this conveyor carries
@export var speed: int = 8

func _ready() -> void:
	var item = item_object.instantiate()
	$Items.add_child(item)

func _process(delta: float) -> void:
	$Path2D/PathFollow2D.progress_ratio += delta * speed / 100
	$Items.get_child(0).position = $Path2D/PathFollow2D.position
