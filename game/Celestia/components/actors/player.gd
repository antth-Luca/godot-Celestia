extends CharacterBody2D

const SPEED = 80.0
const AIR_FRICTION = 0.5

var jump_velocity
var gravity
var fall_gravity
var direction := Vector2.ZERO
var is_jumping := false
var is_hurted := false

@onready var animation = $AnimationPlayer as AnimationPlayer
@onready var wallCollis = $WallCollision as CollisionShape2D

func _physics_process(_delta):
	if is_jumping: return
		

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	if direction != Vector2.ZERO:
		velocity = velocity.lerp(direction * SPEED, AIR_FRICTION)
		if direction.x != 0: $Texture.scale.x = sign(direction.x)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and not is_jumping and is_valid_cell():
		is_jumping = true
		animation.play("jump")
		var jump_tween = create_tween()
		jump_tween.tween_property(
			self,
			"position",
			global_position + (velocity * 0.6),
			0.5
		)
		await jump_tween.finished
		is_jumping = false

	_set_state()
	move_and_slide()


func is_valid_cell():
	return true


func _set_state():
	var state = "idle"
	
	if direction != Vector2.ZERO:
		state = "walk"

	if is_hurted:
		state = "hurt"

	if animation.name != state:
		animation.play(state)
