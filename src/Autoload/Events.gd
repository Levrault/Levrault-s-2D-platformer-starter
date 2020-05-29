extends Node

# player
signal player_moved(player)


# menu
signal menu_route_changed(route)


# transitions
signal transition_started(anim_name)
signal transition_mid_animated()
signal transition_finished()
