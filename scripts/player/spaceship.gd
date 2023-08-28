extends CharacterBody2D

@export var speed = 200.0
@onready var sprite: AnimatedSprite2D = $"sprite"

var currentBullet: PackedScene = load("res://characters/bullets/bullet_prepare.tscn")
var bullet: Bullet

func _ready():
	bullet = Bullet.new()

func _physics_process(_delta):
	var horizontal_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical_direction = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity.x = horizontal_direction
	velocity.y = vertical_direction
	
	velocity = velocity.normalized() * speed
	
	if horizontal_direction == -1:
		sprite.play("move_left")
	elif horizontal_direction == 1:
		sprite.play("move_right")
	else:
		sprite.play("move_forward")
	
	attack()
	move_and_slide()

func attack():
	if Input.is_action_just_pressed("shot"):
		var bullet_prepare_instance = currentBullet.instantiate()
		var bullet_instance = BulletControl.currentBullet.instantiate()
		bullet_instance.position = Vector2(position.x, position.y - 20)
		bullet_prepare_instance.position = Vector2(position.x, position.y - 20)
		get_tree().current_scene.get_node("spawn_bullets").add_child(bullet_instance)
		get_tree().current_scene.get_node("spawn_bullet_prepare").add_child(bullet_prepare_instance)
