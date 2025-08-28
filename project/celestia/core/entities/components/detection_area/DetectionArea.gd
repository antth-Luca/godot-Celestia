extends Area2D

@export var target_group: String
@export var machine_state: StateMachine

# GETTERS AND SETTERS
# Nodes
func get_enemy() -> CharacterBody2D:
	return get_parent()


# HANDLERS
func _on_body_entered(body):
	if body.is_in_group(target_group):
		var state_node = machine_state.states.get('chase')
		state_node.set_target(body)
		machine_state.change_state_to_node(state_node)


func _on_body_exited(body):
	if body.is_in_group(target_group): machine_state.change_state_to_string('idle')
