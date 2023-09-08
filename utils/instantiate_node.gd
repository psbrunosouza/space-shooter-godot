extends Node

class_name InstatiateNode

func _init(root_scene, node: PackedScene, position, spawn_node):
	var instance = node.instantiate()
	instance.position = position
	root_scene.get_node(spawn_node).add_child(instance)
