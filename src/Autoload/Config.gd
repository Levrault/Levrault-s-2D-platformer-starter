# Singleton that manage values save
# How to create a new config interface
#	- Add futur options to DEFAULT_VALUES
#	- Create a new inherited scene from OptionLayout
#	- Add content field
#	- Create a new script that extends MenuSaveButton
#	- Manage save
#	- Add new field inside config_to_field func
extends Node

const CONFIG_FILE_PATH := "user://config.cfg"
const DEFAULT_VALUES := {
	"game": {"locale": "en"},
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
		"master_volume": "100",
		"music_volume": "100",
		"sfx_volume": "100",
	},
	"keybinding":
	{
		"move_up": 87,
		"move_down": 83,
		"move_left": 65,
		"move_right": 68,
		"jump": 32,
		"attack": 69,
		"dash": 70,
	}
}

var _config_file := ConfigFile.new()
var values := DEFAULT_VALUES.duplicate(true)


# Find and load config.cfg file
# If not, create a new config file with default value
func _init() -> void:
	print_debug(DEFAULT_VALUES["keybinding"])
	var err = _config_file.load(CONFIG_FILE_PATH)
	if err == ERR_FILE_NOT_FOUND:
		print_debug("%s was not found, create a new file with default values" % [CONFIG_FILE_PATH])
		self.save(DEFAULT_VALUES)
		self.load()
		return
	if err != OK:
		print_debug("%s has encounter an error: %s" % [CONFIG_FILE_PATH, err])
		return
	self.load()


# Dumb way to convert db value to int
# @param {String} value
# @returns {float}
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


# Save data
# @param {Dictionary} new data - see DEFAULT_VALUES from struc
func save(new_settings: Dictionary) -> void:
	for section in new_settings.keys():
		for key in new_settings[section]:
			_config_file.set_value(section, key, new_settings[section][key])

	_config_file.save(CONFIG_FILE_PATH)

	Events.emit_signal("notification_started", "ui_data_saved", Vector2(460, 40))


# Load data from config.cfg
func load() -> void:
	for section in values.keys():
		for key in values[section]:
			values[section][key] = _config_file.get_value(
				section, key, DEFAULT_VALUES[section][key]
			)

	print_debug("%s has been loaded" % [CONFIG_FILE_PATH])
	self.applied_config("all")


func applied_config(section: String) -> void:
	if section == "all" or section == "display":
		# display
		OS.vsync_enabled = values["display"]["use_vsync"]
		OS.window_size = Vector2(values["display"]["width"], values["display"]["height"])
		OS.window_fullscreen = values["display"]["fullscreen"]
		OS.window_borderless = values["display"]["borderless"]
		OS.center_window()

	# audio
	if section == "all" or section == "audio":
		AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index("Master"), _get_new_volume(values["audio"]["master_volume"])
		)
		AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index("Sfx"), _get_new_volume(values["audio"]["sfx_volume"])
		)
		AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index("Music"), _get_new_volume(values["audio"]["music_volume"])
		)

	# game
	if section == "all" or section == "game":
		TranslationServer.set_locale(values["game"]["locale"])

	# keybinding
	if section == "all" or section == "keybinding":
		for action in values["keybinding"]:
			if not values["keybinding"].has(action):
				var keycode: InputEventKey = null
				for input in InputMap.get_action_list(action):
					if not keycode and input is InputEventKey:
						values["keybinding"][action] = input.scancode
			else:
				change_action_key(action, values["keybinding"][action])

	if section == "all" or section == "controller":
		#TODO: controller
		pass


# Update an action InputMap
# @param {String} action_name
# @param {int} scancode
func change_action_key(action_name: String, scancode: int) -> void:
	erase_action_events(action_name)

	var new_event = InputEventKey.new()
	new_event.set_scancode(scancode)
	InputMap.action_add_event(action_name, new_event)


# Delete an action from InputMap
# @param {String} action_name
func erase_action_events(action_name: String) -> void:
	var input_events = InputMap.get_action_list(action_name)
	for event in input_events:
		if event is InputEventKey:
			InputMap.action_erase_event(action_name, event)


# Convert config's data to readable string for the interface
# e.g.
#  Resolution is a concatenation of config.display.width + x + config.display.height
# @param {String} key - key used in interface
# @return {String} config data
func config_to_field(key: String) -> String:
	if key == "use_vsync":
		return "cfg_yes" if values["display"]["use_vsync"] else "cfg_no"

	if key == "resolution":
		return String(values["display"]["width"]) + "x" + String(values["display"]["height"])

	if key == "display_mode":
		if values["display"]["fullscreen"] and not values["display"]["borderless"]:
			return "cfg_fullscreen"
		if not values["display"]["fullscreen"] and values["display"]["borderless"]:
			return "cfg_borderless"
		if not values["display"]["fullscreen"] and not values["display"]["borderless"]:
			return "cfg_windowed"

	if key == "music_volume":
		return values["audio"]["music_volume"]

	if key == "master_volume":
		return values["audio"]["master_volume"]

	if key == "sfx_volume":
		return values["audio"]["sfx_volume"]

	if key == "locale":
		return values["game"]["locale"]

	return ""
