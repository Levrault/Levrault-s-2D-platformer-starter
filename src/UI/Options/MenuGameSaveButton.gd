# Find data to save inside the current menu (should by child or Contents)
extends MenuSaveButton


func _on_Pressed() -> void:
	._on_Pressed()
	Events.emit_signal("locale_changed", Config.values[section]["locale"])
