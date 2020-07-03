# Find data to save inside the current menu (should by child or Contents)
class_name MenuSaveButton
extends Button

export var section := ""

onready var _fields_container := owner.find_node("Contents").get_children()


# Connect pressed event
func _ready() -> void:
	connect("pressed", self, "_on_Pressed")
	assert(section != "")


# Get all field
# @returns {Dictionary}
func _get_fields() -> Dictionary:
	var data := {}
	for container in _fields_container:
		for field in container.get_children():
			if field.is_in_group("GameSettings"):
				data[field.key] = field.selected_value
	return data


# Match field to config value
func _on_Pressed() -> void:
	print(_get_fields())
	Config.values[section] = _get_fields()
	Config.applied_config(section)
	Config.save(Config.values)
