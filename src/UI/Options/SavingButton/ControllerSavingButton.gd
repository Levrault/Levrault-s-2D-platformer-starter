# Find data to save inside the current menu (should by child or Contents)
extends MenuSaveButton


func _on_Pressed() -> void:
	var data = ._get_fields()

	if data.has("rumble"):
		data["rumble"] = (data["rumble"] == "cfg_yes")

	Config.values[section] = data
	Config.applied_config(section)
	Config.save(Config.values)
