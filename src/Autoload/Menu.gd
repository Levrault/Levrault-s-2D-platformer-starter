extends Node

var history := []


func navigate_to(to: String) -> void:
	Events.emit_signal("transition_fade_played")
	Events.emit_signal("menu_changed", to)