extends Node2D

@onready var level_generator = $LevelGenerator
@onready var ground_sprite = $GroundSprite
@onready var parallax_1 = $ParallaxBackground/ParallaxLayer1
@onready var parallax_2 = $ParallaxBackground/ParallaxLayer2
@onready var parallax_3 = $ParallaxBackground/ParallaxLayer3

var player_scene = preload("res://scenes/player.tscn")
var camera_scene = preload("res://scenes/game_camera.tscn")

var player_spawn_pos: Vector2
var player: Player = null 
var camera: GameCamera = null
var viewport_size: Vector2

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	var player_spawn_y_offset = 135
	
	player_spawn_pos.x = viewport_size.x / 2.0
	player_spawn_pos.y = viewport_size.y - player_spawn_y_offset
	
	ground_sprite.global_position.x = viewport_size.x / 2
	ground_sprite.global_position.y = viewport_size.y
	
	setup_parallax_layer(parallax_1)
	setup_parallax_layer(parallax_2)
	setup_parallax_layer(parallax_3)
	new_game()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
func new_game():
	player = player_scene.instantiate()
	player.global_position = player_spawn_pos
	add_child(player)
	
	camera = camera_scene.instantiate()
	camera.setup_camera($Player)
	add_child(camera)
	
	if player:
		level_generator.setup(player)

func get_parallax_sprite_scale(parallax_sprite: Sprite2D):
	var parallax_texture = parallax_sprite.get_texture()
	var parallax_texture_width = parallax_texture.get_width()
	var parallax_scale = viewport_size.x / parallax_texture_width
	var result = Vector2(parallax_scale, parallax_scale)
	
	return result

func setup_parallax_layer(parallax_layer: ParallaxLayer):
	var parallax_sprite = parallax_layer.find_child("Sprite2D")
	
	if parallax_sprite:
		parallax_sprite.scale = get_parallax_sprite_scale(parallax_sprite)
		
		var motion_mirroring_y = parallax_sprite.scale.y * parallax_sprite.get_texture().get_height()
		parallax_layer.motion_mirroring.y = motion_mirroring_y
		
