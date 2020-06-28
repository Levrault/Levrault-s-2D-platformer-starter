# Set all rooms in the memory
extends Node

var rooms := {}


# Load all room when called
# @param {String} world
func load(world: String) -> void:
	if world == 'test':
		rooms = {
			"RoomTest1": load("res://src/Levels/Tests/RoomTest1.tscn"),
			"RoomTest2": load("res://src/Levels/Tests/RoomTest2.tscn"),
			"RoomTest3": load("res://src/Levels/Tests/RoomTest3.tscn")
		}
		Events.emit_signal("level_preload_finished")
		return

	if world == 'debug_dialogue':
		rooms = {
			"DebugDialogueRoom": load("res://src/Levels/Tests/DebugDialogueRoom.tscn"),
		}
		Events.emit_signal("level_preload_finished")
		return

	if world == 'debug_cinematic':
		rooms = {
			"DebugCinematic": load("res://src/Levels/Tests/DebugCinematic.tscn"),
		}
		Events.emit_signal("level_preload_finished")
		return
