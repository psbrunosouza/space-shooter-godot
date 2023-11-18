extends CharacterBody2D

var bullet_speed: float = 10000.0
var bullet_speed_max: float = 10000.0
var type: String = "bullet"

func _physics_process(delta: float) -> void:
	velocity.y += bullet_speed * delta
	velocity.y = clamp(velocity.y, -bullet_speed_max, bullet_speed_max)
	velocity = velocity * delta
	move_and_collide(velocity)

func _on_screen_notifier_screen_exited():
	queue_free() 
