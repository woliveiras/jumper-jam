extends Node

@onready var game = $Game
@onready var screens = $Screens

var is_game_in_progress = false

func _ready() -> void:
	DisplayServer.window_set_window_event_callback(_on_window_event)
	screens.start_game.connect(_on_screens_start_game)
	screens.delete_level.connect(_on_screens_delete_level)
	game.player_died.connect(_on_game_player_died)
	game.pause_game.connect(_on_game_pause_game)
	
func _on_screens_start_game():
	is_game_in_progress = true
	game.new_game()

func _on_screens_delete_level():
	is_game_in_progress = false
	game.reset_game()
	
func _on_game_player_died(score, highscore):
	is_game_in_progress = false
	await(get_tree().create_timer(0.75).timeout)
	screens.game_over(score, highscore)

func _on_game_pause_game():
	get_tree().paused = true
	screens.pause_game()

func _on_window_event(event):
	match event:
		DisplayServer.WINDOW_EVENT_FOCUS_IN:
			pass
		DisplayServer.WINDOW_EVENT_FOCUS_OUT:
			if is_game_in_progress == true && !get_tree().paused:
				_on_game_pause_game()
		DisplayServer.WINDOW_EVENT_CLOSE_REQUEST:
			get_tree().quit()
