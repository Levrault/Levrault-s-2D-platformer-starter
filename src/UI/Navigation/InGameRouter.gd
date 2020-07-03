# Pause In game interface
extends NavigationRouter


func _ready() -> void:
	Events.connect("game_unpaused", self, "_on_Game_unpaused")
	visible = false


# Listen to pause input.
# @param {InputEvent} event
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and Menu.history.empty():
		visible = not visible
		get_tree().paused = visible
		Events.emit_signal("game_paused")

		return


func _on_Game_unpaused() -> void:
	visible = not visible
	get_tree().paused = visible
