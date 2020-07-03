tool
extends Gate

export (
	String,
	"demo",
	"debug_portal",
	"debug_dialogue",
	"debug_cinematic",
	"debug_abilities",
	"debug_save_room"
) var go_to_level := "demo"


func _on_Player_entered(body: Player) -> void:
	RoomManager.gate_to_spawn = linked_to
	Events.call_deferred("emit_signal", "portal_entered", go_to_level, go_to_room)
