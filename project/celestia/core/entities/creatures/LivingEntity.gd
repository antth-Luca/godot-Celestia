extends Entity
class_name LivingEntity

var direction: Vector2 = Vector2.ZERO

# GODOT
func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var stats_move_speed = stats.get_property(InitPropProviders.MOVE_SPEED).get_move_speed()
	if direction != Vector2.ZERO:
		velocity = direction * stats_move_speed
		if direction.x != 0: TEXTURE.scale.x = sign(direction.x)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, stats_move_speed)
	# Setting state and animation and continuing movement
	set_state()
	move_and_slide()
