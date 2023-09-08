extends Node2D

var weapons: Dictionary = {
	"pistol": {
		"current": preload("res://weapons/pistol/pistol.tscn"),
		"bullet": preload("res://weapons/pistol/pistol_bullet.tscn"),
		"hit": preload("res://weapons/pistol/pistol_hit.tscn"),
		"damage": 1,
		"attack_speed": 0.650
	}
}

func set_weapon(weapon: String) -> void:
	WeaponManager.weapon = weapons[weapon]["current"] as PackedScene
	WeaponManager.bullet = weapons[weapon]["bullet"] as PackedScene
	WeaponManager.hit = weapons[weapon]["hit"] as PackedScene
	var instance = WeaponManager.weapon.instantiate()
	instance.position = Vector2(0, -20)
	add_child(instance)
	
func shoot(player: CharacterBody2D) -> void:
	var weapon_sprite: AnimatedSprite2D = get_child(0).get_node("sprite")
	var weapon = get_node("pistol")
	var bullet: CharacterBody2D = WeaponManager.bullet.instantiate()
	bullet.position = Vector2(weapon.global_position.x + weapon_sprite.position.x, weapon.global_position.y + weapon_sprite.position.y)
	get_tree().current_scene.get_node("spawn_bullets").add_child(bullet)
	weapon_sprite.play("attack")
