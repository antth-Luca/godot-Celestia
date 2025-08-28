extends BaseState
class_name ChaseState

@onready var parent_entity: CharacterBody2D = get_parent().get_parent()  # StateMachine > Entity

var target: CharacterBody2D:
	set(new_target):
		target = new_target

# SUPER
func physics_update(_delta: float) -> void:
	if parent_entity and target: parent_entity.direction = (target.global_position - parent_entity.global_position).normalized()
