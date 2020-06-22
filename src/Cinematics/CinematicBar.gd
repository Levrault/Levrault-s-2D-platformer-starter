extends Control


func _ready() -> void:
	Events.connect("cinematic_started", $AnimationPlayer, "play", ["start"])
	Events.connect("cinematic_ended", $AnimationPlayer, "play_backwards", ["start"])
