extends Area2D

onready var collider: CollisionShape2D = $CollisionShape2D

var is_active := true setget set_is_active


func _ready() -> void:
	connect("area_entered", self, "_on_Area_entered")


func set_is_active(value: bool) -> void:
	is_active = value
	collider.disabled = not value


func _on_Area_entered(damage_source: Area2D) -> void:
	owner.take_damage(Hit.new(damage_source))
