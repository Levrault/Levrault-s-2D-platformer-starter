extends Node2D

onready var player: Player = find_node("Player")

func _ready():
	Events.emit_signal(
		"room_limit_changed",
		$BoundsNW.global_position.x,
		$BoundsNW.global_position.y,
		$BoundsSE.global_position.x,
		$BoundsSE.global_position.y
	)

	if Room.gate_to_spawn != "":
		Events.emit_signal(
			"player_room_entered",
			$Gates.get_node(Room.gate_to_spawn).get_node("Spawn").global_position
		)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_restart_level"):
		get_tree().reload_current_scene()
		return

	if event.is_action_pressed("debug_spawn"):
		player.state_machine.transition_to("Spawn")
		return

	if event.is_action_pressed("debug_die"):
		player.state_machine.transition_to("Die")
		return

	if event.is_action_pressed("debug_slow_time"):
		Engine.time_scale = .1
		return

	if event.is_action_pressed("debug_accelerate_time"):
		Engine.time_scale = Engine.time_scale + .1
		return

	if event.is_action_pressed("debug_reset_time"):
		Engine.time_scale = 1.0
		return

	if event.is_action_pressed("debug_free_camera"):
		player.is_handling_input = not player.is_handling_input
		if not player.is_handling_input:
			var free_camera: Camera2D = load("res://src/Tools/FreeCamera.tscn").instance()
			free_camera.position = player.position
			add_child(free_camera)
		else:
			get_node("FreeCamera").queue_free()

