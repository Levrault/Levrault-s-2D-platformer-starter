# System notification
extends Control

onready var message := $Wrapper/MessageWrapper/Message
onready var anim := $AnimationPlayer


func _ready():
	Events.connect("notification_started", self, "_on_Notification_started")


func _on_Notification_started(text: String, size: Vector2 = Vector2(460, 40)) -> void:
	anim.play("push")
	message.parse_bbcode(tr(text))
	rect_size = size
