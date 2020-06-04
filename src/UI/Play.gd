extends Button


func _ready() -> void:
	connect("pressed", self, "_on_Pressed")


func _on_Pressed() -> void:
	get_tree().change_scene("res://src/Main/Game.tscn")
