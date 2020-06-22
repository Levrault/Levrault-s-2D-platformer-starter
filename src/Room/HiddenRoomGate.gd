tool
extends Area2D

enum DISPLAY { HORIZONTAL, VERTICAL }
export (DISPLAY) var facing = DISPLAY.VERTICAL setget set_facing

var _player_is_entering := false


func _ready() -> void:
	connect("body_entered", self, "_on_Body_entered")


func _on_Body_entered(body: Player) -> void:
	_player_is_entering = not _player_is_entering

	var bounds := {}
	if _player_is_entering:
		if has_node("BoundsNW"):
			bounds["limit_left"] = $BoundsNW.global_position.x
			bounds["limit_top"] = $BoundsNW.global_position.y
		if has_node("BoundsSE"):
			bounds["limit_right"] = $BoundsSE.global_position.x
			bounds["limit_bottom"] = $BoundsSE.global_position.y

		Events.emit_signal("room_limit_changed", bounds)
		return

	Events.emit_signal("room_limit_changed", RoomManager.bounds)


func set_facing(value) -> void:
	facing = value
	if value == DISPLAY.HORIZONTAL:
		rotation_degrees = 0
		return

	rotation_degrees = 90
