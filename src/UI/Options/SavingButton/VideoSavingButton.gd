# Find data to save inside the current menu (should by child or Contents)
extends MenuSaveButton

const Collection: Script = preload("res://src/Utils/Collection.gd")


func _on_Pressed() -> void:
	var data = ._get_fields()

	if data.has("use_vsync"):
		print(data["use_vsync"])
		data["use_vsync"] = (data["use_vsync"] == "cfg_yes")

	if data.has("resolution"):
		var resolution = data["resolution"].split("x", false)
		data["width"] = resolution[0]
		data["height"] = resolution[1]
		data.erase("resolution")

	if data.has("display_mode"):
		match data["display_mode"]:
			"cfg_fullscreen":
				data["fullscreen"] = true
				data["borderless"] = false
			"cfg_borderless":
				data["fullscreen"] = false
				data["borderless"] = true
			"cfg_windowed":
				data["fullscreen"] = false
				data["borderless"] = false

		data.erase("window_mode")

	Config.values[section] = Collection.merge(Config.values[section], data)
	Config.applied_config(section)
	Config.save(Config.values)
