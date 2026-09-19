extends Control

@onready var respect: Sprite2D = $Respect
@onready var respect_2: Sprite2D = $Respect2
var anim_time: float = .5

@onready var v_box_container: VBoxContainer = $VBoxContainer

var target_pos: Vector2 =  Vector2(296, 186.5)


func _ready() -> void:
	var tween: Tween = create_tween().set_loops()
	
	tween.tween_property(v_box_container, "position", target_pos, 1.5)
	
	tween.tween_property(respect, "scale", Vector2(1, 1), anim_time/2)
	tween.tween_property(respect, "scale", Vector2(.5, .5), anim_time/2)
	tween.tween_property(respect_2, "scale", Vector2(1, 1), anim_time/2)
	tween.tween_property(respect_2, "scale", Vector2(.5, .5), anim_time/2)
