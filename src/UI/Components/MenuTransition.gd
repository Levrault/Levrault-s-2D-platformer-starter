extends Control


func _ready() -> void:
    Events.connect("transition_fade_played", $AnimationPlayer, "play", ["fade"])


