extends Control

@onready var input_slot: InputSlot = $InputSlot
@onready var output_slot: OutputSlot = $OutputSlot
@onready var interact_star: InteractConfirm = $InteractConfirm

var can_set_input := true
var recipe_cache: BlessingRecipe

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
	output_slot.player = player


func try_find_recipe() -> void:
	# Try to find a valid and compatible recipe. If find one, set the preview and enable the interaction hammer.
	# BEGIN: Extract the stacks from the input slots...
	var input_stacks: Array[ItemStack]
	if not input_slot.stack.is_empty(): input_stacks.append(input_slot.stack)
	# ...If there is a revenue cache and it is valid, we use...
	if recipe_cache and recipe_cache.matches(input_stacks):
		output_slot.stack = recipe_cache.get_result()
		output_slot.set_preview()
		interact_star.enable_interaction()
		return
	# ...Get the recipes allowed per workstation and per ingredient...
	var registry: RecipeRegistry = RegistryManager.registries[RecipeRegistry.REGISTRY_TYPE]
	var per_workstation: Array = registry._per_workstation.get(get_parent().selected).duplicate()
	var per_ingredient: Dictionary[ResourceLocation, Array] = registry._per_ingredient
	# ...Filter recipes by input ingredients...
	if not input_stacks.is_empty() and per_ingredient.has(input_stacks.front()):
		var by_ingred: Array[ResourceLocation] = per_ingredient[input_stacks.front().item.id]
		per_workstation = per_workstation.filter(func(id): return id in by_ingred)
	# ...Tests each candidate recipe...
	for possible in per_workstation:
		var recipe: BlessingRecipe = registry._registries[possible].call()
		if recipe and recipe.matches(input_stacks):
			recipe_cache = recipe
			output_slot.stack = recipe.get_result()
			output_slot.set_preview()
			interact_star.enable_interaction()
			return


func cleanup_craft() -> void:
	# Enables new inputs and sets the recipe cache.
	can_set_input = true
	input_slot.stack = ItemStack.EMPTY
