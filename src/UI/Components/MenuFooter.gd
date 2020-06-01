# Only display controller or keyboard input when navigate
# through menu
tool
extends HBoxContainer

export var has_back_action := true

func _ready() -> void:
	$MenuBackInput.visible = has_back_action


func _process(delta: float) -> void:
	if not Engine.editor_hint:
		return

	$MenuBackInput.visible = has_back_action
