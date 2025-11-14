extends BaseState
class_name AttackState

@export var has_preparation: bool
@export var attack_preparation_anim_name: String = 'attack_preparation'

@onready var parent_entity: CharacterBody2D = get_parent().get_parent()  # StateMachine > Entity

var target: CharacterBody2D

# SUPER
func enter() -> void:
	if has_preparation:
		parent_entity.can_switch_arms_animation = false
		parent_entity.ARMS_ANIMATION.play(attack_preparation_anim_name)
		await parent_entity.ARMS_ANIMATION.animation_finished
		parent_entity.can_switch_arms_animation = true
	parent_entity.is_attacking = true


func exit() -> void:
	parent_entity.is_attacking = false
	if has_preparation:
		parent_entity.can_switch_arms_animation = false
		parent_entity.ARMS_ANIMATION.play_backwards(attack_preparation_anim_name)
		await parent_entity.ARMS_ANIMATION.animation_finished
		parent_entity.can_switch_arms_animation = true
