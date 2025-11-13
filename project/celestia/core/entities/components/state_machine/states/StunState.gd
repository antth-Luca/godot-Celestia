extends BaseState
class_name StunState

@export var next_state: BaseState
@export var time_stun: float

@onready var parent_entity: CharacterBody2D = get_parent().get_parent()  # StateMachine > Entity

# SUPER
func enter() -> void:
	parent_entity.effect_receiver.add_effect(EffectInstance.new(InitEffects.STUN, time_stun))
	var timer := Timer.new()
	timer.one_shot = true
	timer.start(time_stun)
	await timer.timeout
	get_parent().change_state_to_node(next_state)
