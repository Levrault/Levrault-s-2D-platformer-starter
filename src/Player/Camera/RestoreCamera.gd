extends Area2D


func _ready():
	connect("body_entered", self, "_on_Body_entered")


func _on_Body_entered(body: Player) -> void:
	Events.emit_signal("camera_limits_restored")
	Events.emit_signal("camera_zoom_restored")


