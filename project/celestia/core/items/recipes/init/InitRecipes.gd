extends Node
class_name InitRecipes

static var RECIPES: DeferredRegister
# Enchantment
# Normal
static var BOILED_EGG: DeferredHolder
static var BOW: DeferredHolder
static var IRON_AXE: DeferredHolder
static var IRON_PICKAXE: DeferredHolder
static var IRON_SWORD: DeferredHolder
static var PAPYRUS: DeferredHolder
# Random output
static var CONSTELLATION_SCROLLS: DeferredHolder
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

	BOW = RECIPES.add_entry(
		'bow',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitWeapons.BOW, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.MANUAL)
			recipe.add_ingredient(InitFuels.STICK, 4)
			recipe.add_ingredient(InitItems.PLANT_FIBER, 3)
			return recipe
	)

	IRON_AXE = RECIPES.add_entry(
		'iron_axe',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitTools.IRON_AXE, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.MANUAL)
			recipe.add_ingredient(InitFuels.STICK, 2)
			recipe.add_ingredient(InitItems.IRON_INGOT, 3)
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

	PAPYRUS = RECIPES.add_entry(
		'papyrus',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.PAPYRUS, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.MANUAL)
			recipe.add_ingredient(InitItems.PLANT_FIBER, 2)
			return recipe
	)
	# Random output
	CONSTELLATION_SCROLLS = RECIPES.add_entry(
		'constellation_scrolls',
		func():
			var recipe = RandOutputRecipe.new()
			recipe.set_result(InitLootBoxes.CONSTELLATION_SCROLLS)
			recipe.set_workstation(RandOutputRecipe.WorkstationType.STAR_CHANNEL)
			recipe.add_ingredient(InitItems.PAPYRUS, 1)
			return recipe
	)

	RECIPES.register()
