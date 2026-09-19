extends Area2D

@export var current_level: String
@onready var hurt_sfx: AudioStreamPlayer2D = $HurtSFX
@export var can_move: bool = false
@export var move_range: float = 30

func _ready() -> void:	
	if can_move:
		var tween := create_tween().set_loops()
		tween.tween_property(self, "position:y", position.y-move_range, 0.5)
		tween.tween_interval(1)
		tween.tween_property(self, "position:y", position.y+move_range, 0.5)
		tween.tween_interval(1)
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SceneManager.go_to_lvl(current_level)
		
