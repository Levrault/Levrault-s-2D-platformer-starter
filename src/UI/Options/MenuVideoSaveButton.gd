# Find data to save inside the current menu (should by child or Contents)
extends MenuSaveButton


func _on_Pressed() -> void:
	var data = ._get_fields()

	if data.has("use_vsync"):
		# TODO: translate yes
		data["use_vsync"] = (data["use_vsync"] == "yes")

	if data.has("resolution"):
		var resolution = data["resolution"].split("x", false)
		data["width"] = resolution[0]
		data["height"] = resolution[1]
		data.erase("resolution")

	if data.has("window_mode"):
		match data["window_mode"]:
			"fullscreen":
				data["fullscreen"] = true
				data["borderless"] = false
			"borderless":
				data["fullscreen"] = false
				data["borderless"] = true
			"windowed":
				data["fullscreen"] = false
				data["borderless"] = false

		data.erase("window_mode")

	Config.values[section] = data
	Config.applied_config(section)
	Config.save(Config.values)
