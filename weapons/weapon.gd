extends Node2D

var loaded_weapon: Node2D

func set_weapon(new_weapon: PackedScene) -> void:
	loaded_weapon = new_weapon.instantiate()
	loaded_weapon.position = Vector2(0, -20)
	add_child(loaded_weapon)
	
func shoot() -> void:
	var weapon_sprite: AnimatedSprite2D = get_node("pistol").get_node("sprite")
	var bullet: CharacterBody2D = loaded_weapon.bullet.instantiate()
	weapon_sprite.play("attack")
	bullet.position = weapon_sprite.position
	get_node("pistol").add_child(bullet)
	
