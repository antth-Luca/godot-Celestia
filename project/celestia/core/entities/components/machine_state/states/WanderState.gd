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
		randomize_wander()


func _physics_process(_delta: float) -> void:
	if enemy: enemy.direction = move_direction

# MAIN
func randomize_wander() -> void:
	move_direction = Vector2(
		randf_range(-1, 1),
		randf_range(-1, 1)
	).normalized()
	left_time = randf_range(1, 3)
