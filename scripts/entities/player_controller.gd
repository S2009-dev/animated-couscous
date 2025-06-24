extends CharacterBody2D

@export_range(1, 2) var id: int = 1 # ID (only 1 or 2)
@export var speed: float = 400 # Walking Speed (px/s)
@export var interaction_range: float = 64 # Range of interaction (px)

@onready var sprite: Sprite2D = %Sprite2D
@onready var label: Label = %Label

var stored_item: Node2D = null

var screen_size: Vector2
var player_name: String # Used for sprite loading and input actions

func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_name = "player" + str(id)
	
	name = player_name.capitalize()
	label.text = player_name.capitalize()
	label.modulate = [Color(1, 0, 0), Color(0, 0, 1)][id - 1]
	sprite.texture = load("res://assets/sprites/players/" + player_name + ".png")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(player_name + "_interact"):
		interact()

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO

	var input_vector = Input.get_vector(
		player_name + "_left",
		player_name + "_right",
		player_name + "_up",
		player_name + "_down"
	)

	velocity += input_vector * speed
	velocity *= 0.9

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		sprite.rotation = atan2(velocity.y, velocity.x) + 90 * PI / 180
	
	move_and_slide()
	position = position.clamp(Vector2.ZERO, screen_size)

func interact() -> void:
	if !stored_item:
		var items = get_tree().get_nodes_in_group("items")

		for i in range(0, items.size()):
			var item = items[i]
			var distance = position.distance_to(item.position)

			if distance < interaction_range:
				stored_item = item
				item.remove()
				break
	else:
		var bin = get_node("../../Bin")
		if position.distance_to(bin.position) < interaction_range:
			bin.get_node("ColorRect").modulate = stored_item.get_node("ColorRect").modulate
			stored_item = null