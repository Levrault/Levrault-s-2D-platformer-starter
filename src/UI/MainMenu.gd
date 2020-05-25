extends Control


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        Menu.navigate_to(Menu.history.pop_back())
