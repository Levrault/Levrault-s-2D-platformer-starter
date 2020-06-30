# Main controlled character
class_name Player
extends Actor

const FLOOR_NORMAL := Vector2.UP
const SNAP := Vector2(0, 10)

var is_active := true setget set_is_active
var is_handling_input := true setget set_is_handling_input
var abilities := {"dash": false, "double_jump": false}

onready var state_machine: StateMachine = $StateMachine
onready var skin: Node2D = $Skin
onready var camera_rig: Position2D = $CameraRig
onready var camera: Camera2D = $CameraRig/Camera
onready var collider: CollisionShape2D = $CollisionShape2D
onready var attack_factory: AttackFactory = $AttackFactory as AttackFactory


func _ready() -> void:
	Events.connect("player_room_entered", self, "_on_Player_Room_entered")
	stats.connect("health_depleted", self, "_on_Stats_health_depleated")


func set_is_handling_input(value: bool) -> void:
	$StateMachine.set_process_unhandled_input(value)
	is_handling_input = value


func set_is_active(value: bool) -> void:
	is_active = value
	if not collider:
		return
	collider.disabled = not value


func horizontal_mirror(direction: int) -> void:
	skin.scale.x = direction
	attack_factory.scale.x = direction


# Unlock acces to new state machine state
# @param {String} ability_name
func unlock_ability(ability_name: String) -> void:
	if abilities.has(ability_name):
		abilities[ability_name] = true
		print_debug("unlock %s abilities" % [ability_name])


func _on_Player_Room_entered(global_position: Vector2) -> void:
	self.global_position = global_position


func _on_Stats_health_depleated() -> void:
	state_machine.transition_to("Spawn")
