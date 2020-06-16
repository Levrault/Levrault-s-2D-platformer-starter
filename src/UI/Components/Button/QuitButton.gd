# Quit application
extends Button


func _ready() -> void:
	connect("pressed", self, "_on_Pressed")


func _on_Pressed() -> void:
    get_tree().quit()
