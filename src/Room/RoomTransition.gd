extends Control

onready var anim := $AnimationPlayer


func _ready() -> void:
	Events.connect("room_transition_started", self, "_on_Room_transition_started", ["started"])
	Events.connect("room_transition_ended", self, "_on_Room_transition_ended", ["ended"])


func _on_Room_transition_started(anim_name: String) -> void:
	anim.play(anim_name)


func _on_Room_transition_ended(anim_name: String) -> void:
	anim.play(anim_name)
