tool
extends Area2D

enum Facing { LEFT, RIGHT, TOP, BOTTOM }
export (Facing) var facing = Facing.RIGHT setget set_facing
export var go_to_room := ''
export var linked_to := ''


func _ready():
	connect("body_entered", self, "_on_Player_entered")


func set_facing(value) -> void:
	facing = value
	if value == Facing.LEFT:
		rotation_degrees = 0
		scale.x = -1
		scale.y = 1
		return

	if value == Facing.RIGHT:
		rotation_degrees = 0
		scale.x = 1
		scale.y = 1
		return

	if value == Facing.TOP:
		rotation_degrees = 90
		scale.x = 1
		scale.y = 1
		return

	# bottom
	rotation_degrees = 90
	scale.x = -1
	scale.y = 1


func _on_Player_entered(body: Player) -> void:
	RoomManager.gate_to_spawn = linked_to
	Events.call_deferred("emit_signal", "gate_entered", go_to_room)
