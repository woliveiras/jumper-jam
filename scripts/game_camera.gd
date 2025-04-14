extends Camera2D
class_name GameCamera

var player: Player = null
var viewport_size

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	global_position.x = viewport_size.x /2
	
	limit_bottom = viewport_size.y
	limit_right = viewport_size.x
	limit_left = 0 
	
func _process(delta: float) -> void:
	if player:
		var limit_distance = 420
		
		if limit_bottom > player.global_position.y + limit_distance:
			limit_bottom = player.global_position.y + limit_distance

func _physics_process(delta: float) -> void:
	if player:
		global_position.y = player.global_position.y

func setup_camera(_player: Player):
	if _player:
		player = _player
