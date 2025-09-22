extends Area2D

@export var target_group: String
@export var state_on_detect: BaseState
@export var state_machine: StateMachine

# HANDLERS
func _on_body_entered(body):
	if body.is_in_group(target_group):
		state_on_detect.target = body
		state_machine.change_state_to_node(state_on_detect)


func _on_body_exited(body):
	if body.is_in_group(target_group): state_machine.change_state_to_string('idle')
