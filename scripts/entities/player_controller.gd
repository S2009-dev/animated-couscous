extends CharacterBody2D

@export_range(1, 2) var id: int = 1 # ID (only 1 or 2)
@export var speed: float = 400 # Walking Speed (px/s)

@onready var sprite: Sprite2D = %Sprite2D
@onready var label: Label = %Label
@onready var interaction_range: Area2D = %InteractionRange

var screen_size: Vector2
var player_name: String # Used for sprite loading and input actions
var collision_body: Area2D
var stored_item: Color

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
		if collision_body and collision_body.is_in_group("items"):
			stored_item = collision_body.get_node("ColorRect").modulate
			collision_body.remove()
	else:
		if collision_body and collision_body.is_in_group("bins"):
			collision_body.throw_item(stored_item)
			stored_item = Color()

# The area is checking only for layer 2, used for items and bin
func _on_interaction_range_area_entered(area: Area2D) -> void:
	collision_body = area

func _on_interaction_range_area_exited(_area: Area2D) -> void:
	collision_body = null
