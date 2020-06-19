extends Node

signal world_loaded

var rooms := {}


func load(world: String) -> void:
	if world == 'test':
		rooms = {
			"RoomTest1": preload("res://src/Room/RoomTest1.tscn"),
			"RoomTest2": preload("res://src/Room/RoomTest2.tscn"),
			"RoomTest3": preload("res://src/Room/RoomTest3.tscn")
		}
		Events.emit_signal("level_preload_finished")
		print_debug("preload is over")
		return
