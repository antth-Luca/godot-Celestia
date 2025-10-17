extends Control

@onready var input_slot: InputSlot = $InputSlot
@onready var output_slot: OutputSlot = $OutputSlot
@onready var interact_star: InteractConfirm = $InteractConfirm

var can_set_input := true
var recipe_cache: BaseRecipe
var output_stacks: Array[ItemStack]

# GODOT
func _ready() -> void:
	# Input
	input_slot.connect('slot_item_added', Callable(self, 'try_find_recipe'))
	input_slot.connect('slot_item_removed', Callable(self, 'try_find_recipe'))
	# Output
	output_slot.connect('slot_item_removed', Callable(self, 'cleanup_craft'))

# MAIN
func fill_children(player: Player) -> void:
	input_slot.player = player


func try_find_recipe() -> void:
	# Try to find a valid and compatible recipe. If find one, set the preview and enable the interaction hammer.
	var input_stack: ItemStack = input_slot.stack
	if input_stack.is_empty(): return
	if input_stack.item.id.get_string() == InitItems.PAPYRUS.location.get_string():
		for c in input_slot.stack.amount:
			if not recipe_cache: recipe_cache = InitRecipes.CONSTELLATION_SCROLLS.get_registered()
			var result = recipe_cache.get_result()
			if output_stacks.is_empty():
				output_stacks.append(result)
				continue
			for output in output_stacks:
				if output.item.id.get_string() == result.item.id.get_string():
					var remaining = output.add_amount_safe(result.amount)
					if remaining > 0: output_stacks.append(ItemStack.new(result.item, remaining))
					break
				else:
					output_stacks.append(result)
		output_slot.stack = output_stacks.front()
		output_slot.set_preview()
		interact_star.enable_interaction()


func cleanup_craft() -> void:
	# Enables new inputs and sets the recipe cache.
	can_set_input = true
	input_slot.stack = ItemStack.EMPTY
