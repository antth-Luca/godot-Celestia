extends Node
class_name InitRecipes

static var RECIPES: DeferredRegister
# Enchantment
static var ENCHANT_AMMUNITION_ECO: DeferredHolder
static var ENCHANT_COMPULSION: DeferredHolder
static var ENCHANT_CONSERVATION: DeferredHolder
static var ENCHANT_DEVOUR: DeferredHolder
static var ENCHANT_FAITHLESS_DEFENSE: DeferredHolder
static var ENCHANT_FIGHTING_SPIRIT: DeferredHolder
static var ENCHANT_FREEZING_AIR: DeferredHolder
static var ENCHANT_HULL_REINFORCEMENT: DeferredHolder
static var ENCHANT_IGNITION: DeferredHolder
static var ENCHANT_IMPULSE: DeferredHolder
static var ENCHANT_INTIMIDATION: DeferredHolder
static var ENCHANT_LETHAL_INITIATION: DeferredHolder
static var ENCHANT_SAWED_OFF: DeferredHolder
static var ENCHANT_UNBOUND: DeferredHolder
# Normal
static var BOILED_EGG: DeferredHolder
static var BOW: DeferredHolder
static var CARNIGO_INGOT: DeferredHolder
static var COMPASS: DeferredHolder
static var ERUPTITE_INGOT: DeferredHolder
static var IRON_AXE: DeferredHolder
static var IRON_PICKAXE: DeferredHolder
static var IRON_SWORD: DeferredHolder
static var PAPYRUS: DeferredHolder
#  Stardust
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
#  Scroll
static var CONSTELLATION_SCROLLS: DeferredHolder
# With return


static func setup() -> void:
	RECIPES = DeferredRegister.create(
		Celestia.GAME_ID,
		RecipeRegistry.REGISTRY_TYPE
	)

	# Enchantment
	ENCHANT_AMMUNITION_ECO = RECIPES.add_entry(
		'enchant_ammunition_eco',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.AMMUNITION_ECO.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_ILLUSION, 1)
			recipe.add_ingredient(InitItems.SCROLL_SUBMISSION, 1)
			return recipe
	)

	ENCHANT_COMPULSION = RECIPES.add_entry(
		'enchant_compulsion',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.COMPULSION.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_AMBITION, 1)
			recipe.add_ingredient(InitItems.SCROLL_ASCENDANCE, 1)
			return recipe
	)

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

	ENCHANT_DEVOUR = RECIPES.add_entry(
		'enchant_devour',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.DEVOUR.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_DESTRUCTION, 1)
			recipe.add_ingredient(InitItems.SCROLL_SUBMISSION, 1)
			return recipe
	)

	ENCHANT_FAITHLESS_DEFENSE = RECIPES.add_entry(
		'enchant_faithless_defense',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.FAITHLESS_DEFENSE.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_PROTECTION, 1)
			recipe.add_ingredient(InitItems.SCROLL_DESTRUCTION, 1)
			recipe.add_ingredient(InitItems.SCROLL_TRUTH, 1)
			return recipe
	)

	ENCHANT_FIGHTING_SPIRIT = RECIPES.add_entry(
		'enchant_fighting_spirit',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.FIGHTING_SPIRIT.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_WAR, 1)
			recipe.add_ingredient(InitItems.SCROLL_PERMANENCE, 1)
			return recipe
	)

	ENCHANT_FREEZING_AIR = RECIPES.add_entry(
		'enchant_freezing_air',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.FREEZING_AIR.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_SUBMISSION, 1)
			recipe.add_ingredient(InitItems.SCROLL_EFEMERALITY, 1)
			return recipe
	)

	ENCHANT_HULL_REINFORCEMENT = RECIPES.add_entry(
		'enchant_hull_reinforcement',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.HULL_REINFORCEMENT.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_CREATION, 1)
			recipe.add_ingredient(InitItems.SCROLL_PROTECTION, 1)
			return recipe
	)

	ENCHANT_IGNITION = RECIPES.add_entry(
		'enchant_ignition',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.IGNITION.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_DESTRUCTION, 1)
			recipe.add_ingredient(InitItems.SCROLL_EFEMERALITY, 1)
			return recipe
	)

	ENCHANT_IMPULSE = RECIPES.add_entry(
		'enchant_impulse',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.IMPULSE.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_TRUTH, 1)
			recipe.add_ingredient(InitItems.SCROLL_WAR, 1)
			return recipe
	)

	ENCHANT_INTIMIDATION = RECIPES.add_entry(
		'enchant_intimidation',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.INTIMIDATION.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_ALTRUISM, 1)
			recipe.add_ingredient(InitItems.SCROLL_CHAOS, 1)
			recipe.add_ingredient(InitItems.SCROLL_ASCENDANCE, 1)
			return recipe
	)

	ENCHANT_LETHAL_INITIATION = RECIPES.add_entry(
		'enchant_lethal_initiation',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.LETHAL_INITIATION.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_WAR, 1)
			recipe.add_ingredient(InitItems.SCROLL_SUBMISSION, 1)
			return recipe
	)

	ENCHANT_SAWED_OFF = RECIPES.add_entry(
		'enchant_sawed_off',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.SAWED_OFF.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_AMBITION, 1)
			recipe.add_ingredient(InitItems.SCROLL_CHAOS, 1)
			return recipe
	)

	ENCHANT_UNBOUND = RECIPES.add_entry(
		'enchant_unbound',
		func():
			var recipe = EnchantRecipe.new()
			recipe.set_workstation(EnchantRecipe.WorkstationType.STAR_FORGE)
			recipe.enchantment = InitEnchantments.UNBOUND.get_registered()
			recipe.add_ingredient(InitItems.SCROLL_TRUTH, 1)
			recipe.add_ingredient(InitItems.SCROLL_ASCENDANCE, 1)
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

	CARNIGO_INGOT = RECIPES.add_entry(
		'carnigo_ingot',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.CARNIGO_INGOT, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitItems.IRON_INGOT, 1)
			recipe.add_ingredient(InitFoods.UNCLEAN_MEAT, 1)
			return recipe
	)

	COMPASS = RECIPES.add_entry(
		'compass',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.COMPASS, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.BENCH)
			recipe.add_ingredient(InitItems.IRON_INGOT, 3)
			return recipe
	)

	ERUPTITE_INGOT = RECIPES.add_entry(
		'eruptite_ingot',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.ERUPTITE_INGOT, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitItems.MAGMA_STONE, 1)
			recipe.add_ingredient(InitItems.FULGURITE, 4)
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
