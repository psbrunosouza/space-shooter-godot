extends CharacterBody2D

@export var attack_speed: float = 0.650
@export var damage: int = 1
@export var has_charge: bool = false
@export var bullet_basic_hit: PackedScene = preload("res://bullets/scenes/bullet_basic_hit.tscn")

var speed_multiplier: float = 5.0
var max_speed_multipler: float = 6.0

func _physics_process(delta: float):
	Shoot(delta)
	
func Shoot(delta: float):
	var speed = (Bullet.bullet_speed_base * speed_multiplier) + Bullet.bullet_speed_base
	var max_speed = (Bullet.bullet_speed_max * max_speed_multipler) + Bullet.bullet_speed_max
	
	velocity.y -= speed * delta
	velocity.y = clamp(velocity.y, -max_speed, max_speed)
	move_and_slide()

func bullet_screen_notifier():
	queue_free() 
