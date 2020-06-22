extends Node2D

export var to_load := ''
export var room_to_spawn := ''
var current_room


func _ready():
	Events.connect("level_preload_finished", self, "_on_Load_new_room", [room_to_spawn])
	Events.connect("gate_entered", self, "_on_Load_new_room")
	LevelLoader.load(to_load)


func _on_Load_new_room(id: String) -> void:
	if current_room:
		current_room.queue_free()
		yield(current_room, "tree_exited")
	current_room = LevelLoader.rooms[id].instance()
	call_deferred("add_child", current_room)
