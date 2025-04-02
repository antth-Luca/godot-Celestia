extends CharacterBody2D

@onready var CHANGE_STATE_TIMER = $TimerChangeState as Timer
@onready var TEXTURE = $Texture as Sprite2D
@onready var ANIMATION = $Animation as AnimationPlayer

const AIR_FRICTION: float = 0.5
var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.ZERO
var is_fooding: bool = false

var stats: ChickenStats


func _ready() -> void:
	if stats == null:
		stats = ChickenStats.new()

	_on_change_state_timer_timeout()


func _physics_process(_delta) -> void:
	if is_fooding:
		set_state()
		return
	# Get the input direction and handle the movement/deceleration.
	if direction != Vector2.ZERO:
		velocity = velocity.lerp(direction * stats.get_move_speed(), AIR_FRICTION)
		if direction.x != 0: TEXTURE.scale.x = sign(direction.x)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, stats.get_move_speed())
	# Setando estado e animação e continuando movimento
	set_state()
	move_and_slide()


func set_state() -> void:
	var state = "idle"
	if direction != Vector2.ZERO:
		state = "walk"
	if is_fooding:
		state = "food"
	if ANIMATION.current_animation != state:
		ANIMATION.play(state)


func _on_change_state_timer_timeout():
	var timer_duration: float
	var next_action: float = randf_range(0, 1)
	
	if next_action < 0.11:  # Fooding state => 10%
		is_fooding = true
		direction = Vector2.ZERO
		timer_duration = 2.2
	elif next_action > 0.34:  # Walking state => 57%
		is_fooding = false
		direction = pick_valid_direction()
		timer_duration = randf_range(1, 5)
	else:  # Idle state => 33%
		is_fooding = false
		direction = Vector2.ZERO
		timer_duration = randf_range(1, 5)

	CHANGE_STATE_TIMER.wait_time = timer_duration
	CHANGE_STATE_TIMER.start()


# Escolhe uma direção que evita andar para trás e impede ficar preso
func pick_valid_direction() -> Vector2:
	var new_direction = last_direction
	var attempts = 5  # Tentativas para encontrar uma direção válida
	
	while attempts > 0:
		new_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		if new_direction.distance_to(last_direction) > 0.5:  # Evita voltar para trás imediatamente
			break
		attempts -= 1
	
	last_direction = new_direction
	return new_direction
