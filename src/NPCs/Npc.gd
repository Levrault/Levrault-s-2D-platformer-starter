# Non playable character
tool
class_name Npc
extends KinematicBody2D

export var conditions := {}
export var is_auto_trigger := false

var is_interactable := false setget set_is_interactable
var is_in_interaction := false setget set_is_in_interaction

onready var dialogue_controller: DialogueController = $DialogueController as DialogueController


# Set if the npc needs to listen the player's input
# @param {bool} value
func set_is_interactable(value: bool) -> void:
	is_interactable = value
	$Talk.visible = value


# Listent to the player's input until the NPC leave the interaction state
# When it's happen, all the dialogue tree is cleaned
# @param {bool} value
func set_is_in_interaction(value: bool) -> void:
	is_in_interaction = value
	if value:
		dialogue_controller.load()
		dialogue_controller.start()
	else:
		dialogue_controller.clear()


# If the npc is still listening the player's input, it will check for the possible next dialogue
# @param {bool} value
func next_interaction() -> void:
	dialogue_controller.next()


# Is used when the npc is displayed on a cinematic
func cinematic_close_dialogue() -> void:
	self.is_in_interaction = false
	Events.emit_signal("dialogue_finished")
