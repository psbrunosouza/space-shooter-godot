extends CharacterBody2D

@onready var life = 3
@onready var bullet_basic_hit: PackedScene = preload("res://characters/bullets/bullet_basic_hit.tscn")

var min_vertical_speed = 20.0
var max_vertical_speed = 40.0
var min_horizontal_speed = 10.0
var max_horizontal_speed = 15.0
var rotation_rate = 5.0
var direction: int 


func _ready():
	randomize()
	
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
	
	rotation_degrees += rotation_rate * delta


func on_hitbox_body_entered(body):
	life -= 1
	
	var bullet_basic_hit_instance = bullet_basic_hit.instantiate()
	bullet_basic_hit_instance.position = body.position
	get_tree().current_scene.add_child(bullet_basic_hit_instance)
	
	if life <= 0:
		queue_free()
	
	body.queue_free()

func on_asteroid_visibility_notifier_screen_exited():
	queue_free()
