extends Node

class_name Bullet

var bulletDict: Dictionary = {
	"bullet_01": load("res://characters/bullets/bullet_01.tscn")
}

func _init():
	BulletControl.currentBullet = bulletDict["bullet_01"] 

func changeBullet(bullet: String):
	BulletControl.currentBullet = bulletDict[bullet]

