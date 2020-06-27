# Create input list by getting data from InputMap
extends ScrollContainer

const INPUT_LINE_SCENE: PackedScene = preload("res://src/UI/Options/Keybinding/InputLine.tscn")

onready var _inputLineContainer := $InputLineContainer


func _ready() -> void:
	owner.connect("navigation_finished", self, '_on_Navigation_finished')
	Events.connect("keybinding_resetted", self, 'initialize')
	initialize()


func initialize() -> void:
	# clean previous child
	if _inputLineContainer.get_child_count() > 0:
		for child in _inputLineContainer.get_children():
			child.queue_free()

	# add bind
	for action in Config.values["keybinding"]:
		var line = INPUT_LINE_SCENE.instance()
		line.initialize(action, Config.values["keybinding"][action])
		_inputLineContainer.add_child(line)


func _on_Navigation_finished() -> void:
	_inputLineContainer.get_child(0).get_node("Button").grab_focus()
