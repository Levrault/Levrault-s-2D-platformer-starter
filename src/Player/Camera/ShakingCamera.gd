# Shakes the screen when is_shaking is set to true
# To make it react to events happening in the game world, use the Events signal routing singleton
# Uses different smoothing values depending on the active controller
tool
extends Camera2D

export var amplitude = 4.0
export var duration = 0.3 setget set_duration
export var DAMP_EASING = 1.0
export var is_shaking = false setget set_is_shaking
export var default_smoothing_speed := {mouse = 3, gamepad = 1}

enum States { IDLE, SHAKING }
var state = States.IDLE

onready var timer = $Timer
onready var tween := $Tween


func _ready() -> void:
	Events.connect("camera_limits_changed", self, "_on_Camera_limits_changed")
	Events.connect("camera_zoom_changed", self, "_on_Camera_zoom_changed")
	Events.connect(
		"camera_limits_restored",
		self,
		"_on_Camera_limits_changed",
		[
			{
				limit_top = self.limit_top,
				limit_right = self.limit_right,
				limit_bottom = self.limit_bottom,
				limit_left = self.limit_left
			}
		]
	)
	Events.connect("camera_zoom_restored", self, "_on_Camera_zoom_changed", [self.zoom, .5])
	timer.connect("timeout", self, "_on_ShakeTimer_timeout")

	self.duration = duration
	set_process(false)


func _process(delta) -> void:
	var damping = ease(timer.time_left / timer.wait_time, DAMP_EASING)
	offset = Vector2(
		rand_range(amplitude, -amplitude) * damping, rand_range(amplitude, -amplitude) * damping
	)


func _get_configuration_warning() -> String:
	return "" if $Timer else "%s requires a Timer child named Timer" % name


func _on_Camera_limits_changed(limits: Dictionary) -> void:
	for key in limits:
		self[key] = limits[key]
	print_debug("Camera: limit has been changed")


func _on_Camera_zoom_changed(zoom: Vector2, zoom_duration: float) -> void:
	tween.interpolate_property(
		self, "zoom", self.zoom, zoom, zoom_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()
	print_debug("Camera: zoom has been changed")


func _change_state(new_state: int) -> void:
	match new_state:
		States.IDLE:
			offset = Vector2()
			set_process(false)
		States.SHAKING:
			set_process(true)
			timer.start()
	state = new_state


func _on_ShakeTimer_timeout() -> void:
	self.is_shaking = false


func set_duration(value: float) -> void:
	duration = value
	if timer:
		timer.wait_time = duration


func set_is_shaking(value: bool) -> void:
	is_shaking = value
	if is_shaking:
		_change_state(States.SHAKING)
	else:
		_change_state(States.IDLE)
