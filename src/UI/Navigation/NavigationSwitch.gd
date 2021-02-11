# Switch when a NavigationButton is click
class_name NavigationSwitch
extends Control

signal navigation_finished

export var default_field_to_focus: NodePath

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
	print("%s route has been set" % [id])


func _on_Transiton_mid_animated() -> void:
	if not _is_current_route:
		return

	visible = true
	if last_clicked_button:
		last_clicked_button.grab_focus()
	elif default_field_to_focus:
		get_node(default_field_to_focus).grab_focus()
	elif has_node("Wrapper/Page/Contents"):
		for container in $Wrapper/Page/Contents.get_children():
			for field in container.get_children():
				if field.is_in_group("GameSettings"):
					field.grab_focus()
					return

	emit_signal("navigation_finished")
	print("%s is now visible" % [get_name()])
