extends AnimatedSprite2D

func _ready():
	var tween = create_tween().tween_property(self, "modulate", Color(0, 0, 0, 0), 0.2)
	tween.connect("finished", Callable(self, "on_finished"))
	
func on_finished(): 
	queue_free()
	
