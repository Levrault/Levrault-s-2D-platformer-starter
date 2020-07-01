# Detect save zone and manage player's behavior when
# interacting with them
extends Node2D

var _save_point: SavePoint = null


func _ready() -> void:
	Events.connect("game_saved", self, "_on_Saved_successfull")
	$DetectSavePoint.connect("area_entered", self, "_on_SavePoint_entered")
	$DetectSavePoint.connect("area_exited", self, "_on_SavePoint_exited")
	set_process_unhandled_input(false)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interaction") and not _save_point.is_saving:
		owner.is_handling_input = false
		_save_point.player = owner
		_save_point.is_saving = true
		return


func _on_SavePoint_entered(body: SavePoint) -> void:
	set_process_unhandled_input(true)
	_save_point = body
	_save_point.is_interactable = true


func _on_SavePoint_exited(body: SavePoint) -> void:
	_save_point.is_interactable = false
	set_process_unhandled_input(false)
	_save_point = null


func _on_Saved_successfull() -> void:
	owner.is_handling_input = true
	_save_point.is_saving = false
