extends CharacterBody2D

@export var id: int = 1 # Player's ID
@export var speed: float = 400 # Player's Speed (px/s)

var screen_size: Vector2
var player_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_name = "player" + str(id)
	
	$Label.text = "Player" + str(id)
	$Label.modulate = [Color(1, 0, 0), Color(0, 0, 1)][id - 1]
	$Sprite2D.texture = load("res://assets/sprites/players/" + player_name + ".png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO

	if Input.is_action_pressed(player_name + "_up"):
		velocity.y -= 1
	if Input.is_action_pressed(player_name + "_down"):
		velocity.y += 1
	if Input.is_action_pressed(player_name + "_left"):
		velocity.x -= 1
	if Input.is_action_pressed(player_name + "_right"):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$Sprite2D.rotation = atan2(velocity.y, velocity.x) + 90 * PI / 180
	
	move_and_slide()
	position = position.clamp(Vector2.ZERO, screen_size)
