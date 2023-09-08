extends CharacterBody2D

var bullet_speed: float = 1000.0
var bullet_speed_max: float = 1200.0

func _physics_process(delta: float) -> void:
	velocity.y -= bullet_speed * delta
	velocity.y = clamp(velocity.y, -bullet_speed_max, bullet_speed_max)
	move_and_slide()

func bullet_screen_notifier():
	queue_free() 
