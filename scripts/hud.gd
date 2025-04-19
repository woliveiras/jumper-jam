extends Control

@onready var top_bar = $TopBar
@onready var top_bar_bg = $TopBarBG
@onready var score_label = $TopBar/ScoreLabel

func _ready() -> void:
	var os_name = OS.get_name()
	if os_name == "Android" || os_name == "iOS":
		var safe_area = DisplayServer.get_display_safe_area()
		var screen_scale = DisplayServer.screen_get_scale()
		var safe_area_top = (safe_area.position.y / screen_scale)
		
		
		top_bar.position.y += safe_area_top
		top_bar_bg.size.y += safe_area_top

func _on_pause_button_pressed() -> void:
	pass # Replace with function body.

func set_score(new_score: int):
	if score_label != null:
		score_label.text = str(new_score)
