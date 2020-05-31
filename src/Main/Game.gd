extends Node2D

onready var player: Player = $Player

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_restart_level"):
		get_tree().reload_current_scene()
		return

	if event.is_action_pressed("debug_spawn"):
		player.state_machine.transition_to("Spawn")
		return

	if event.is_action_pressed("debug_die"):
		player.state_machine.transition_to("die")
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