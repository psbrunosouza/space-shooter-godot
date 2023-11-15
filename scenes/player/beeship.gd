extends SpaceshipControl

@onready var hud: Node2D = get_parent().get_node("hud")
@onready var sprite: AnimatedSprite2D = $sprite
@onready var animation_player: AnimationPlayer = $animation_player
@onready var hurtbox: CollisionShape2D = $hurtbox/collider
@onready var collider: CollisionShape2D = $collider

var explosion: PackedScene = load("res://effects/explosion.tscn")

func _ready():
	hud.emit_signal("set_life", life, max_life)

func _on_hurtbox_body_entered(_body):
	if life > 0:
		life -= 1
	
	if life <= 0:
		var explosion_instance = explosion.instantiate()
		explosion_instance.position = position
		get_tree().current_scene.get_node("spawn_ship_explosion").add_child(explosion_instance)
		queue_free()
		
	hud.emit_signal("set_life", life, max_life)


func _on_invencibility_timer_timeout():
	animation_player.stop()
	sprite.modulate = Color(1,1,1,1)
	hurtbox.set_deferred("disabled", false)
	collider.set_deferred("disabled", false)
