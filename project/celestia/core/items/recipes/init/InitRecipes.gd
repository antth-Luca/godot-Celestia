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
static var ARCANE_LINES: DeferredHolder
static var ARSENAL_OF_AGES: DeferredHolder
static var ASTRONITE_INGOT: DeferredHolder
static var ASTRONITE_INGOT_BY_ENERGY: DeferredHolder
static var BLOOD_ORB: DeferredHolder
static var BOILED_EGG: DeferredHolder
static var BOW: DeferredHolder
static var CARNIGO_INGOT: DeferredHolder
static var CERAMIC_BOWL: DeferredHolder
static var CLAWED_GLOVE: DeferredHolder
static var CLAY_BOWL: DeferredHolder
static var COLLECTORS_GLOVE: DeferredHolder
static var COMPASS: DeferredHolder
static var COSMIC_FOCUS: DeferredHolder
static var CROWN_OF_LUCIDITY: DeferredHolder
static var CYCLOPS_MASK: DeferredHolder
static var DARK_IRON_INGOT: DeferredHolder
static var ERUPTITE_INGOT: DeferredHolder
static var EXPLORERS_KIT: DeferredHolder
static var GLASS: DeferredHolder
static var HEART_OF_THE_STORM: DeferredHolder
static var IRON_AXE: DeferredHolder
static var IRON_PICKAXE: DeferredHolder
static var IRON_PLATE: DeferredHolder
static var IRON_SWORD: DeferredHolder
static var LINKING_STAFF: DeferredHolder
static var MAGMA_CARAPACE: DeferredHolder
static var MECHANICAL_HEART: DeferredHolder
static var MIRROR: DeferredHolder
static var ONE_SIDED_PALDRON: DeferredHolder
static var PAPYRUS: DeferredHolder
static var PERFECTIONISTS_GLOVE: DeferredHolder
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
	ARCANE_LINES = RECIPES.add_entry(
		'arcane_lines',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.ARCANE_LINES, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitItems.IRON_INGOT, 1)
			recipe.add_ingredient(InitItems.SCROLL_ASCENDANCE, 1)
			return recipe
	)

	ARSENAL_OF_AGES = RECIPES.add_entry(
		'arsenal_of_ages',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.ARSENAL_OF_AGES, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitRelics.CLAWED_GLOVE, 1)
			recipe.add_ingredient(InitRelics.PALE_ROSE, 1)
			recipe.add_ingredient(InitRelics.WINGED_SOCKS, 1)
			recipe.add_ingredient(InitRelics.COSMIC_FOCUS, 1)
			return recipe
	)

	ASTRONITE_INGOT = RECIPES.add_entry(
		'astronite_ingot',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.ASTRONITE_INGOT, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.required_bosses = 1
			recipe.add_ingredient(InitItems.IRON_INGOT, 1)
			recipe.add_ingredient(InitItems.STARDUST, 3)
			return recipe
	)

	ASTRONITE_INGOT_BY_ENERGY = RECIPES.add_entry(
		'astronite_ingot_by_energy',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.ASTRONITE_INGOT, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.required_bosses = 1
			recipe.add_ingredient(InitItems.IRON_INGOT, 1)
			recipe.required_star_energy = 200
			return recipe
	)

	BLOOD_ORB = RECIPES.add_entry(
		'blood_orb',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.BLOOD_ORB, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitItems.CARNIGO_INGOT, 3)
			return recipe
	)

	BOILED_EGG = RECIPES.add_entry(
		'boiled_egg',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitFoods.BOILED_EGG, 1))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.CLAY_FURNACE)
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

	CERAMIC_BOWL = RECIPES.add_entry(
		'ceramic_bowl',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.CERAMIC_BOWL, 1))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.CLAY_FURNACE)
			recipe.melting_point = 3
			recipe.add_ingredient(InitItems.CLAY_BOWL, 1)
			return recipe
	)

	CLAWED_GLOVE = RECIPES.add_entry(
		'clawed_glove',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.CLAWED_GLOVE, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.MANUAL)
			recipe.add_ingredient(InitItems.LEATHER, 1)
			recipe.add_ingredient(InitItems.IRON_INGOT, 2)
			return recipe
	)

	CLAY_BOWL = RECIPES.add_entry(
		'clay_bowl',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.CLAY_BOWL, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.MANUAL)
			recipe.add_ingredient(InitItems.HANDFUL_OF_CLAY, 3)
			return recipe
	)

	COLLECTORS_GLOVE = RECIPES.add_entry(
		'collectors_glove',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.COLLECTORS_GLOVE, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.BENCH)
			recipe.add_ingredient(InitItems.FABRIC, 3)
			recipe.add_ingredient(InitRelics.COIN_OF_BABYLON, 1)
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

	COSMIC_FOCUS = RECIPES.add_entry(
		'cosmic_focus',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.COSMIC_FOCUS, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitItems.IRON_INGOT, 1)
			recipe.add_ingredient(InitItems.RUBY, 2)
			return recipe
	)

	CROWN_OF_LUCIDITY = RECIPES.add_entry(
		'crow_of_lucidity',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.CROWN_OF_LUCIDITY, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitItems.GOLD_INGOT, 3)
			recipe.add_ingredient(InitItems.SCROLL_TRUTH, 1)
			return recipe
	)

	CYCLOPS_MASK = RECIPES.add_entry(
		'cyclops_mask',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.CYCLOPS_MASK, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitRelics.BLOOD_ORB, 1)
			recipe.add_ingredient(InitRelics.PERFECTIONISTS_GLOVE, 1)
			recipe.add_ingredient(InitRelics.LOTUS_BLADES, 1)
			recipe.add_ingredient(InitRelics.HEART_OF_THE_STORM, 1)
			return recipe
	)

	DARK_IRON_INGOT = RECIPES.add_entry(
		'dark_iron_ingot',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.DARK_IRON_INGOT, 2))
			recipe.set_workstation(CraftingRecipe.WorkstationType.BENCH)
			recipe.add_ingredient(InitItems.IRON_PLATE, 2)
			recipe.add_ingredient(InitFuels.COAL, 2)
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

	EXPLORERS_KIT = RECIPES.add_entry(
		'explorers_kit',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.EXPLORERS_KIT, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.BENCH)
			recipe.add_ingredient(InitItems.PAPYRUS, 1)
			recipe.add_ingredient(InitItems.FEATHER, 1)
			recipe.add_ingredient(InitItems.COMPASS, 1)
			return recipe
	)

	GLASS = RECIPES.add_entry(
		'glass',
		func():
			var recipe = SmeltingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.GLASS, 1))
			recipe.set_workstation(SmeltingRecipe.WorkstationType.STONE_FURNACE)
			recipe.melting_point = 3
			recipe.add_ingredient(InitItems.HANDFUL_OF_SAND, 1)
			return recipe
	)

	HEART_OF_THE_STORM = RECIPES.add_entry(
		'heart_of_the_storm',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.HEART_OF_THE_STORM, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitRelics.MECHANICAL_HEART, 1)
			recipe.add_ingredient(InitItems.FULGURITE, 4)
			recipe.add_ingredient(InitItems.OBSIDIAN, 4)
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

	IRON_PLATE = RECIPES.add_entry(
		'iron_plate',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.IRON_PLATE, 2))
			recipe.set_workstation(CraftingRecipe.WorkstationType.BENCH)
			recipe.add_ingredient(InitItems.IRON_INGOT, 2)
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

	LINKING_STAFF = RECIPES.add_entry(
		'linking_staff',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.LINKING_STAFF, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitFuels.STICK, 3)
			recipe.add_ingredient(InitItems.SCROLL_ASCENDANCE, 1)
			return recipe
	)

	MAGMA_CARAPACE = RECIPES.add_entry(
		'magma_carapace',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.MAGMA_CARAPACE, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitItems.IRON_INGOT, 1)
			recipe.add_ingredient(InitItems.ERUPTITE_INGOT, 2)
			return recipe
	)

	MECHANICAL_HEART = RECIPES.add_entry(
		'mechanical_heart',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.MECHANICAL_HEART, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitItems.GOLD_INGOT, 3)
			return recipe
	)

	MIRROR = RECIPES.add_entry(
		'mirror',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitItems.MIRROR, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.BENCH)
			recipe.add_ingredient(InitItems.GLASS, 1)
			recipe.add_ingredient(InitItems.OBSIDIAN, 1)
			recipe.add_ingredient(InitItems.IRON_INGOT, 1)
			return recipe
	)

	ONE_SIDED_PALDRON = RECIPES.add_entry(
		'arsenal_of_ages',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.ONE_SIDED_PALDRON, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitRelics.VITAL_CORE, 1)
			recipe.add_ingredient(InitRelics.JADE_CHALICE, 1)
			recipe.add_ingredient(InitRelics.MAGMA_CARAPACE, 1)
			recipe.add_ingredient(InitRelics.CROWN_OF_LUCIDITY, 1)
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

	PERFECTIONISTS_GLOVE = RECIPES.add_entry(
		'perfectionists_glove',
		func():
			var recipe = CraftingRecipe.new()
			recipe.set_result(Ingredient.new(InitRelics.PERFECTIONISTS_GLOVE, 1))
			recipe.set_workstation(CraftingRecipe.WorkstationType.STAR_FORGE)
			recipe.add_ingredient(InitRelics.COLLECTORS_GLOVE, 1)
			recipe.add_ingredient(InitRelics.ARCANE_LINES, 1)
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
