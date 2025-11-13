extends BaseState
class_name AttackState

@export var attack_animation: AnimationPlayer
@export var attack_anim_name: String = 'attack'
@export var has_preparation: bool
@export var attack_preparation_anim_name: String = 'attack_preparation'

@onready var parent_entity: CharacterBody2D = get_parent().get_parent()  # StateMachine > Entity

var target: CharacterBody2D:
	set(new_target):
		target = new_target

# SUPER
func enter() -> void:
	if has_preparation:
		attack_animation.play(attack_preparation_anim_name)
		await attack_animation.animation_finished
	attack_animation.play(attack_anim_name)


func exit() -> void:
	attack_animation.stop()
	if has_preparation:
		attack_animation.play_backwards(attack_preparation_anim_name)
		await attack_animation.animation_finished
