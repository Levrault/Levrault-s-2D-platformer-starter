# Should be seen has an abstract class
# Every character that can fight should inherit from it
extends KinematicBody2D
class_name Actor

onready var stats: Stats = $Stats as Stats


# Actor has taken a hit
# @param {Hit} source
func take_damage(source: Hit) -> void:
	stats.take_damage(source)
