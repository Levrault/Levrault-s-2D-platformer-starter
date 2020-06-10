extends MenuSaveButton


func _on_Pressed() -> void:
	var data := {}
	var container := owner.get_node("Wrapper/Page/Contents/InputList/InputLineContainer")
	for input in container.get_children():
		Config.change_action_key(input.action_name, input.scancode)
		data[input.action_name] = input.scancode

	Config.values[section] = data
	Config.save(Config.values)
