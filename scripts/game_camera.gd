extends Camera2D
class_name GameCamera

@onready var destroyer = $Destroyer
@onready var destroyer_shape = $Destroyer/CollisionShape2D

var player: Player = null
var viewport_size

func _ready() -> void:
	if player:
		global_position.y = player.global_position.y

	viewport_size = get_viewport_rect().size
	global_position.x = viewport_size.x /2
	
	limit_bottom = viewport_size.y
	limit_right = viewport_size.x
	limit_left = 0 
	
	destroyer.position.y = viewport_size.y / 2
	
	var rect_shape = RectangleShape2D.new()
	var rect_shape_size = Vector2(viewport_size.x, 100)
	rect_shape.set_size(rect_shape_size)
	destroyer_shape.shape = rect_shape
	
func _process(_delta: float) -> void:
	if player:
		var limit_distance = 420
		
		if limit_bottom > player.global_position.y + limit_distance:
			limit_bottom = int(player.global_position.y + limit_distance)
	
	var overlapping_areas = destroyer.get_overlapping_areas()
	if overlapping_areas.size() > 0:
		for area in overlapping_areas:
			if area is Platform:
				area.queue_free()

func _physics_process(_delta: float) -> void:
	if player != null:
		global_position.y = player.global_position.y

func setup_camera(_player: Player):
	if _player != null:
		player = _player
