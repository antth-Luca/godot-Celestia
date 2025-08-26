extends Area2D

@export var target_group: String
@export var machine_state: MachineState

# GETTERS AND SETTERS
# Nodes
func get_enemy():
	return get_parent()


# HANDLERS
func _on_body_entered(body):
	print('Corpo entrou!')
	if body.is_in_group(target_group):
		print('Está no grupo!')
		var machine = get_enemy().get_machine_state()
		machine.get_state('chase').set_target(body)
		machine.switch_state('chase')


func _on_body_exited(body):
	print('Corpo saiu!')
	if body.is_in_group(target_group):
		print('Está no grupo!')
		get_enemy().get_machine_state().switch_state('wander')
