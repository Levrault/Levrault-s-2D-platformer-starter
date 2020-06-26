# Detect NPC and manage interactions the player can 
# have with them
extends Node2D

enum STATE { pending, continuing, choosing, ending }

var _npc: Npc = null
var _state = STATE.pending


# Init detect zone and linh change state to the dialogueBox
func _ready() -> void:
	Events.connect("dialogue_last_text_displayed", self, "_on_State_changed", [STATE.ending])
	Events.connect("dialogue_text_displayed", self, "_on_State_changed", [STATE.continuing])
	Events.connect("dialogue_choices_displayed", self, "_on_State_changed", [STATE.choosing])
	$DetectNpc.connect("body_entered", self, "_on_Npc_entered")
	$DetectNpc.connect("body_exited", self, "_on_Npc_exited")
	set_process_unhandled_input(false)


# Start, skip, end dialogue
func _unhandled_input(event: InputEvent) -> void:
	if _state == STATE.choosing:
		return

	if event.is_action_pressed("interaction"):
		# last dialogue/interaction was displayed, end the interaction
		if _state == STATE.ending:
			owner.is_handling_input = true
			_npc.is_in_interaction = false
			_state = STATE.pending
			Events.emit_signal("dialogue_finished")
			return

		# interaction with npc has begun
		if not _npc.is_in_interaction:
			owner.is_handling_input = false
			_npc.is_in_interaction = true
			return

		if _state == STATE.continuing:
			_npc.next_interaction()
			_state = STATE.pending
			return

		# call next interaction
		Events.emit_signal("dialogue_animation_skipped")


# Is possible to interact with the npc
# @param {Npc} body
func _on_Npc_entered(body: Npc) -> void:
	set_process_unhandled_input(true)
	_npc = body
	_npc.is_interactable = true


# Is no longer possible to interact with the npc
# @param {Npc} body
func _on_Npc_exited(body: Node) -> void:
	body.is_interactable = false
	set_process_unhandled_input(false)
	_npc = null


# Change Npc's interaction state
# @param {int} value - should be valid State's enum value
func _on_State_changed(value: int) -> void:
	_state = value
