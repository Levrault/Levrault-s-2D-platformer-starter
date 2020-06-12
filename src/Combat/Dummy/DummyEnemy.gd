extends Actor


func _ready() -> void:
	stats.connect("health_depleted", self, "_on_Stats_health_depleated")


func _on_Stats_health_depleated():
	queue_free()
