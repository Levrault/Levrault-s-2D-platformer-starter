# Data carousel that use to be save inside config.cfg (@see Autoload/Config.gd)
# is_reverse_item and start_index (if no data has been saved) is used to easely change data order and default value
tool
extends HBoxContainer

export var key := ""
export var items := ["placeholder1", "placeholder2"]
export var start_index := 0
export var is_reverse_item := false
export var focus := false

var selected_value := "" setget _set_selected_value
var _carousel_index: int = 0
var _is_focused := false


# Init mouse/keyboard/controller navigation
# Set items display order
# Set default value if value weren't save inside config.cfg
# Set data if config.cfg's corresponding value exist
func _ready() -> void:
	connect("focus_entered", self, "_on_Focus_toggle", [true])
	connect("focus_exited", self, "_on_Focus_toggle", [false])
	$Previous.connect("pressed", self, "_on_Previous_value")
	$Next.connect("pressed", self, "_on_Next_value")

	# load from config file
	if not Engine.editor_hint:
		assert(key != "")
		if is_reverse_item:
			items.invert()
		self.selected_value = Config.config_to_field(key)
		var index := items.find(self.selected_value)
		if index != -1:
			_carousel_index = index
		else:
			_carousel_index = start_index
			self.selected_value = items[start_index]
	else:
		self.selected_value = items[0]


# Update on tool mode to first item
func _process(delta: float) -> void:
	if not Engine.editor_hint:
		return

	$Value.text = items[0]


# Catch keyboard/controller event when focused
# @param {InputEvent} event
func _gui_input(event: InputEvent) -> void:
	if not _is_focused:
		return

	if event.is_action_pressed("ui_left"):
		_on_Previous_value()
		return

	if event.is_action_pressed("ui_right"):
		_on_Next_value()
		return


# Display previous item
func _on_Previous_value() -> void:
	_carousel_index -= 1

	if _carousel_index < 0:
		_carousel_index = items.size() - 1

	self.selected_value = items[_carousel_index]


# Display next item
func _on_Next_value() -> void:
	_carousel_index += 1

	if _carousel_index >= items.size():
		_carousel_index = 0

	self.selected_value = items[_carousel_index]


# Set new selected value and update display item at the same time
# @param {String} text
func _set_selected_value(text: String) -> void:
	selected_value = text
	$Value.text = text


# Change focus
# @param {bool} is_focused
func _on_Focus_toggle(is_focused: bool) -> void:
	print("%s has focus" % [get_name()])
	_is_focused = is_focused

	# TODO: to remove when themed
	if is_focused:
		modulate = Color.red
	else:
		modulate = Color.white
