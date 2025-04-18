extends CanvasLayer

@onready var console = $Debug/ConsoleLog
@onready var title_screen = $TitleScreen
@onready var pause_screen = $PauseScreen
@onready var game_over_screen = $GameOverScreen

var current_screen = null

func _ready() -> void:
	console.visible = false
	
	register_buttons()
	change_screen(title_screen)

func _process(_delta: float) -> void:
	pass

func _on_toggle_console_pressed() -> void:
	console.visible = !console.visible

func register_buttons():
	var buttons = get_tree().get_nodes_in_group("buttons")
	
	if buttons.size() > 0:
		for button in buttons:
			if button is ScreenButton:
				button.clicked.connect(_on_button_pressed)

func _on_button_pressed(button):
	match button.name:
		"TitlePlay":
			change_screen(pause_screen)
		"PauseRetry":
			change_screen(game_over_screen)
		"PauseBack":
			change_screen(pause_screen)
		"PauseClose":
			change_screen(pause_screen)
		"GameOverRetry":
			change_screen(title_screen)
		"GameOverBack":
			change_screen(pause_screen)

func change_screen(screen_name):
	if current_screen:
		var disappear_tween = current_screen.disappear()
		await(disappear_tween.finished)
		current_screen.visible = false
	
	current_screen = screen_name
	if current_screen:
		var appear_tween = current_screen.appear()
		await(appear_tween.finished)
		get_tree().call_group("buttons", "set_disabled", false)
