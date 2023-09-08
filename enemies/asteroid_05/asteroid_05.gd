extends AsteroidControl

var explosion: PackedScene = load("res://effects/explosion.tscn")

@onready var hit_flash_animation: AnimationPlayer = $hit_flash_animation

func _ready():
	hit_flash_animation.play("idle")
	life = 3

func _physics_process(delta: float):
	movement(delta)
	move_and_slide()
	
func instantiate_explosion() -> void:
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = position
	get_tree().current_scene.get_node("spawn_explosion").add_child(explosion_instance)
	
func instantiate_bullet_hit(body) -> void:
	var hit_instance = WeaponManager.hit.instantiate()
	life -= WeaponManager.damage
	print(hit_instance)
	hit_instance.position = body.position
	get_tree().current_scene.add_child(hit_instance)
	
func on_hitbox_body_entered(body: Node2D):
	instantiate_bullet_hit(body)

	if life <= 0:
		instantiate_explosion()
		queue_free()
	body.queue_free()

	hit_flash_animation.play("flash")

func on_animation_finished():
	queue_free()
