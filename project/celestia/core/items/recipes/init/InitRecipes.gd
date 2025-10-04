extends Node
class_name InitRecipes

static var RECIPES: DeferredRegister
# Enchantment
# Normal
static var BOILED_EGG: DeferredHolder
static var IRON_PICKAXE: DeferredHolder
static var IRON_SWORD: DeferredHolder
# Random output
# With return


static func setup() -> void:
	RECIPES = DeferredRegister.create(
		Celestia.GAME_ID,
		RecipeRegistry.REGISTRY_TYPE
	)

	# Normal
	BOILED_EGG = RECIPES.add_entry(
		'boiled_egg',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitFoods.BOILED_EGG, 1))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitFoods.EGG, 1)
			return recipe
	)

	IRON_PICKAXE = RECIPES.add_entry(
		'iron_pickaxe',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitTools.IRON_PICKAXE, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.MANUAL)
			recipe.add_ingredient(InitFuels.STICK, 2)
			recipe.add_ingredient(InitItems.IRON_INGOT, 4)
			return recipe
	)

	IRON_SWORD = RECIPES.add_entry(
		'iron_sword',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitWeapons.IRON_SWORD, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.MANUAL)
			recipe.add_ingredient(InitFuels.STICK, 2)
			recipe.add_ingredient(InitItems.IRON_INGOT, 2)
			return recipe
	)

	RECIPES.register()
