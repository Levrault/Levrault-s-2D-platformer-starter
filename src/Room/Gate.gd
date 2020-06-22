tool
extends Area2D

enum FACING { LEFT, RIGHT, TOP, BOTTOM }
export (FACING) var facing = FACING.RIGHT setget set_facing
export var go_to_room := ''
export var linked_to := ''


func _ready():
	connect("body_entered", self, "_on_Body_entered")


func _on_Body_entered(body: Player) -> void:
	RoomManager.gate_to_spawn = linked_to
	Events.call_deferred("emit_signal", "gate_entered", go_to_room)


func set_facing(value) -> void:
	facing = value
	if value == FACING.LEFT:
		rotation_degrees = 0
		scale.x = -1
		scale.y = 1
		return

	if value == FACING.RIGHT:
		rotation_degrees = 0
		scale.x = 1
		scale.y = 1
		return

	if value == FACING.TOP:
		rotation_degrees = 90
		scale.x = 1
		scale.y = 1
		return

	# bottom
	rotation_degrees = 90
	scale.x = -1
	scale.y = 1
