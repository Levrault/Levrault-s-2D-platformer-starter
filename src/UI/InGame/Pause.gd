# Switch when a NavigationButton is click
extends NavigationSwitch


func _ready() -> void:
	Events.connect("game_paused", self, "_on_Game_paused")


func _on_Game_paused() -> void:
	get_node(default_field_to_focus).grab_focus()