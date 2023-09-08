extends SpaceshipControl

@onready var sprite: AnimatedSprite2D = $sprite
@onready var attack_speed_timer: Timer = $attack_speed_timer
@onready var dash_cooldown_timer: Timer = $dash_cooldown_timer
@onready var knockback_timer: Timer = $knockback_timer
@onready var weapon: Node2D = $weapon
@onready var hud: Node2D = get_parent().get_node("hud")

var dash_ghost_sprite: PackedScene = load("res://player/spaceship_ghost.tscn")
var explosion: PackedScene = load("res://effects/explosion.tscn")

var is_dashing: bool = false
var is_knockbacking: bool = false
var was_hitted: bool = false

var horizontal_direction
var vertical_direction

var knockback = Vector2.ZERO

func _ready():
	hud.emit_signal("set_life", life, max_life)
	weapon.set_weapon("pistol")

func _physics_process(delta):
	horizontal_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	vertical_direction = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	movement(horizontal_direction, vertical_direction)
	dash(horizontal_direction, vertical_direction)
	attack()
	
	velocity = velocity * delta
	move_and_collide(velocity)

func movement(horizontal_direction: float, vertical_direction: float):
	if !(horizontal_direction == 0 && vertical_direction == 0):
		velocity = Vector2(horizontal_direction, vertical_direction)
		velocity = velocity.normalized() * speed
	else: 
		velocity = Vector2.ZERO

	if knockback != Vector2.ZERO:
		velocity = knockback

func apply_animation(direction):
	if direction == -1:
		sprite.play("move_left")
	elif direction == 1:
		sprite.play("move_right")
	else:
		sprite.play("move_forward")
	
func attack():
	if Input.is_action_just_pressed("shot") && attack_speed_timer.is_stopped():
		weapon.shoot(self)
		attack_speed_timer.start(WeaponManager.attack_speed)

func hit_player(knockback_direction: Vector2, duration = 0.25):
	if knockback_direction != Vector2.ZERO:
		knockback = knockback_direction
		create_tween().tween_property(self, "knockback", Vector2(0, 0), duration)

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

func _on_hurtbox_body_entered(_body):
	if life > 0:
		life -= 1
		var opposite_x_direction = (horizontal_direction * -1)
		var opposite_y_direction = (vertical_direction * -1)
		hit_player(Vector2(opposite_x_direction * 300, opposite_y_direction * 300))
	
	if life <= 0:
		InstatiateNode.new(get_tree().current_scene, explosion, position, "spawn_ship_explosion")
		queue_free()
		
	hud.emit_signal("set_life", life, max_life)
