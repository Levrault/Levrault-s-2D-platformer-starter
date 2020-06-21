extends Node

signal world_loaded

var rooms := {}


func load(world: String) -> void:
	if world == 'test':
		rooms = {
			"RoomTest1": load("res://src/Room/RoomTest1.tscn"),
			"RoomTest2": load("res://src/Room/RoomTest2.tscn"),
			"RoomTest3": load("res://src/Room/RoomTest3.tscn")
		}
		Events.emit_signal("level_preload_finished")
		print_debug("preload is over")
		return

	if world == 'test2':
		rooms = {
			"RoomTest4": load("res://src/Room/RoomTest4.tscn"),
		}
		Events.emit_signal("level_preload_finished")
		print_debug("preload is over")
		return

	if world == 'test3':
		rooms = {
			"RoomTest1": load("res://src/Room/RoomTest1.tscn"),
			"RoomTest2": load("res://src/Room/RoomTest2.tscn"),
			"RoomTest3": load("res://src/Room/RoomTest3.tscn"),
			"RoomTest4": load("res://src/Room/RoomTest4.tscn"),
			"RoomTest5": load("res://src/Room/RoomTest5.tscn"),
			"RoomTest6": load("res://src/Room/RoomTest6.tscn"),
		}
		Events.emit_signal("level_preload_finished")
		print_debug("preload is over")
		return