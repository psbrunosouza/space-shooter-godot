extends CharacterBody2D

var bullet_speed: float = 10000.0
var bullet_speed_max: float = 10000.0

func _physics_process(delta: float) -> void:
	velocity.y -= bullet_speed * delta
	velocity.y = clamp(velocity.y, -bullet_speed_max, bullet_speed_max)
	velocity = velocity * delta
	move_and_collide(velocity)

func bullet_screen_notifier():
	queue_free() 
