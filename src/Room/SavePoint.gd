# Save player progression
extends Node2D
class_name SavePoint

var is_interactable := false setget set_is_interactable
var is_saving := false setget set_is_saving
var player: Player = null


func _ready() -> void:
	Events.connect("game_saved", self, "_on_Saved_successfull")


func set_is_interactable(value: bool) -> void:
	is_interactable = value
	if value:
		$Label.show()
	else:
		$Label.hide()


func set_is_saving(value: bool) -> void:
	is_saving = value
	$AnimationPlayer.play("start")


func save() -> void:
	Serialize.save_game(
		{
			abilities = player.abilities,
			level = LevelManager.level_name,
			room = RoomManager.room_name
		}
	)


func _on_Saved_successfull() -> void:
	Events.emit_signal("notification_started", "ui_save_progress")
	$AnimationPlayer.play_backwards("start")
