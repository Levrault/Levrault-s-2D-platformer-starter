# Find data to save inside the current menu (should by child or Contents)
extends MenuSaveButton


func _on_Pressed() -> void:
	var data = ._get_fields()

	for field in data:
		Config.values[section][field] = data[field]

	Config.applied_config(section)
	Config.save(Config.values)
