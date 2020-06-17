extends Area2D

export var should_change_zoom := false
export var zoom := Vector2(1, 1)

var _previous_limits := {}
var _previous_zoom := Vector2.ZERO


func _ready():
	connect("body_entered", self, "_on_Body_entered")


func _on_Body_entered(body: Player) -> void:
	print("in")
	var limits := {}

	if has_node("Left"):
		limits["limit_left"] = $Left.global_position.x
		_previous_limits["limit_left"] = body.camera.limit_left
	if has_node("Right"):
		limits["limit_right"] = $Right.global_position.x
		_previous_limits["limit_right"] = body.camera.limit_right
	if has_node("Bottom"):
		limits["limit_bottom"] = $Bottom.global_position.y
		_previous_limits["limit_bottom"] = body.camera.limit_bottom
	if has_node("Top"):
		limits["limit_top"] = $Top.global_position.y
		_previous_limits["limit_top"] = body.camera.limit_top

	Events.emit_signal("camera_limits_changed", limits)
	if should_change_zoom:
		_previous_zoom = body.camera.zoom
		Events.emit_signal("camera_zoom_changed", zoom, .25)
