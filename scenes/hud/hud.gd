extends Node2D

signal set_life(life, max_life)

var heart_states = {
	0: preload("res://assets/hud/heart_04.png"),
	1: preload("res://assets/hud/heart_03.png"),
	2: preload("res://assets/hud/heart_02.png"),
	3: preload("res://assets/hud/heart_01.png")
}

func _on_set_life(life, max_life):
	var hearts = $heart as TextureRect
	hearts.size = Vector2(max_life * 16, 16)
	hearts.texture = heart_states[life]
