extends Node
class_name InitRecipes

static var RECIPES: DeferredRegister
# Enchantment
static var ENCHANT_CONSERVATION: DeferredHolder
# Normal
static var BOILED_EGG: DeferredHolder
static var BOW: DeferredHolder
static var IRON_AXE: DeferredHolder
static var IRON_PICKAXE: DeferredHolder
static var IRON_SWORD: DeferredHolder
static var PAPYRUS: DeferredHolder
static var STARDUST_ALTRUISM: DeferredHolder
static var STARDUST_AMBITION: DeferredHolder
static var STARDUST_ASCENDANCE: DeferredHolder
static var STARDUST_CALM: DeferredHolder
static var STARDUST_CHAOS: DeferredHolder
static var STARDUST_CREATION: DeferredHolder
static var STARDUST_DESTRUCTION: DeferredHolder
static var STARDUST_EFEMERALITY: DeferredHolder
static var STARDUST_ILLUSION: DeferredHolder
static var STARDUST_PERMANENCE: DeferredHolder
static var STARDUST_PROTECTION: DeferredHolder
static var STARDUST_SUBMISSION: DeferredHolder
static var STARDUST_TRUTH: DeferredHolder
static var STARDUST_WAR: DeferredHolder
# Random output
static var CONSTELLATION_SCROLLS: DeferredHolder
# With return


static func setup() -> void:
	RECIPES = DeferredRegister.create(
		Celestia.GAME_ID,
		RecipeRegistry.REGISTRY_TYPE
	)

	# Enchantment
	ENCHANT_CONSERVATION = RECIPES.add_entry(
		'enchant_conservation',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.CONSERVATION.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_PERMANENCE, 1)
			recipe.add_ingredient(InitItems.SCROLL_CREATION, 1)
			return recipe
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

	STARDUST_ALTRUISM = RECIPES.add_entry(
		'stardust_altruism',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_ALTRUISM, 1)
			return recipe
	)

	STARDUST_AMBITION = RECIPES.add_entry(
		'stardust_ambition',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_AMBITION, 1)
			return recipe
	)

	STARDUST_ASCENDANCE = RECIPES.add_entry(
		'stardust_ascendance',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_ASCENDANCE, 1)
			return recipe
	)

	STARDUST_CALM = RECIPES.add_entry(
		'stardust_calm',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_CALM, 1)
			return recipe
	)

	STARDUST_CHAOS = RECIPES.add_entry(
		'stardust_chaos',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_CHAOS, 1)
			return recipe
	)

	STARDUST_CREATION = RECIPES.add_entry(
		'stardust_creation',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_CREATION, 1)
			return recipe
	)

	STARDUST_DESTRUCTION = RECIPES.add_entry(
		'stardust_destruction',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_DESTRUCTION, 1)
			return recipe
	)

	STARDUST_EFEMERALITY = RECIPES.add_entry(
		'stardust_efemerality',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_EFEMERALITY, 1)
			return recipe
	)

	STARDUST_ILLUSION = RECIPES.add_entry(
		'stardust_illusion',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_ILLUSION, 1)
			return recipe
	)

	STARDUST_PERMANENCE = RECIPES.add_entry(
		'stardust_permanence',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_PERMANENCE, 1)
			return recipe
	)

	STARDUST_PROTECTION = RECIPES.add_entry(
		'stardust_protection',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_PROTECTION, 1)
			return recipe
	)

	STARDUST_SUBMISSION = RECIPES.add_entry(
		'stardust_submission',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_SUBMISSION, 1)
			return recipe
	)

	STARDUST_TRUTH = RECIPES.add_entry(
		'stardust_truth',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_TRUTH, 1)
			return recipe
	)

	STARDUST_WAR = RECIPES.add_entry(
		'stardust_war',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.STARDUST, 2))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 1
			recipe.add_ingredient(InitItems.SCROLL_WAR, 1)
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
