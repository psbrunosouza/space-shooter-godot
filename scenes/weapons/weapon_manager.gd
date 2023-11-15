extends Node

var weapon: PackedScene = preload("res://scenes/weapons/pistol/pistol.tscn")
var bullet: PackedScene = preload("res://scenes/weapons/pistol/pistol_bullet.tscn")
var hit: PackedScene = preload("res://scenes/weapons/pistol/pistol_hit.tscn")
var damage: int = 1
var attack_speed: float = 0.650
