extends CharacterBody2D


var speed: float = 300.0
var gravity: float = 15.0
var max_fall_velocity = 1000.0

var viewport_size

func _ready() -> void:
	viewport_size = get_viewport_rect().size

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.y += gravity
	if velocity.y > max_fall_velocity:
		velocity.y = max_fall_velocity
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	
	var margin = 20
	if global_position.x  > viewport_size.x + margin:
		global_position.x = -margin

	if global_position.x < -margin:
		global_position.x = viewport_size.x + margin
