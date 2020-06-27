# Input line show/manage the current input
class_name InputLine
extends HBoxContainer

var action_name := ""
var scancode := 0


func _ready() -> void:
	$Button.connect("pressed", self, "_on_Change_button_bressed")


func initialize(new_action_name: String, new_scancode: int) -> void:
	action_name = new_action_name
	scancode = new_scancode
	$Action.text = tr("cfg_" + action_name)
	$Button.text = OS.get_scancode_string(scancode)


func _on_Change_button_bressed() -> void:
	Events.emit_signal("keybinding_started", scancode)
	Events.connect("keybinding_key_selected", self, "_on_Keybinding_key_selected")
	Events.connect("keybinding_canceled", self, "_on_Keybinding_canceled")
	$Button.release_focus()


func _on_Keybinding_key_selected(new_scancode: int) -> void:
	scancode = new_scancode
	$Button.text = OS.get_scancode_string(scancode)
	$Button.grab_focus()
	accept_event()
	_on_Keybinding_canceled()


func _on_Keybinding_canceled() -> void:
	Events.disconnect("keybinding_key_selected", self, "_on_Keybinding_key_selected")
	Events.disconnect("keybinding_canceled", self, "_on_Keybinding_canceled")
