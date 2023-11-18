extends Node2D

var frequency = 2    
var time_passed = 0
var amplitude = 20
var speed: float = 12

func _physics_process(delta):
	time_passed += delta
	
	var x_offset = amplitude * sin(frequency * time_passed)
	var y_offset = time_passed * speed
	
	var move = Vector2(x_offset, y_offset)
	owner.velocity = move - position
	
	owner.move_and_slide()
