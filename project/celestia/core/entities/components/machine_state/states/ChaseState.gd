extends BaseState
class_name ChaseState

@export var enemy: CharacterBody2D

var target: CharacterBody2D

# SUPER
func physics_update(_delta: float) -> void:
	if enemy and target: enemy.direction = (target.global_position - enemy.global_position).normalized()

# GETTERS AND SETTERS
func set_target(new_target: CharacterBody2D) -> void:
	target = new_target
