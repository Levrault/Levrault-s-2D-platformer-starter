# Add a new keybinding to the game
# - If the same key is used, no error are trigger, nothing change
# - If a new key is used, we check if the key is already use on for another action
# - Track of new key are used inside a array that is updated after each new binding
extends Control

var existing_keys := []
var _scancode_to_change := 0


func _ready() -> void:
	Events.connect("keybinding_started", self, "_on_Keybinding_started")
	Events.connect("keybinding_resetted", self, "_on_Keybinding_resetted")
	for action in Config.values["keybinding"]:
		for input in InputMap.get_action_list(action):
			if input is InputEventKey:
				existing_keys.append(input.scancode)
	_close()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Events.emit_signal("keybinding_canceled")
		_close()
		return

	if not event.is_pressed() or event is InputEventMouseButton:
		return

	if _scancode_to_change != event.scancode and _key_is_already_mapped(event.scancode):
		_duplicate_key_error()
		return

	Events.emit_signal("keybinding_key_selected", event.scancode)
	existing_keys.erase(_scancode_to_change)
	existing_keys.append(event.scancode)
	_close()


func focus() -> void:
	$Button.grab_focus()


func _key_is_already_mapped(new_scancode: int) -> bool:
	return existing_keys.find(new_scancode) != -1


func _duplicate_key_error() -> void:
	$CenterContainer/Label.hide()
	$CenterContainer/Error.show()


func _on_Keybinding_started(previous_scancode) -> void:
	_scancode_to_change = previous_scancode
	set_process_input(true)
	show()
	$CenterContainer/Error.hide()
	$CenterContainer/Label.show()


func _on_Keybinding_resetted() -> void:
	_scancode_to_change = 0
	existing_keys.clear()


func _close() -> void:
	set_process_input(false)
	hide()

