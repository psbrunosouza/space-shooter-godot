extends Node2D

func _physics_process(delta):
	var x_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y_direction = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if !(x_direction == 0 && y_direction == 0):
		owner.velocity = Vector2(x_direction, y_direction)
		owner.velocity = owner.velocity.normalized() * owner.speed
	else: 
		owner.velocity = Vector2.ZERO
		
	owner.velocity = owner.velocity * delta
	owner.move_and_collide(owner.velocity)
