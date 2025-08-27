extends BaseState
class_name IdleState

@export var enemy: CharacterBody2D

var left_time: float

# SUPER
func enter() -> void:
	randomize_idle()


func update(delta: float) -> void:
	if left_time > 0:
		left_time -= delta
	else:
		get_parent().change_state_to_string('wander')

# MAIN
func randomize_idle() -> void:
	left_time = randf_range(1, 2)
