extends Control

export (String, "profile1", "profile2", "profile3") var selected_profile = "profile1"

onready var button := $Wrapper/Button


func _ready() -> void:
	button.connect("pressed", self, "_on_Button_pressed")


func _on_Button_pressed() -> void:
	Serialize.profile = selected_profile
	Serialize.load_game(selected_profile)
	get_tree().change_scene("res://src/Main/Game.tscn")
