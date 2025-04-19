extends Node

@onready var sound_players = get_children()

var sounds = {
	"CLICK": load("res://assets/sound/Click.wav"),
	"JUMP": load("res://assets/sound/Jump.wav"),
	"FALL": load("res://assets/sound/Fall.wav"),
}

func play(sound_name):
	var sound_to_play = sounds[sound_name]
	
	for sound_player in sound_players:
		if sound_player.playing == false:
			sound_player.stream = sound_to_play
			sound_player.play()
			return
