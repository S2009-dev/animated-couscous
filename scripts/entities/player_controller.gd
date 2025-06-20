extends CharacterBody2D

@export_range(1, 2) var id: int = 1 # ID (only 1 or 2)
@export var speed: float = 400 # Walking Speed (px/s)

@onready var sprite: Sprite2D = %Sprite2D
@onready var label: Label = %Label

var screen_size: Vector2
var player_name: String # Used for sprite loading and input actions

func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_name = "player" + str(id)
	
	label.text = player_name.capitalize()
	label.modulate = [Color(1, 0, 0), Color(0, 0, 1)][id - 1]
	sprite.texture = load("res://assets/sprites/players/" + player_name + ".png")


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