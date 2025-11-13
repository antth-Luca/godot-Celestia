extends BaseState
class_name DashState

@export var dash_range: float
@export var next_state: BaseState

@onready var parent_entity: CharacterBody2D = get_parent().get_parent()  # StateMachine > Entity

var dash_timer: Timer
var target: CharacterBody2D:
	set(new_target):
		target = new_target

# SUPER
func enter() -> void:
	if parent_entity and target:
		parent_entity.is_dashing = true
		for c in parent_entity.get_dashes_number():
			parent_entity.direction = (target.global_position - parent_entity.global_position).normalized()
			dash_timer.start()
			await dash_timer.timeout
		parent_entity.is_dashing = false
		get_parent().change_state_to_node(next_state)

# MAIN
func _ready() -> void:
	dash_timer = Timer.new()
	dash_timer.wait_time = dash_range
	dash_timer.one_shot = true
	add_child(dash_timer)
