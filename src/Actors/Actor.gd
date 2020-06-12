extends KinematicBody2D
class_name Actor

onready var stats: Stats = $Stats as Stats


func take_damage(source: Hit) -> void:
	stats.take_damage(source)
