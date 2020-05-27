# Switch when a NavigationButton is click
extends Control

var last_clicked_button: Button = null
var buttons := []

func _ready() -> void:
	Events.connect("menu_changed", self, "_on_Menu_changed")


func _on_Menu_changed(id: String) -> void:
	if id != get_name():
		visible = false
		return

	visible = true
	if last_clicked_button:
		last_clicked_button.grab_focus()
	print("%s is now visible" % [id])


