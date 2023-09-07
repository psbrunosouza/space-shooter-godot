extends CharacterBody2D

class_name AsteroidControl

var life: int = 1
var min_vertical_speed: float = 20.0
var max_vertical_speed: float = 40.0
var min_horizontal_speed: float = 10.0
var max_horizontal_speed: float = 15.0
var rotation_rate: float = 5.0
var direction: int 

func _ready():
	randomize()
	get_direction()

func get_direction(): 
	if randf_range(0, 1) > 0.5:
		direction = -1
	else:
		direction = 1

func _physics_process(delta: float):
	movement(delta)
	move_and_slide()
	
func movement(delta: float): 
	velocity.x += direction * min_horizontal_speed * delta
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
	
	velocity.y += min_vertical_speed * delta
	velocity.y = clamp(velocity.y, -max_vertical_speed, max_vertical_speed)
