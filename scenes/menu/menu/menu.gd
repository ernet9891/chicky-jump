extends Control

@onready var play_marker: Marker2D = $PanelContainer/HBoxContainer/PanelContainer/VBoxContainer/PlayMarker
@onready var credits_marker: Marker2D = $PanelContainer/HBoxContainer/PanelContainer/VBoxContainer/CreditsMarker

@onready var arrow: Sprite2D = $PanelContainer/HBoxContainer/PanelContainer/VBoxContainer/Arrow

@onready var uisfx: AudioStreamPlayer2D = $UISFX

var idx: int
var markers := []


func _ready() -> void:
	markers = [
		play_marker,
		credits_marker
	]
	
	if SceneManager.in_credits:
		idx = 1
	if not SceneManager.in_h2p and not SceneManager.in_credits:
		idx = 0
	
	update_arrow()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		uisfx.play()
		if idx == 0:
			idx = 1
			update_arrow()
			return
		idx -= 1
		update_arrow()
		
	if event.is_action_pressed("ui_down"):
		uisfx.play()
		if idx == 1:
			idx = 0
			update_arrow()
			return
		idx += 1
		update_arrow()

	if idx == 0 and event.is_action_pressed("enter"):
		SceneManager.go_to_lvl_1()
	
	elif idx == 1 and event.is_action_pressed("enter"):
		SceneManager.go_to_credit_scene()
	
func update_arrow() -> void:
	arrow.global_position = markers[idx].global_position
