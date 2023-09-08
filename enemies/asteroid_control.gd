extends CharacterBody2D

class_name AsteroidControl

@onready var hit_flash_animation: AnimationPlayer = $hit_flash_animation

var explosion: PackedScene = load("res://effects/explosion.tscn")

var life: int = 1
var min_vertical_speed: float = 1500.0
var max_vertical_speed: float = 2000.0
var min_horizontal_speed: float = 1200.0
var max_horizontal_speed: float = 1500.0
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
	move_and_collide(velocity)
	
func movement(delta: float): 
	velocity.x += direction * min_horizontal_speed * delta
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
	
	velocity.y += min_vertical_speed * delta
	velocity.y = clamp(velocity.y, -max_vertical_speed, max_vertical_speed)
	
	velocity = velocity * delta

func instantiate_explosion() -> void:
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = position
	get_tree().current_scene.get_node("spawn_explosion").add_child(explosion_instance)
	
func instantiate_bullet_hit(body) -> void:
	var hit_instance = WeaponManager.hit.instantiate()
	hit_instance.position = body.position
	get_tree().current_scene.add_child(hit_instance)
	
func on_hitbox_body_entered(body: Node2D):
	instantiate_bullet_hit(body)

	life -= WeaponManager.damage

	if life <= 0:
		instantiate_explosion()
		queue_free()
	body.queue_free()

	hit_flash_animation.play("flash")
	
func on_asteroid_visibility_notifier_screen_exited():
	queue_free()
