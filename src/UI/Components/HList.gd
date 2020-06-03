tool
extends HBoxContainer

export var key := ""
export var items := ["placeholder1", "placeholder2"]
export var focus := false

var selected_value := "" setget _set_selected_value
var _carousel_index: int = 0
var _is_focused := false


func _ready() -> void:
	connect("focus_entered", self, "_on_Focus_toggle", [true])
	connect("focus_exited", self, "_on_Focus_toggle", [false])
	$Previous.connect("pressed", self, "_on_Previous_value")
	$Next.connect("pressed", self, "_on_Next_value")

	# load from config file
	if not Engine.editor_hint:
		assert(key != "")
		self.selected_value = Config.config_to_field(key)
		_carousel_index = items.find(self.selected_value)
	else:
		self.selected_value = items[0]


func _process(delta: float) -> void:
	if not Engine.editor_hint:
		return
	$Value.text = items[0]


func _gui_input(event: InputEvent) -> void:
	if not _is_focused:
		return

	if event.is_action_pressed("ui_left"):
		_on_Previous_value()
		return

	if event.is_action_pressed("ui_right"):
		_on_Next_value()
		return


func _on_Previous_value() -> void:
	_carousel_index -= 1

	if _carousel_index < 0:
		_carousel_index = items.size() - 1

	self.selected_value = items[_carousel_index]


func _on_Next_value() -> void:
	_carousel_index += 1

	if _carousel_index >= items.size():
		_carousel_index = 0

	self.selected_value = items[_carousel_index]


func _set_selected_value(text: String) -> void:
	selected_value = text
	$Value.text = text


func _on_Focus_toggle(is_focused: bool) -> void:
	print("%s has focus" % [get_name()])
	_is_focused = is_focused

	# TODO: to remove when themed
	if is_focused:
		modulate = Color.red
	else:
		modulate = Color.white
