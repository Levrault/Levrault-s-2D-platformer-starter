extends State


export var acceleration_x: = 5000.0
onready var move := get_parent()


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	move.physics_process(delta)

	# Landing
	if owner.is_on_floor():
		var target_state: = "Move/Idle" if move.get_move_direction().x == 0 else "Move/Run"
		_state_machine.transition_to(target_state)


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)

	move.acceleration.x = acceleration_x
	if "velocity" in msg:
		move.velocity = msg.velocity
		move.max_speed.x = max(abs(msg.velocity.x), move.max_speed.x)
	if "impulse" in msg:
		move.velocity += calculate_jump_velocity(msg.impulse)


func exit() -> void:
	move.acceleration = move.acceleration_default
	move.exit()


# Returns a new velocity with a vertical impulse applied to it
func calculate_jump_velocity(impulse: float = 0.0) -> Vector2:
	return move.calculate_velocity(
		move.velocity,
		move.max_speed,
		Vector2(0.0, impulse),
		Vector2.ZERO,
		1.0, # replace delta
		Vector2.UP
	)

