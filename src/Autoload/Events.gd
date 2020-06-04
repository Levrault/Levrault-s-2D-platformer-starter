extends Node

# trad
signal locale_changed(locale)

# player
signal player_moved(player)

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
