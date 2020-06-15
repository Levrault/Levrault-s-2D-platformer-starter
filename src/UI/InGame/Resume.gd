extends Button

func _ready():
	connect("pressed", self, "_on_Pressed")


func _on_Pressed() -> void:
	Events.emit_signal("game_unpaused")