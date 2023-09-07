extends SpaceshipControl

@onready var sprite: AnimatedSprite2D = $sprite
@onready var attack_speed_timer: Timer = $attack_speed_timer
@onready var dash_cooldown_timer: Timer = $dash_cooldown_timer
@onready var weapon: Node2D = $weapon
@onready var hud: Node2D = get_parent().get_node("hud")

var pistol: PackedScene = load("res://weapons/pistol.tscn")
var dash_ghost_sprite: PackedScene = load("res://characters/player/scenes/spaceship_ghost.tscn")

var bullet: BulletPicker
var is_dashing: bool = false

func _ready():
	hud.emit_signal("set_life", life, max_life)
	bullet = BulletPicker.new()
	weapon.set_weapon(pistol)

func _physics_process(_delta):
	var horizontal_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical_direction = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	movement(horizontal_direction, vertical_direction)
	dash(horizontal_direction, vertical_direction)
	attack()
	move_and_slide()

func movement(horizontal_direction: float, vertical_direction: float):
	velocity.x = horizontal_direction
	velocity.y = vertical_direction
#	apply_animation(horizontal_direction)
	velocity = velocity.normalized() * speed

func apply_animation(direction):
	if direction == -1:
		sprite.play("move_left")
	elif direction == 1:
		sprite.play("move_right")
	else:
		sprite.play("move_forward")
	
func attack():
	if Input.is_action_just_pressed("shot") && attack_speed_timer.is_stopped():
		weapon.shoot()
		attack_speed_timer.start(weapon.loaded_weapon.attack_speed)

func dash(horizontal_direction: float, vertical_direction: float):
	if Input.is_action_just_pressed("dash") && !is_dashing:
		is_dashing = true
		var horizontal_dash_direction = position.x + horizontal_direction * 80
		var vertical_dash_direction = position.y + vertical_direction *  80
		create_tween().tween_property(self, "position", Vector2(horizontal_dash_direction, vertical_dash_direction), 0.1)
		dash_cooldown_timer.start(dash_cooldown)
		
	if is_dashing:
		var ghost_sprite_instance = dash_ghost_sprite.instantiate()
		ghost_sprite_instance.position = global_position
		ghost_sprite_instance.sprite_frames = sprite.sprite_frames
		ghost_sprite_instance.frame = sprite.frame
		get_tree().current_scene.get_node("spawn_ship_ghosts").add_child(ghost_sprite_instance)

func _on_dash_cooldown_timer_timeout():
	is_dashing = false

func _on_hurtbox_body_entered(body):
	if life > 0:
		life -= 1
		if life <= 0:
			queue_free()
		
	hud.emit_signal("set_life", life, max_life)
