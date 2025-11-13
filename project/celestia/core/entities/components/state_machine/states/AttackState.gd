extends BaseState
class_name AttackState

@export var attack_anim_name: String
@export var has_preparation: bool
@export var attack_preparation_anim_name: String

@onready var parent_entity: CharacterBody2D = get_parent().get_parent()  # StateMachine > Entity

var target: CharacterBody2D:
	set(new_target):
		target = new_target

# SUPER
func enter() -> void:
	if has_preparation:
		parent_entity.ANIMATION.play(attack_preparation_anim_name)
	parent_entity.is_attacking = true


func exit() -> void:
	if has_preparation: parent_entity.ANIMATION.play_backwards(attack_preparation_anim_name)
	parent_entity.is_attacking = false
