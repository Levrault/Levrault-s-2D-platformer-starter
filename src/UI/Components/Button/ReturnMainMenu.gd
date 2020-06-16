extends Button

func _ready():
	connect("pressed", self, "_on_Pressed")


func _on_Pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene("res://src/UI/MainMenu.tscn")