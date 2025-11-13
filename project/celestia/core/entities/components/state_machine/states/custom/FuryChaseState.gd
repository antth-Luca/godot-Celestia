extends ChaseState
class_name FuryChaseState

@export var max_fury: float
@export var fury_increment: float
@export var fury_decrement: float
@export var state_when_fury: BaseState

var fury: float

# SUPER
func exit() -> void:
	fury -= fury_decrement


func physics_update(_delta: float) -> void:
	if parent_entity and target:
		fury += fury_increment
		if not fury < max_fury:
			state_when_fury.target = target
			get_parent().change_state_to_node(state_when_fury)
		parent_entity.direction = (target.global_position - parent_entity.global_position).normalized()
