# Control and manage when a cinematic is played
extends Node2D

var player: Player = null


func _ready() -> void:
	$Trigger.connect('body_entered', self, "_on_Player_entered")


func end() -> void:
	Events.emit_signal("cinematic_ended")
	player.is_handling_input = true
	queue_free()


func _on_Player_entered(body: Player) -> void:
	player = body
	player.is_handling_input = false
	Events.emit_signal("cinematic_started")
	$AnimationPlayer.play("start")
