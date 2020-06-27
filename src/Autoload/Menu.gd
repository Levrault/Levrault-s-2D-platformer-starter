# Manage menu navigation
extends Node

var history := []


# @param {String} to - menu to navigate to
# @param {String} transition - transition to play
func navigate_to(to: String, transition: String = "fade") -> void:
	Events.emit_signal("menu_route_changed", to)
	Events.emit_signal("transition_started", transition)
