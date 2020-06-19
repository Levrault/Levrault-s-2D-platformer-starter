extends Node2D

export var room_to_spawn := ''
var current_room


func _ready():
	Events.connect("level_preload_finished", self, "_on_Load_new_room", [room_to_spawn])
	Events.connect("gate_entered", self, "_on_Load_new_room")
	Level.load("test")


func _on_Load_new_room(id: String) -> void:
	print_debug(id)
	if current_room:
		current_room.queue_free()
	current_room = Level.rooms[id].instance()
	add_child(current_room)
