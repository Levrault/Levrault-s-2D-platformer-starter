extends MenuSaveButton

func _on_Pressed() -> void:
	var data := {}
	for input in owner.get_node("Page/Contents/InputList/InputLineContainer").get_children():
		Config.change_action_key(input.action_name, input.scancode)
		data[input.action_name] = input.scancode

	Config.values[section] = data
	Config.save(Config.values)
