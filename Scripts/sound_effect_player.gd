extends AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_sound_effect(sound_name: String):
	stream = load("res://Audio/%s.wav" % sound_name) as AudioStream
	play()

func _on_mute_button_toggled(toggled: bool):
	if toggled:
		volume_db = 0.0
	else:
		volume_db = -80.0
