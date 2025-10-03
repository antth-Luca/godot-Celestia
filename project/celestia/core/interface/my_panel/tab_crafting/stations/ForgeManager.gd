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
	# BEGIN: Extract the stacks from the input slots...
	var input_stacks: Array[ItemStack]
	for slot in inputs:
		var stack: ItemStack = slot.stack
		if not stack.is_empty(): input_stacks.append(stack)
	# ...If there is a revenue cache and it is valid, we use...
	if recipe_cache and recipe_cache.matches(input_stacks):
		output_slot.set_output_preview(recipe_cache.get_result())
		enable_interact_hammer()
		return
	# ...Get the recipes allowed per workstation and per ingredient...
	var registry: RecipeRegistry = RegistryManager.registries[RecipeRegistry.REGISTRY_TYPE]
	var per_workstation: Array = registry._per_workstation.get(get_parent().selected).duplicate()
	var per_ingredient: Dictionary[ResourceLocation, Array] = registry._per_ingredient
	# ...Filter recipes by input ingredients...
	for stack in input_stacks:
		if not stack.is_empty() and per_ingredient.has(stack.item.id):
			var by_ingred: Array[ResourceLocation] = per_ingredient[stack.item.id]
			per_workstation = per_workstation.filter(func(id): return id in by_ingred)
	# ...Tests each candidate recipe...
	for possible in per_workstation:
		var recipe: BaseRecipe = registry._registries[possible].call()
		if recipe and recipe.matches(input_stacks):
			recipe_cache = recipe
			output_slot.set_output_preview(recipe.get_result())
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
