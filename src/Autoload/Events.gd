extends Node

# trad
signal locale_changed(locale)

# notification
signal notification_started(text, size)

# player
signal player_moved(player)
signal player_room_entered(position)

# level
signal level_preload_finished

# room
signal room_limit_changed(
	left,
	top,
	right,
	bottom,
)
signal room_transition_started
signal room_transition_ended

# cinematic
signal cinematic_started
signal cinematic_ended

# gate
signal gate_entered(room_id)

# in-game interfaces
signal game_paused
signal game_unpaused

# menu
signal menu_route_changed(route)

# input
signal keybinding_started(scancode)
signal keybinding_canceled
signal keybinding_resetted
signal keybinding_key_selected(scancode)

# transitions
signal transition_started(anim_name)
signal transition_mid_animated
signal transition_finished
