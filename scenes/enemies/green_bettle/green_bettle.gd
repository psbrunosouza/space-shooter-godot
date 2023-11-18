extends CharacterBody2D

var explosion: PackedScene = load("res://effects/explosion.tscn")
var type: String = "bug"
var life: int = 2

func instantiate_explosion() -> void:
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = global_position
	get_tree().current_scene.get_node("spawn_explosions").add_child(explosion_instance)
	
func instantiate_bullet_hit(body) -> void:
	var hit_instance = WeaponManager.hit.instantiate()
	hit_instance.position = body.position
	get_tree().current_scene.add_child(hit_instance)

func _on_hit_box_body_entered(body):
	instantiate_bullet_hit(body)

	life -= WeaponManager.damage

	if life <= 0:
		instantiate_explosion()
		queue_free()
		
	body.queue_free()

func _on_screen_notifier_screen_exited():
	queue_free()
