extends Button


func _ready() -> void:
	connect("pressed", self, "_on_Pressed")


func _on_Pressed() -> void:
	Config.values["keybinding"] = Config.DEFAULT_VALUES["keybinding"]
	Config.save(Config.values)
	Events.emit_signal("keybinding_resetted")
