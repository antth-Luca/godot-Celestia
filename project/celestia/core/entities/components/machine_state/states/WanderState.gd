extends BaseState
class_name WanderState

@export var enemy: CharacterBody2D

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
	if enemy: enemy.direction = move_direction


func exit() -> void:
	if enemy: enemy.direction = Vector2.ZERO

# MAIN
func randomize_wander() -> void:
	move_direction = Vector2(
		randf_range(-1, 1),
		randf_range(-1, 1)
	).normalized()
	left_time = randf_range(1, 4)
