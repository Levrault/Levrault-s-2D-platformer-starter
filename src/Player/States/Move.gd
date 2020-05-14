extends State

export var max_speed_default := Vector2(500.0, 1500.00)
export var acceleration_default := Vector2(10000, 3000.0)
export var jump_impulse := 900.0

var acceleration := acceleration_default
var max_speed := max_speed_default
var velocity := Vector2.ZERO


func physics_process(delta: float) -> void:
	velocity = calculate_velocity(velocity, max_speed, acceleration, delta, get_move_direction())
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)
	Events.emit_signal("player_moved", owner)


static func calculate_velocity(
	old_velocity: Vector2,
	max_speed: Vector2,
	acceleration: Vector2,
	delta: float,
	move_direction: Vector2
) -> Vector2:
	var new_velocity := old_velocity

	new_velocity += move_direction * acceleration * delta
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)

	return new_velocity

static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 1.0
	)
