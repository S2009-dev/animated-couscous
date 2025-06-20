extends TileMapLayer

@export var item_object: PackedScene # Items scene
@export var speed: int = 8

func _process(delta: float) -> void:
    for i in range($Items.get_child_count()):
        var item = $Items.get_child(i)
        var path_follow = $Path2D.get_child(i)

        path_follow.progress_ratio += delta * speed / 100
        item.position = path_follow.position

        if path_follow.progress_ratio >= 1:
            item.queue_free()
            path_follow.queue_free()


func _on_item_spawn_interval_timeout() -> void:
    var item = item_object.instantiate()
    var path_follow = PathFollow2D.new()

    item.position = path_follow.position
    path_follow.loop = false

    $Items.add_child(item)
    $Path2D.add_child(path_follow)
