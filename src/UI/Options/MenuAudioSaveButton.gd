# Find data to save inside the current menu (should by child or Contents)
extends MenuSaveButton


func _get_new_volume(value: String) -> float:
	match value:
		"100":
			return 0.0
		"90":
			return -1.5
		"80":
			return -3.0
		"70":
			return -4.5
		"60":
			return -8.0
		"50":
			return -10.0
		"40":
			return -12.0
		"30":
			return -14.0
		"20":
			return -18.0
		"10":
			return -24.0

	return -60.0


func _on_Pressed() -> void:
	var data = ._get_fields()

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), _get_new_volume(data["master_volume"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), _get_new_volume(data["sfx_volume"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), _get_new_volume(data["music_volume"]))

	for field in data:
		Config.values[section][field] = data[field]

	# Config.values[section] = data
	Config.save(Config.values)
