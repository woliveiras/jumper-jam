extends CanvasLayer

@onready var console = $Debug/ConsoleLog


func _ready() -> void:
	console.visible = false
	
func _process(_delta: float) -> void:
	pass

func _on_toggle_console_pressed() -> void:
	console.visible = !console.visible
