extends Node
class_name InitRecipes

static var RECIPES: DeferredRegister
# Enchantment
# Normal
static var IRON_PICKAXE: DeferredHolder
# Random output
# With return


static func setup() -> void:
	RECIPES = DeferredRegister.create(
		Celestia.GAME_ID,
		RecipeRegistry.REGISTRY_TYPE
	)

	# Normal
	IRON_PICKAXE = RECIPES.add_entry(
		'iron_pickaxe',
		func():
			var recipe = NormalRecipe.new()
			recipe.set_result(InitTools.IRON_PICKAXE, 1)
			recipe.workstation = WorkstationTypes.MANUAL
			recipe.add_ingredient(InitItems.STICK, 2)
			recipe.add_ingredient(InitItems.IRON_INGOT, 4)
			return recipe
	)

	RECIPES.register()
