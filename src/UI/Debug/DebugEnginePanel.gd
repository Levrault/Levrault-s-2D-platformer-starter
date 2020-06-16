extends PanelContainer


onready var time_scale: Label = $VBoxContainer/VBoxContainer/HBoxContainer/TimeScale

func _process(delta) -> void:
	time_scale.text = String(Engine.time_scale)
