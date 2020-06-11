extends Camera2D

const SPEED := .5


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_free_camera_zoom_in"):
		zoom -= Vector2(.25, .25)
	if event.is_action_pressed("debug_free_camera_zoom_out"):
		zoom += Vector2(.25, .25)


func _process(delta: float) -> void:
	if Input.is_action_pressed("move_up"):
		position.y -= SPEED
	if Input.is_action_pressed("move_down"):
		position.y += SPEED
	if Input.is_action_pressed("move_left"):
		position.x -= SPEED
	if Input.is_action_pressed("move_right"):
		position.x += SPEED
