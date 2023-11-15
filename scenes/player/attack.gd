extends Node2D

@onready var attack_speed_timer: Timer = $attack_speed_timer

func _physics_process(_delta):
	if Input.is_action_pressed("shot") && attack_speed_timer.is_stopped():
		owner.get_node("weapon").shoot()
		attack_speed_timer.start(WeaponManager.attack_speed)
