extends CharacterBody2D
class_name Player

signal died 

@onready var animator = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D

var speed: float = 300.0
var gravity: float = 15.0
var max_fall_velocity = 1000.0
var jump_velocity = -800

var accelerometer_speed = 130.0
var use_accelerometer = false

var dead = false

var viewport_size

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	var os_name = OS.get_name()
	if os_name == "Android" || os_name == "iOS":
		use_accelerometer = true

func _process(_delta: float) -> void:
	if velocity.y > 0:
		if animator.current_animation != "fall":
			animator.play("fall")
	elif velocity.y < 0:
		if animator.current_animation != "jump":
			animator.play("jump")
		

func _physics_process(_delta: float) -> void:
	velocity.y += gravity
	if velocity.y > max_fall_velocity:
		velocity.y = max_fall_velocity
	
	if !dead:
		if use_accelerometer:
			var direction = Input.get_accelerometer()
			velocity.x = direction.x * accelerometer_speed
		else:
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

func jump():
	velocity.y = jump_velocity
	SoundFX.play("JUMP")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	die()

func die():
	if !dead:
		dead = true
		collision_shape.set_deferred("disabled", true)
		died.emit()
		SoundFX.play("FALL")
