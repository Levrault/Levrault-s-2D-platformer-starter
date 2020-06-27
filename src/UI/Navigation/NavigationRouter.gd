# Manage go to previous history
class_name NavigationRouter
extends Control


func _ready() -> void:
	Menu.history.clear()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and Menu.history.size() > 0:
		Menu.navigate_to(Menu.history.pop_back())
