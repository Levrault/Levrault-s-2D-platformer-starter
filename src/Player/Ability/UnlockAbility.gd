extends Area2D

export (String, "dash", "double_jump") var ability_to_unlock = "dash"

onready var dialogue_controller: DialogueController = $DialogueController as DialogueController


func _ready() -> void:
	if Game.unlocked_abilities.has(ability_to_unlock):
		queue_free()
	connect("body_entered", self, "_on_Player_entered")


func _on_Player_entered(body: Player) -> void:
	body.unlock_ability(ability_to_unlock)
	dialogue_controller.load()
	dialogue_controller.start()
	dialogue_controller.clear()
	queue_free()
