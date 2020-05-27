extends Control


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Events.emit_signal("menu_changed", Menu.history.pop_back())