extends BaseState
class_name DropResourceState

@export var animation_name: String
@export var next_state: BaseState

@onready var parent_entity: CharacterBody2D = get_parent().get_parent()  # StateMachine > Entity

var loot_box: LootBox

func enter() -> void:
	parent_entity.is_laying = true
	parent_entity.ANIMATION.play(animation_name)
	await parent_entity.ANIMATION.animation_finished
	var item_stacks: Array[ItemStack] = loot_box.get_sorted_output()
	for stack in item_stacks:
		DroppedItemUtils.drop_item_entity_foot(stack, parent_entity)
	parent_entity.is_laying = false
	get_parent().change_state_to_node(next_state)
