# Switch when a NavigationButton is click
extends Control

var last_clicked_button: Button = null
var buttons := []
var _is_current_route := false


func _ready() -> void:
	Events.connect("menu_route_changed", self, "_on_Menu_route_changed")
	Events.connect("transition_mid_animated", self, "_on_Transiton_mid_animated")


func _on_Menu_route_changed(id: String) -> void:
	if id != get_name():
		visible = false
		_is_current_route = false
		return

	_is_current_route = true
	print(_is_current_route)
	print("%s route has been set" % [id])


func _on_Transiton_mid_animated() -> void:
	if not _is_current_route:
		return

	visible = true
	if last_clicked_button:
		last_clicked_button.grab_focus()

	print("%s is now visible" % [get_name()])
