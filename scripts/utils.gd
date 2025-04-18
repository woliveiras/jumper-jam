extends Node

func log_message(message: String):
	var console = get_tree().get_first_node_in_group("debug_console")
	
	if console:
		var label = console.find_child("LogLabel")
		
		if label:
			label.text += message
			label.text += "\n"
	
