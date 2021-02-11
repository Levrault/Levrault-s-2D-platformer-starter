# Manage menu transition
# transition_fade_mid_transition and transition_fade_finished are emitted from AnimationPlayer
extends Control


func _ready() -> void:
	$AnimationPlayer.connect("animation_finished", self, "_on_Animation_finished")
	Events.connect("transition_started", self, "_on_Transition_started")


func _on_Transition_started(anim_name: String) -> void:
	$AnimationPlayer.play(anim_name)
	owner.set_process_input(false)


func _on_Mid_animation() -> void:
	Events.emit_signal("transition_mid_animated")


func _on_Animation_finished(anim_name: String) -> void:
	owner.set_process_input(true)
	Events.emit_signal("transition_finished")
