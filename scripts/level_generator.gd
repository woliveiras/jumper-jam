extends Node2D

@onready var platforms = $Platforms
var platform_scene = preload("res://scenes/platform.tscn")

var start_platform_y
var y_distance_between_platforms = 100
var level_size = 10
var viewport_size
var generated_platform_count: int = 0
var player: Player = null

func setup(_player: Player):
	if _player:
		player = _player

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	generated_platform_count = 0
	start_platform_y = viewport_size.y - (y_distance_between_platforms * 2)

func _process(_delta: float) -> void:
	if player:
		var player_y = player.global_position.y 
		var end_of_level_pos = start_platform_y - (generated_platform_count * y_distance_between_platforms)
		var threshold = end_of_level_pos + (y_distance_between_platforms * 10)
		
		if player_y <= threshold:
			generate_level(end_of_level_pos, false)

func start_generation():
	generate_level(start_platform_y, true)

func create_platform(location: Vector2):
	var platform = platform_scene.instantiate()
	platform.global_position = location
	platforms.add_child(platform)
	return platform

func generate_level(start_y: float, generate_ground: bool):
	var platform_width = 136
	
	# Generate the ground
	if generate_ground:
		var ground_layer_y_offset = 62
		var ground_layer_platform_count = (viewport_size.x / platform_width) + 1 # +1 is the gap
		
		for i in range(ground_layer_platform_count):
			var ground_location = Vector2(i * platform_width, viewport_size.y - ground_layer_y_offset)
			create_platform(ground_location)
	
	# Generate levels
	for i in range(level_size):
		var max_x_position = viewport_size.x - platform_width
		var random_x = randf_range(0.0, max_x_position)
		var location: Vector2
		
		location.x = random_x
		location.y = start_y - (y_distance_between_platforms * i)
		
		create_platform(location)
		generated_platform_count += 1

func reset_level():
	generated_platform_count = 0
	for platform in platforms.get_children():
		platform.queue_free()
