extends Node2D

@onready var spawn_asteroids_timer: Timer = $"spawn_asteroids_timer"
var next_spawn_time_max = 5.0
var next_spawn_time_min = 2.0
var asteroids = [
	preload("res://characters/enemies/asteroids/asteroid_01.tscn"),
	preload("res://characters/enemies/asteroids/asteroid_02.tscn"),
	preload("res://characters/enemies/asteroids/asteroid_03.tscn"),
	preload("res://characters/enemies/asteroids/asteroid_04.tscn"),
	preload("res://characters/enemies/asteroids/asteroid_05.tscn")                             
] 

func _ready():
	randomize()
	spawn_asteroids_timer.start(next_spawn_time_max)

func spawn_asteroid(asteroid: PackedScene):
	var view_rect := get_viewport_rect()
	var viewport_width := randf_range(view_rect.position.x, view_rect.end.x)
	var asteroid_instance = asteroid.instantiate() 
	asteroid_instance.position = Vector2(viewport_width, position.y - 20)
	get_tree().current_scene.get_node("spawn_asteroids").add_child(asteroid_instance)

func on_spawn_asteroids_timer_timeout():
	var asteroid_scene = asteroids[randi() % asteroids.size()] as PackedScene
	spawn_asteroid(asteroid_scene)
	spawn_asteroids_timer.start(randf_range(next_spawn_time_min, next_spawn_time_max))
	
