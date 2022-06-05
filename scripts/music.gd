extends AudioStreamPlayer

func _ready():
	stream = preload("res://sound/chimes.wav")
	stream.loop_begin = 372510
	play()
	volume_db = -30
	pause_mode = Node.PAUSE_MODE_PROCESS
