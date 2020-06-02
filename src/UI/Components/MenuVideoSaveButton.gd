# Find data to save inside the current menu (should by child or Contents)
extends MenuSaveButton


func _on_Pressed() -> void:
	var data = ._get_fields()

	if data.has("use_vsync"):
		# TODO: translate yes
		data["use_vsync"] = (data["use_vsync"] == "yes")

		OS.vsync_enabled = data["use_vsync"]

	if data.has("resolution"):
		var resolution = data["resolution"].split("x", false)
		data["width"] = resolution[0]
		data["height"] = resolution[1]
		data.erase("resolution")

		OS.window_size = Vector2(data["width"], data["height"])
		OS.center_window()

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

		OS.window_fullscreen = data["fullscreen"]
		OS.window_borderless = data["borderless"]
		OS.center_window()

	Config.values[section] = data
	Config.save(Config.values)
