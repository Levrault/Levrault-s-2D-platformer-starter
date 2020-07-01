extends Node2D

export (String, "test", "test2", "debug_dialogue", "debug_cinematic", "debug_abilities", "debug_save_room") var to_load := "test"
export var room_to_spawn := ''

var current_room


func _ready():
	Events.connect("level_preload_finished", self, "_on_Load_new_room", [room_to_spawn])
	Events.connect("gate_entered", self, "_on_Load_new_room")
	Events.connect("portal_entered", self, "_on_Load_new_level")

	if LevelManager.to_load == "":
		LevelManager.to_load = to_load

	LevelManager.load(LevelManager.to_load)


func _on_Load_new_room(id: String) -> void:
	if current_room:
		current_room.queue_free()
		yield(current_room, "tree_exited")
	current_room = LevelManager.rooms[id].instance()
	RoomManager.room_name = id
	call_deferred("add_child", current_room)


func _on_Load_new_level(level: String, room: String) -> void:
	if current_room:
		current_room.queue_free()
		yield(current_room, "tree_exited")
	LevelManager.load(level)
	current_room = LevelManager.rooms[room].instance()
	RoomManager.room_name = room
	call_deferred("add_child", current_room)
