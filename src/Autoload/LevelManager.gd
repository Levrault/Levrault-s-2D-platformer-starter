# Set all rooms in the memory
extends Node

var rooms := {}
var level_name := ""
var to_load := ""


# Load all room when called
# @param {String} level
func load(level: String) -> void:
	clear_memory()
	level_name = level
	if level == "test":
		rooms = {
			"Room1": load("res://src/Levels/Tests/RoomTest1.tscn"),
			"Room2": load("res://src/Levels/Tests/RoomTest2.tscn"),
			"Room3": load("res://src/Levels/Tests/RoomTest3.tscn")
		}
		Events.emit_signal("level_preload_finished")
		return
	if level == "test2":
		rooms = {
			"Room1": load("res://src/Levels/Tests/RoomTest4.tscn"),
			"Room2": load("res://src/Levels/Tests/RoomTest5.tscn"),
		}
		Events.emit_signal("level_preload_finished")
		return

	if level == 'debug_dialogue':
		rooms = {
			"Room1": load("res://src/Levels/Debug/DebugDialogueRoom.tscn"),
		}
		Events.emit_signal("level_preload_finished")
		return

	if level == "debug_cinematic":
		rooms = {
			"Room1": load("res://src/Levels/Debug/DebugCinematic.tscn"),
		}
		Events.emit_signal("level_preload_finished")
		return

	if level == "debug_abilities":
		rooms = {
			"Room1": load("res://src/Levels/Debug/DebugAbilities.tscn"),
		}
		Events.emit_signal("level_preload_finished")
		return

	if level == "debug_save_room":
		rooms = {
			"Room1": load("res://src/Levels/Debug/DebugSaveRoom.tscn"),
		}
		Events.emit_signal("level_preload_finished")
		return


func clear_memory() -> void:
	if rooms.empty():
		return
	rooms.clear()
