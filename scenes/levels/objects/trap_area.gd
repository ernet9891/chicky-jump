extends Area2D

@onready var spike_7: Area2D = $"../Spike/Spike7"

func _ready() -> void:
	spike_7.visible = false
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		spike_7.visible = true
	
