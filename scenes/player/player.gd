extends CharacterBody2D

var speed: float = 300.0

var jump_power: float = 0.0
var min_jump_power: float = 0.0
var max_jump_power: float = 1200.0
var charge_speed: float = 1000.0
var charge_dir: int = 1

var jump_grav: float = 980.0

@onready var label: Label = $Label
@onready var sprite: Sprite2D = $Sprite2D
var sprite_initial_scale: Vector2

var flip_anim_dur: float = .1

var oscillator_velocity: float
var displacement: float
var spring: float = 900
var damp: float = 10
var velocity_multiplier: float = 2

@onready var power_indicator: ColorRect = $PowerIndicator
var indicator_max_size: Vector2

@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX

func _ready() -> void:
	sprite_initial_scale = sprite.scale
	
	indicator_max_size = power_indicator.size
	power_indicator.size.x = 0
	

func _process(_delta: float) -> void:
	var power_fraction: float = jump_power / max_jump_power
	power_indicator.size.x = indicator_max_size.x * power_fraction

func _physics_process(delta: float) -> void:
	apply_grav(delta)
	handle_jump_charge(delta)
	
	handle_horizontal_movement()
	handle_move_anim(delta)
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept"):
		handle_jump_release()
		
		
func handle_jump_release() -> void:
	if jump_power == 0 or Engine.time_scale == 0.5:
		return
	
	jump_sfx.play()
	velocity.y = -jump_power
	jump_power = 0


func handle_jump_charge(delta: float) -> void:
	if Input.is_action_pressed("ui_accept") and is_on_floor():
			
		jump_power += charge_speed * delta * charge_dir
		
		if jump_power > max_jump_power:
			charge_dir = -1
			
		if jump_power < min_jump_power:
			charge_dir = 1

			
func handle_horizontal_movement() -> void:
	var direction: float = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		handle_flip_anim(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)


func handle_move_anim(delta: float) -> void:
	oscillator_velocity += velocity.normalized().x * velocity_multiplier
	
	var force: float = -spring * displacement + damp * oscillator_velocity
	oscillator_velocity -= force * delta
	displacement -= oscillator_velocity * delta
	
	sprite.rotation = displacement


func handle_flip_anim(direction: float) -> void:
	sprite.flip_h = direction < 0


func apply_grav(delta: float) -> void:
	if not is_on_floor():
		velocity.y += jump_grav * delta
