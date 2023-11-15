extends CharacterBody2D

var explosion: PackedScene = load("res://effects/explosion.tscn")
var bug_bullet: PackedScene = load("res://scenes/enemies/green_bettle/bugs_launcher.tscn")
@onready var timer: Timer = $shoot_timer

var life: int = 2
var speed: float = 1000.0

func _ready():
	timer.start(0.5)

func _physics_process(delta: float):
	movement(delta)
	
func movement(delta: float): 
	velocity.y += speed * delta
	velocity = velocity * delta
	move_and_collide(velocity)

func instantiate_explosion() -> void:
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = global_position
	get_tree().current_scene.get_node("spawn_explosions").add_child(explosion_instance)
	
func instantiate_bullet_hit(body) -> void:
	var hit_instance = WeaponManager.hit.instantiate()
	hit_instance.position = body.position
	get_tree().current_scene.add_child(hit_instance)

func attack() -> void:
	var bullet = bug_bullet.instantiate() as CharacterBody2D
	bullet.global_position = Vector2(position.x, position.y + 20);
	get_tree().current_scene.get_node("spawn_bullets").add_child(bullet)
	

func _on_hit_box_body_entered(body):
	instantiate_bullet_hit(body)

	life -= WeaponManager.damage

	if life <= 0:
		instantiate_explosion()
		queue_free()
		
	body.queue_free()

func _on_timer_timeout():
	attack();
	timer.start(3);


func _on_screen_notifier_screen_exited():
	queue_free()
