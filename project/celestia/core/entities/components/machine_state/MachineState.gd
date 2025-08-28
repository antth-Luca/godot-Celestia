extends Node
class_name StateMachine

@export var initial_state: BaseState

var states: Dictionary[String, BaseState] = {}
var current_state: BaseState

# GODOT
func _ready() -> void:
	for child in get_children():
		if child is BaseState:
			states[child.name.to_lower()] = child
	if initial_state: change_state_to_node(initial_state)

func _process(delta: float) -> void:
	if current_state: current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state: current_state.physics_update(delta)

# GETTERS AND SETTERS
# Nodes
func get_state(state_name: String):
	return get_node(state_name.capitalize())

# MAIN
func change_state_to_node(new_state: BaseState) -> void:
	if new_state != current_state:
		if current_state: current_state.exit()
		current_state = new_state
		current_state.enter()


func change_state_to_string(new_state: String) -> void:
	var state_node = states.get(new_state.to_lower())
	if state_node: change_state_to_node(state_node)
