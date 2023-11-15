extends Node2D

@onready var spawn_enemies_timer: Timer = $"timer"
var next_spawn_time_max = 5.0
var next_spawn_time_min = 2.0
var enemies = [
	preload("res://scenes/enemies/green_bettle/green_bettle.tscn")
] 

func _ready():
	randomize()
	spawn_enemies_timer.start(next_spawn_time_max)

func spawn_enemies(enemy: PackedScene):
	var view_rect := get_viewport_rect()
	var viewport_width := randf_range(view_rect.position.x, view_rect.end.x)
	var ememy_instance = enemy.instantiate() 
	ememy_instance.position = Vector2(viewport_width, position.y - 20)
	get_tree().current_scene.get_node("spawn_enemies").add_child(ememy_instance)

func _on_timer_timeout():
	var enemy_scene = enemies[randi() % enemies.size()] as PackedScene
	spawn_enemies(enemy_scene)
	spawn_enemies_timer.start(randf_range(next_spawn_time_min, next_spawn_time_max))
