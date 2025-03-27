extends CharacterBody2D

const SPEED = 100.0
const AIR_FRICTION = 0.5

@export var jump_height := 68  # dobro da altura do personagem + 4
@export var max_time_to_peak := 0.5

var jump_velocity
var gravity
var fall_gravity
var direction
var is_jumping := false
var is_hurted := false

@onready var animation = $Sprite as AnimatedSprite2D


func _ready():
	jump_velocity = (jump_height * 2) / max_time_to_peak
	gravity = (jump_height * 2) / pow(max_time_to_peak, 2)
	fall_gravity = gravity * 2


func _physics_process(_delta):
	# Add the gravity.
	# TODO

	# Handle jump.
	# TODO

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Normaliza a direção para evitar velocidade maior em diagonais
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	if direction.x != 0:
		animation.scale.x = sign(direction.x)

	velocity = direction * SPEED

	_set_state()
	move_and_slide()


func _set_state():
	var state = "idle"
	
	# if !is_on_floor():
	# 	state = "jump"
	# el
	if direction != Vector2.ZERO:
		state = "walk"

	if is_hurted:
		state = "hurt"

	if animation.name != state:
		animation.play(state)
