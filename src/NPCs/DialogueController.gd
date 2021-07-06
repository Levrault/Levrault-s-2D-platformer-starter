# Owner dependant
# Read associated dialogue json file to NPC
# Based on NPC name
# Order and manage which dialogue is send to DialogueBox
class_name DialogueController
extends Node2D

const JsonReader: Script = preload("res://src/Utils/JsonReader.gd")

var _portraits_res := {}
var _dialogues := {}
var _conditions := {}
var _current_dialogue := {}

onready var dialogue_json: Dictionary = JsonReader.get_json(
	"res://assets/dialogues/%s.json" % [owner.get_name()]
)


# preload all portrait resources into memory
func _ready() -> void:
	_load_portrait_in_memory()


func start() -> void:
	Events.emit_signal("dialogue_started")
	owner.set_process_unhandled_input(false)
	_current_dialogue = get_next(dialogue_json.root)
	change()


# Load dialogue
func load() -> void:
	_conditions = owner.conditions if owner.get("conditions") else {}


# Send dialogue based on locale to the dialogueBox
func next() -> void:
	_current_dialogue = get_next(_current_dialogue)
	change()


# show next interactions
func change() -> void:
	var text: String = _current_dialogue["text"][TranslationServer.get_locale()]
	Events.emit_signal(
		"dialogue_changed",
		_current_dialogue["name"],
		_portraits_res[_current_dialogue["portrait"]],
		text
	)

	if _current_dialogue.has("signals"):
		_emit_dialogue_signal(_current_dialogue["signals"])

	# player can make some choice
	if _current_dialogue.has("choices"):
		var conditions: Array = (
			_current_dialogue.get("conditions")
			if _current_dialogue.has("conditions")
			else []
		)
		Events.emit_signal(
			"dialogue_choices_changed", get_choices(_current_dialogue.choices, conditions)
		)
		Events.connect("dialogue_choices_finished", self, "_on_Choices_finished")
		return

	# there is not linked dialogue
	if not _current_dialogue.has("conditions") and not _current_dialogue.get("next"):
		Events.emit_signal("dialogue_last_dialogue_displayed")
		clear()


# clear controller
func clear() -> void:
	_dialogues = {}
	_current_dialogue = {}
	_conditions = {}


func get_next(node: Dictionary) -> Dictionary:
	if node.has("next"):
		return dialogue_json[node.next]

	var next := ""
	var default_next := ""
	if node.has("conditions"):
		var conditions = node.conditions.duplicate(true)
		var matching_condition := 0

		for condition in conditions:
			var predicated_next: String = condition.next
			condition.erase("next")

			if condition.empty():
				default_next = predicated_next

			# partial matching
			var current_matching_condition := 0
			for key in condition:
				if _conditions.has(key):
					# conditions will never match
					if _conditions.size() < condition.size():
						continue

					if condition.empty():
						default_next = predicated_next

					if _check_conditions(condition, key):
						current_matching_condition += 1

			if current_matching_condition > matching_condition:
				matching_condition = current_matching_condition
				next = predicated_next

	if not next.empty():
		return dialogue_json[next]

	assert(default_next.empty() == false)
	return dialogue_json[default_next]


func get_choices(choices: Array, conditions: Array = []) -> Array:
	if conditions.empty():
		return choices

	var result := []
	var conditional_choices := {}

	for choice in choices:
		if choice.has("uuid"):
			conditional_choices[choice.uuid] = choice
		else:
			result.append(choice)

	if conditional_choices.empty():
		return choices

	var matching_condition := 0
	for condition in conditions:
		var current_matching_condition := 0
		for key in condition:
			var predicated_next: String = condition.next
			condition.erase("next")

			if _conditions.has(key):
				# conditions will never match
				if _conditions.size() < condition.size():
					continue

				if condition.empty():
					result.append(conditional_choices[predicated_next])

				if _check_conditions(condition, key):
					current_matching_condition += 1

			if current_matching_condition > matching_condition:
				result.append(conditional_choices[predicated_next])

	# dialogue json file was badly configuarated since it doesn't have a default choice
	assert(not result.empty())
	return result


# Valid conditions
# @param {Dictionary} condition
# @param {String} key
# @returns {bool}
func _check_conditions(condition: Dictionary, key: String) -> bool:
	match condition[key].operator:
		"lower":
			return condition[key].value > _conditions[key]
		"greater":
			return condition[key].value < _conditions[key]
		"different":
			return condition[key].value != _conditions[key]
		_:
			return condition[key].value == _conditions[key]


# Check all dialogue portrait and set them in memory
func _load_portrait_in_memory() -> void:
	for key in dialogue_json:
		var values: Dictionary = dialogue_json[key]
		if (
			not values.has("portrait")
			or values.portrait.empty()
			or _portraits_res.has(values.portrait)
		):
			continue
		_portraits_res[values.portrait] = load(values.portrait)


func _convert_value_to_type(type: String, value):
	match type:
		"Vector2":
			return Vector2(value["x"], value["y"])

	return value


func _on_Choices_finished(key: String) -> void:
	Events.disconnect("dialogue_choices_finished", self, "_on_Choices_finished")

	# get choice
	_current_dialogue = dialogue_json[key]
	change()


# Emit signal at current dialogue
# @param {Dictionary} signals
func _emit_dialogue_signal(signals: Dictionary) -> void:
	for key in signals:
		if not signals[key] is Dictionary:
			if signals[key] == null:
				Events.emit_signal(key)
				continue
			Events.emit_signal(key, signals[key])
			continue

		var multi_values_signal: Dictionary = signals[key]
		for type in multi_values_signal:
			var value = _convert_value_to_type(type, multi_values_signal[type])
			Events.emit_signal(key, value)
