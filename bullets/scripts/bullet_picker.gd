extends Node

class_name BulletPicker

var bullet_dict: Dictionary = {
	"bullet_basic": load("res://bullets/scenes/bullet_basic.tscn")
}

func _init():
	Bullet.current_bullet = bullet_dict["bullet_basic"] 

func change_bullet(bullet: String):
	Bullet.current_bullet = bullet_dict[bullet]

