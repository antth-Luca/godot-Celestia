extends Control

@onready var inputs: Array[InputSlot] = [
	$InputSlot,
	$InputSlot2,
	$InputSlot3,
	$InputSlot4,
	$InputSlot5,
]
@onready var output_slot: OutputSlot = $OutputSlot
@onready var interact_hammer: Sprite2D = $InteractHammer

var recipe_cache: BaseRecipe

# GODOT
func _ready() -> void:
	for slot in inputs:
		slot.connect('slot_item_added', Callable(self, 'try_find_recipe'))
		slot.connect('slot_item_removed', Callable(self, 'try_find_recipe'))

# MAIN
func fill_children(player: Player) -> void:
	for slot in inputs:
		slot.player = player


func try_find_recipe() -> void:
	# Try to find a valid and compatible recipe. If find one, set the preview and enable the interaction hammer.
	var input_stacks: Array[ItemStack]
	for slot in inputs:
		input_stacks.append(slot.stack)
	if recipe_cache and recipe_cache.matches(input_stacks):
			output_slot.set_output_preview()
			enable_interact_hammer()
			return
	var per_workstation = RegistryManager.registries[RecipeRegistry.REGISTRY_TYPE]._per_workstation.get(get_parent().selected).duplicate()
	var per_ingredient = RegistryManager.registries[RecipeRegistry.REGISTRY_TYPE]._per_ingredient
	for stack in input_stacks:
		if per_ingredient.has(stack.item.id):
			var by_ingred = per_ingredient[stack.item.id]
			per_workstation = per_workstation.filter(func(id): return id in by_ingred)
	for possible in per_workstation:
		var recipe: BaseRecipe = possible.get_registered()
		if recipe.matches(input_stacks):
			recipe_cache = recipe
			output_slot.set_output_preview()
			enable_interact_hammer()
			return


func enable_interact_hammer() -> void:
	# Sets the sprite's total opacity and enables dragging.
	pass


func set_result() -> void:
	# Sets the result in the output slot and blocks new inputs.
	pass


func finish_craft() -> void:
	# Enables new inputs and sets the recipe cache.
	pass
