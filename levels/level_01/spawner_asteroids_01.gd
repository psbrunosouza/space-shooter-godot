extends Node2D

var asteroid = load("res://enemies/asteroid_01/asteroid_01.tscn")


func _ready():
	var asteroids = [
		$spawner_asteroids_01,
		$spawner_asteroids_02,
		$spawner_asteroids_03,
		$spawner_asteroids_04
	]
	
	for i in asteroids:
		var marker = i as Marker2D
		var asteroid_instance = asteroid.instantiate() 
		asteroid_instance.position = Vector2.ZERO
		asteroid_instance.max_distance = 128
		marker.add_child(asteroid_instance)
		
	

