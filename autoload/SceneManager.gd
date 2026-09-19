extends Node

var move_tutorial: String = "res://scenes/levels/levels/move_tutorial.tscn"
var credit_scene: String = "res://scenes/menu/credits/credit.tscn"
var menu_scene: String = "res://scenes/menu/menu/menu.tscn"

var in_h2p: bool = false
var in_credits: bool = false

func go_to_lvl_1() -> void:
	in_h2p = false
	in_credits = false
	get_tree().change_scene_to_file(move_tutorial)
	

func go_to_credit_scene() -> void:
	in_h2p = false
	in_credits = true
	get_tree().change_scene_to_file(credit_scene)


func go_to_menu() -> void:
	get_tree().change_scene_to_file(menu_scene)


func go_to_lvl(level: String) -> void:
	get_tree().call_deferred("change_scene_to_file", level)
	
