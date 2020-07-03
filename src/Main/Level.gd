extends Node2D

export (String, "demo", "debug_portal", "debug_dialogue", "debug_cinematic", "debug_abilities", "debug_save_room") var to_load := "demo"
export var room_to_spawn := ''

var load_from_save := false
var current_room


func _ready():
	# default room or load from save?
	var first_room := room_to_spawn
	if RoomManager.to_load:
		first_room = RoomManager.to_load
		RoomManager.to_load = ""
	Events.connect("level_preload_finished", self, "_on_Load_new_room", [first_room])
	Events.connect("gate_entered", self, "_on_Load_new_room")
	Events.connect("portal_entered", self, "_on_Load_new_level")

	if LevelManager.to_load == "":
		LevelManager.to_load = to_load
	LevelManager.load(LevelManager.to_load)


func _on_Load_new_room(id: String) -> void:
	if current_room:
		current_room.queue_free()
		yield(current_room, "tree_exited")
	print(id)
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
