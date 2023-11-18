extends Node2D

@onready var shoot_timer = $shoot_timer
var bug_bullet: PackedScene = load("res://scenes/enemies/green_bettle/bugs_launcher.tscn")

func _ready() -> void:
	shoot_timer.start(3)

func attack() -> void:
	var bullet = bug_bullet.instantiate() as CharacterBody2D
	bullet.position = Vector2(owner.position.x, owner.position.y + 20);
	get_tree().current_scene.get_node("spawn_bullets").add_child(bullet)

func _on_shoot_timer_timeout() -> void:
	attack();
	shoot_timer.start(3);
