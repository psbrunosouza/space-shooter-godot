extends AsteroidControl

@onready var hit_flash_animation: AnimationPlayer = $hit_flash_animation

func _physics_process(delta: float):
	movement(delta)
	move_and_slide()
	
func on_hitbox_body_entered(body: Node2D):
	hit_flash_animation.play("flash")
	var bullet = Bullet.current_bullet.instantiate()
	var bullet_basic_hit_instance = bullet.bullet_basic_hit.instantiate()
	
	life -= bullet.damage
	
	bullet_basic_hit_instance.position = body.position
	get_tree().current_scene.add_child(bullet_basic_hit_instance)
	
	if life <= 0:
		queue_free()
		
	body.queue_free()
	
func on_asteroid_visibility_notifier_screen_exited():
	queue_free()
