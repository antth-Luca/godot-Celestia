extends BaseState
class_name WanderState

@export var enemy: CharacterBody2D
@export var ray_vision: RayCast2D

var left_time: float
var move_direction: Vector2

# SUPER
func enter() -> void:
	randomize_wander()


func update(delta: float) -> void:
	if left_time > 0:
		left_time -= delta
	else:
		get_parent().change_state_to_string('idle')


func physics_update(_delta: float) -> void:
	if ray_vision:
		ray_vision.target_position = move_direction * 32
		if ray_vision.is_colliding():
			randomize_move_direction()
		elif enemy: enemy.direction = move_direction


func exit() -> void:
	if enemy: enemy.direction = Vector2.ZERO

# MAIN
func randomize_wander() -> void:
	randomize_move_direction()
	randomize_time()


func randomize_move_direction() -> void:
	move_direction = Vector2(
		randf_range(-1, 1),
		randf_range(-1, 1)
	).normalized()


func randomize_time() -> void:
	left_time = randf_range(1, 4)
