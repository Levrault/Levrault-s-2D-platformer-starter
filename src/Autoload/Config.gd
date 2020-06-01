# Singleton that manage values save
extends Node

const CONFIG_FILE_PATH := "res://config.cfg"
const DEFAULT_VALUES := {
	"game": {"locale": "en", "difficulty": "normal"},
	"display":
	{
		"use_vsync": true,
		"fullscreen": false,
		"resizable": true,
		"borderless": false,
		"width": 960,
		"height": 540,
	},
	"engine":
	{
		"use_pixel_snap": true,
		"strech_mode": "2D",
	},
	"audio":
	{
		"master": 100,
		"music": 100,
	}
}

var _config_file := ConfigFile.new()
var values := DEFAULT_VALUES


func _init() -> void:
	var err = _config_file.load(CONFIG_FILE_PATH)
	if err == ERR_FILE_NOT_FOUND:
		print_debug("%s was not found, create a new file with default values" % [CONFIG_FILE_PATH])
		save(DEFAULT_VALUES)
		self.load()
		return
	if err != OK:
		print_debug("%s has encounter an error: %s" % [CONFIG_FILE_PATH, err])
		return
	self.load()


func save(new_settings: Dictionary) -> void:
	for section in new_settings.keys():
		for key in new_settings[section]:
			_config_file.set_value(section, key, new_settings[section][key])

	_config_file.save(CONFIG_FILE_PATH)


func load() -> void:
	for section in values.keys():
		for key in values[section]:
			values[section][key] = _config_file.get_value(
				section, key, DEFAULT_VALUES[section][key]
			)

	print_debug("%s has been loaded" % [CONFIG_FILE_PATH])
	print(values)


func config_to_field(key: String) -> String:
	if key == "use_vsync":
		# TODO: manage translation?
		return "yes" if values["display"]["use_vsync"] else "no"

	if key == "resolution":
		return values["display"]["width"] + "x" + values["display"]["height"]

	if key == "window_mode":
		if values["display"]["fullscreen"] and not values["display"]["borderless"]:
			return "fullscreen"
		if not values["display"]["fullscreen"] and values["display"]["borderless"]:
			return "borderless"
		if not values["display"]["fullscreen"] and not values["display"]["borderless"]:
			return "windowed"

	return ''
