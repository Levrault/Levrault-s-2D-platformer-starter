extends Control

export (String, "profile1", "profile2", "profile3") var selected_profile = "profile1"

onready var button := $Wrapper/Button


func _ready() -> void:
	button.connect("pressed", self, "_on_Button_pressed")

	# has save?
	var save_game = File.new()
	if not save_game.file_exists(Serialize.PATH % [selected_profile]):
		button.text = tr("ui_new_game")
		print_debug("%s is has no associated savefile" % [selected_profile])
		return

	var data := Serialize.quick_read(selected_profile)
	print(data)
	button.text = "%s - %s" % [tr(data["level"]), tr(data["room"])]


func _on_Button_pressed() -> void:
	Serialize.profile = selected_profile
	Serialize.load_game(selected_profile)
	get_tree().change_scene("res://src/Main/Game.tscn")
