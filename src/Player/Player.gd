extends KinematicBody2D
class_name Player

onready var state_machine: StateMachine = $StateMachine
onready var skin: Node2D = $Skin
onready var camera_rig: Position2D = $CameraRig
onready var shaking_camera: Camera2D = $CameraRig/ShakingCamera
onready var collider: CollisionShape2D = $CollisionShape2D

const FLOOR_NORMAL := Vector2.UP

var is_active := true setget set_is_active
var is_handling_input := true setget set_is_handling_input


func set_is_handling_input(value: bool) -> void:
	$StateMachine.set_process_unhandled_input(value)
	$StateMachine.set_physics_process(value)
	is_handling_input = value


func set_is_active(value: bool) -> void:
	is_active = value
	if not collider:
		return
	collider.disabled = not value
