extends Control

@onready var inputs: Array[InputSlot] = [
	$InputSlot,
	$InputSlot2,
	$InputSlot3,
	$InputSlot4,
	$InputSlot5,
]
@onready var output_slot: OutputSlot = $OutputSlot
@onready var interact_hammer: InteractConfirm = $InteractConfirm

var can_set_input := true
var recipe_cache: BaseRecipe
var pillar_dict: Dictionary[StarForge.EnergyType, BaseStructure]

# GODOT
func _ready() -> void:
	for slot in inputs:
		slot.connect('slot_item_added', Callable(self, 'try_find_recipe'))
		slot.connect('slot_item_removed', Callable(self, 'try_find_recipe'))
	output_slot.connect('slot_item_removed', Callable(self, 'cleanup_craft'))

# MAIN
func fill_children(player: Player) -> void:
	for slot in inputs:
		slot.player = player


func calc_total_energies() -> Dictionary[StarForge.EnergyType, float]:
	var total_energies: Dictionary[StarForge.EnergyType, float] = { StarForge.EnergyType.STAR: 0, StarForge.EnergyType.LUNAR: 0 }
	for key in pillar_dict.keys():
		var calc: float = 0
		for pillar in pillar_dict[key]:
			calc += pillar.stored_energy
		total_energies[key] = calc
	return total_energies


func try_find_recipe() -> void:
	# Try to find a valid and compatible recipe. If find one, set the preview and enable the interaction hammer.
	# BEGIN: Extract the stacks from the input slots...
	var input_stacks: Array[ItemStack]
	var stored_energies: Dictionary[StarForge.EnergyType, float] = calc_total_energies()
	for slot in inputs:
		var stack: ItemStack = slot.stack
		if not stack.is_empty(): input_stacks.append(stack)
	# ...If there is a revenue cache and it is valid, we use...
	if recipe_cache:
		if recipe_cache is CraftingRecipe and get_parent().selected.front() == CraftingRecipe.WorkstationType.STAR_FORGE:
			if not stored_energies[StarForge.EnergyType.STAR] < recipe_cache.required_star_energy or not stored_energies[StarForge.EnergyType.LUNAR] < recipe_cache.required_lunar_energy:
				if recipe_cache.matches(input_stacks):
					if recipe_cache is EnchantRecipe:
						output_slot.stack = recipe_cache.get_enchanted_result(input_stacks.front().item)
					else:
						output_slot.stack = recipe_cache.get_result()
					output_slot.set_preview()
					interact_hammer.enable_interaction()
					return
	# ...Get the recipes allowed per workstation and per ingredient...
	var registry: RecipeRegistry = RegistryManager.registries[RecipeRegistry.REGISTRY_TYPE]
	var per_workstation: Array
	for workstation_type in get_parent().selected:
		per_workstation.append_array(registry._per_workstation.get(workstation_type).duplicate())
	var per_ingredient: Dictionary[ResourceLocation, Array] = registry._per_ingredient
	# ...Filter recipes by input ingredients...
	for stack in input_stacks:
		if per_ingredient.has(stack.item.id):
			var by_ingred: Array[ResourceLocation] = per_ingredient[stack.item.id]
			per_workstation = per_workstation.filter(func(id): return id in by_ingred)
	# ...Tests each candidate recipe...
	for possible in per_workstation:
		var recipe: BaseRecipe = registry._registries[possible].call()
		if recipe:
			if recipe is CraftingRecipe and get_parent().selected.front() == CraftingRecipe.WorkstationType.STAR_FORGE:
				if stored_energies[StarForge.EnergyType.STAR] < recipe.required_star_energy or stored_energies[StarForge.EnergyType.LUNAR] < recipe.required_lunar_energy:
					continue
			if recipe.matches(input_stacks):
				recipe_cache = recipe
				if recipe is EnchantRecipe:
					output_slot.stack = recipe.get_enchanted_result(input_stacks.front().item)
				else:
					output_slot.stack = recipe.get_result()
				output_slot.set_preview()
				interact_hammer.enable_interaction()
				return


func cleanup_craft() -> void:
	# Enables new inputs and sets the recipe cache.
	for slot in inputs:
		slot.stack = ItemStack.EMPTY
		can_set_input = true
	# Sub energies
	if recipe_cache is CraftingRecipe and get_parent().selected.front() == CraftingRecipe.WorkstationType.STAR_FORGE:
		# Star
		var remaining_star: float = recipe_cache.required_star_energy
		for pillar in pillar_dict[StarForge.EnergyType.STAR]:
			if not remaining_star > 0: break
			var available: float = pillar.stored_energy
			if not available < remaining_star:
				pillar.stored_energy -= remaining_star
				remaining_star = 0
			else:
				pillar.stored_energy = 0
				remaining_star -= available
		# Lunar
		var remaining_lunar: float = recipe_cache.required_lunar_energy
		for pillar in pillar_dict[StarForge.EnergyType.LUNAR]:
			if not remaining_lunar > 0: break
			var available: float = pillar.stored_energy
			if not available < remaining_lunar:
				pillar.stored_energy -= remaining_lunar
				remaining_lunar = 0
			else:
				pillar.stored_energy = 0
				remaining_lunar -= available
