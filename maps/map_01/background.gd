extends ParallaxBackground

func _process(delta: float):
	scroll_offset.y += 300 * delta
