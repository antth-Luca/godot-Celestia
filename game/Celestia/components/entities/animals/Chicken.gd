extends CharacterBody2D

@onready var CHANGE_STATE_TIMER = $TimerChangeState as Timer

@onready var TEXTURE = $Texture as Sprite2D
@onready var ANIMATION = $Animation as AnimationPlayer

const AIR_FRICTION: float = 0.5
var direction: Vector2 = Vector2.ZERO
var is_fooding: bool = false

var stats: ChickenStats


func _ready() -> void:
	if stats == null:
		stats = ChickenStats.new()


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
		direction = Vector2(randf_range(0, 1), randf_range(0, 1))
		timer_duration = randf_range(1.0, 5.0)
	else:  # Idle state => 33%
		is_fooding = false
		direction = Vector2.ZERO
		timer_duration = randf_range(1.0, 5.0)

	CHANGE_STATE_TIMER.wait_time = timer_duration
	CHANGE_STATE_TIMER.start()
