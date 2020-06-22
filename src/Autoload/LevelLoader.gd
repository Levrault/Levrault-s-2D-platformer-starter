extends Node

signal world_loaded

var rooms := {}


func load(world: String) -> void:
	if world == 'test':
		rooms = {
			"RoomTest1": load("res://src/Levels/Tests/RoomTest1.tscn"),
			"RoomTest2": load("res://src/Levels/Tests/RoomTest2.tscn"),
			"RoomTest3": load("res://src/Levels/Tests/RoomTest3.tscn")
		}
		Events.emit_signal("level_preload_finished")
		print_debug("preload is over")
		return
