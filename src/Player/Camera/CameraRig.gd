#Rig to move a child camera based on the player's input, to give them more forward visibility
extends Position2D

onready var camera: Camera2D = $ShakingCamera

export var offset := Vector2(300.0, 300.0)
export var mouse_range := Vector2(100.0, 500.0)

var is_active := true

func _physics_process(delta: float) -> void:
	update_position()


# Updates the camera rig's position based on the player's state and controller position
func update_position(velocity: Vector2 = Vector2.ZERO) -> void:
	if not is_active:
		return
