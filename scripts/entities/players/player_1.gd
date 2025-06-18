extends CharacterBody2D

@export var speed = 400 # Player's Speed (px/s)
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO

	if Input.is_action_pressed("player1_up"):
		velocity.y -= 1
	if Input.is_action_pressed("player1_down"):
		velocity.y += 1
	if Input.is_action_pressed("player1_left"):
		velocity.x -= 1
	if Input.is_action_pressed("player1_right"):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$Sprite2D.rotation = atan2(velocity.y, velocity.x) + 90 * PI / 180
	
	move_and_slide()
	position = position.clamp(Vector2.ZERO, screen_size)
