extends Node

@export var initial_state: BaseState

var states: Dictionary[String, BaseState] = {}
var current_state: BaseState

# GODOT
func _ready() -> void:
	for child in get_children():
		if child is BaseState:
			states[child.name.to_lower()] = child
	if initial_state: switch_state(initial_state)

func _process(delta: float) -> void:
	if current_state: current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state: current_state.physics_update(delta)

# MAIN
func switch_state(new_state: BaseState):
	if new_state != current_state and states.get(new_state.name.to_lower()):
		if current_state: current_state.exit()
		current_state = new_state
		current_state.enter()
