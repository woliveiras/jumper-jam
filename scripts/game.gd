extends Node2D

@onready var platforms = $Platforms

var camera_scene = preload("res://scenes/game_camera.tscn")
var platform_scene = preload("res://scenes/platform.tscn")

var camera = null
var start_platform_y
var y_distance_between_platforms = 100
var level_size = 50

func _ready() -> void:
	camera = camera_scene.instantiate()
	camera.setup_camera($Player)
	add_child(camera)
	
	# Generate the ground
	var viewport_size = get_viewport_rect().size
	var platform_width = 136
	var ground_layer_y_offset = 62
	var ground_layer_platform_count = (viewport_size.x / platform_width) + 1 # +1 is the gap
	
	for i in range(ground_layer_platform_count):
		var ground_location = Vector2(i * platform_width, viewport_size.y - ground_layer_y_offset)
		create_platform(ground_location)
	
	# Generate levels
	start_platform_y = viewport_size.y - (y_distance_between_platforms * 2)
	for i in range(level_size):
		var max_x_position = viewport_size.x - platform_width
		var random_x = randf_range(0.0, max_x_position)
		var location: Vector2
		
		location.x = random_x
		location.y = start_platform_y - (y_distance_between_platforms * i)
		
		create_platform(location)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func create_platform(location: Vector2):
	var platform = platform_scene.instantiate()
	platform.global_position = location
	platforms.add_child(platform)
	return platform
