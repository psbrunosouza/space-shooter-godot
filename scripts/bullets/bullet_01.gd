extends CharacterBody2D

func _physics_process(delta: float):
	Shoot(delta)
	
func Shoot(delta: float):
	velocity.y -= BulletControl.bullet_speed_base * delta
	velocity.y = clamp(velocity.y, -BulletControl.bullet_speed_max, BulletControl.bullet_speed_max)
	move_and_slide()

func bullet_screen_notifier():
	queue_free() 
