extends Node2D


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
