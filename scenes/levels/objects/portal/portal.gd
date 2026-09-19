extends Area2D

@onready var enter_label: Label = $Label

@export var next_level: String

func _ready() -> void:
	enter_label.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		enter_label.visible = true
	

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		enter_label.visible = false


func _input(event: InputEvent) -> void:
	if enter_label.visible == true && event.is_action_pressed("enter") && next_level:
		SceneManager.go_to_lvl(next_level)
