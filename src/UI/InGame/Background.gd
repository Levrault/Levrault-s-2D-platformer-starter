extends ColorRect


func _ready() -> void:
	Events.connect("game_paused", self, "_on_Game_paused")
	visible = false


func _on_Game_paused() -> void:
	visible = true
