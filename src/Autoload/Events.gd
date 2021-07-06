# Signal Autoload Pattern
# @see https://www.youtube.com/watch?v=S6PbC4Vqim4
extends Node

# notification
signal notification_started(text, size)

# camera
signal camera_offset_changed(offset)
signal camera_offset_resetted

# player
signal player_moved(player)
signal player_room_entered(position)
signal player_choice_started

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

# dialogue
signal dialogue_started
signal dialogue_changed(name, portrait, message)
signal dialogue_text_displayed
signal dialogue_last_text_displayed
signal dialogue_finished
signal dialogue_last_dialogue_displayed
signal dialogue_animation_skipped
signal dialogue_choices_changed(choices)
signal dialogue_choices_displayed
signal dialogue_choices_finished(choices)
signal dialogue_choices_pressed

# cinematic
signal cinematic_started
signal cinematic_ended

# gate
signal gate_entered(room_id)

# portal
signal portal_entered(level_id, room_id)

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

# serialize
signal game_saved

# transitions
signal transition_started(anim_name)
signal transition_mid_animated
signal transition_finished

# test
signal has_meet
