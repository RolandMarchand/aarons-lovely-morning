extends ParallaxBackground

export(float) var speed: float = 50

func _process(delta: float):
	scroll_offset.x -= speed * delta
