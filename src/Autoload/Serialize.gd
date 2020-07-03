# Load and save progression
extends Node

const DEBUG_SAVE := "debug1"
const PATH := "user://%s.save"
const DEFAULT_DATA := {"level": "test", "room": "Room1", "abilities": {}}
var profile := "profile1" setget set_profile
var _path := PATH % [profile]


func _ready() -> void:
	# force debug profile
	if ProjectSettings.get_setting("game/debug"):
		self.profile = DEBUG_SAVE

	if ProjectSettings.get_setting("game/load_save"):
		load_game(profile)


func set_profile(new_profile: String) -> void:
	print_debug(new_profile)
	profile = new_profile
	_path = PATH % [new_profile]


func save_game(data: Dictionary, should_send_signal: bool = true) -> void:
	var save_dict = {"level": data["level"], "room": data["room"], "abilities": data["abilities"]}
	var save_game = File.new()
	save_game.open(_path, File.WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()
	print_debug("%s has been saved" % [profile])

	if should_send_signal:
		Events.emit_signal("game_saved")


# is _path independent.
func load_game(selected_profile: String) -> Dictionary:
	var save = File.new()
	if not save.file_exists(_path):
		save_game(DEFAULT_DATA, false)
		print_debug("LOADING FAILED: create a new save data for %s" % [selected_profile])

	save.open(_path, File.READ)
	var data: Dictionary = parse_json(save.get_line())

	# load level
	if (
		profile != DEBUG_SAVE
		or (profile == DEBUG_SAVE and ProjectSettings.get_setting("game/load_level_from_save"))
	):
		print_debug("load level from save")
		RoomManager.to_load = data["room"]
		LevelManager.to_load = data["level"]
	else:
		LevelManager.to_load = ""
		RoomManager.room_name = ""
	# set abilities
	Game.unlocked_abilities = data["abilities"]

	save.close()
	print_debug("%s has been loaded" % [profile])
	return data
