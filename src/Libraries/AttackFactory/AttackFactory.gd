class_name AttackFactory, "res://assets/icons/attack_factory.svg"
extends Node2D

onready var damage_source: DamageSource = $DamageSource as DamageSource


func _ready() -> void:
	yield(owner, "ready")


func create(attack_name: String) -> void:
	owner.skin.play(attack_name)
	owner.skin.connect("animation_finished", self, "_on_Skin_animation_finished")


func _on_Skin_animation_finished(anim_name: String) -> void:
	damage_source.set_active(false)
	owner.skin.disconnect("animation_finished", self, "_on_Skin_animation_finished")
