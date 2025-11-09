extends Node
class_name InitLootBoxes

static var LOOT_BOXES: DeferredRegister
# Animals
static var CHICKEN_DEATH: DeferredHolder
static var CHICKEN_LAY: DeferredHolder
# Monsters
static var ZOMBIE_DEATH: DeferredHolder
# Recipes
static var CONSTELLATION_SCROLLS: DeferredHolder
# Structures
static var BUSH_DESTROY: DeferredHolder
static var CAVE_HOLE_DIG: DeferredHolder
static var ROSE_BUSH_DESTROY: DeferredHolder


static func setup() -> void:
	LOOT_BOXES = DeferredRegister.create(
		Celestia.GAME_ID,
		LootBoxRegistry.REGISTRY_TYPE
	)

	# Animals
	CHICKEN_DEATH = LOOT_BOXES.add_entry(
		'chicken_death',
		func():
			var box = LootBox.new()
			box.set_cycles(1, 1)
			box.add_output(
				InitFoods.MEAT,
				1, 1,
				.5
			)
			box.add_output(
				InitItems.FEATHER,
				2, 3,
				.5
			)
			return box
	)

	CHICKEN_LAY = LOOT_BOXES.add_entry(
		'chicken_lay',
		func():
			var box = LootBox.new()
			box.set_cycles(1, 1)
			box.add_output(
				InitFoods.EGG,
				1, 2,
				1
			)
			return box
	)

	# Monsters
	ZOMBIE_DEATH = LOOT_BOXES.add_entry(
		'zombie_death',
		func():
			var box = LootBox.new()
			box.set_cycles(1, 2)
			box.add_output(
				InitFoods.UNCLEAN_MEAT,
				1, 3,
				.8
			)
			box.add_output(
				InitFertilizers.BONE,
				1, 2,
				.2
			)
			return box
	)

	# Recipes
	CONSTELLATION_SCROLLS = LOOT_BOXES.add_entry(
		'constellation_scrolls',
		func():
			var box = LootBox.new()
			box.set_cycles(1, 1)
			box.add_output(
				InitItems.SCROLL_ALTRUISM,
				1, 1,
				5.55
			)
			box.add_output(
				InitItems.SCROLL_AMBITION,
				1, 1,
				11.11
			)
			box.add_output(
				InitItems.SCROLL_ASCENDANCE,
				1, 1,
				8.36
			)
			box.add_output(
				InitItems.SCROLL_CALM,
				1, 1,
				5.55
			)
			box.add_output(
				InitItems.SCROLL_CHAOS,
				1, 1,
				5.55
			)
			box.add_output(
				InitItems.SCROLL_CREATION,
				1, 1,
				5.55
			)
			box.add_output(
				InitItems.SCROLL_DESTRUCTION,
				1, 1,
				11.11
			)
			box.add_output(
				InitItems.SCROLL_EFEMERALITY,
				1, 1,
				5.55
			)
			box.add_output(
				InitItems.SCROLL_ILLUSION,
				1, 1,
				5.55
			)
			box.add_output(
				InitItems.SCROLL_PERMANENCE,
				1, 1,
				5.55
			)
			box.add_output(
				InitItems.SCROLL_PROTECTION,
				1, 1,
				5.55
			)
			box.add_output(
				InitItems.SCROLL_SUBMISSION,
				1, 1,
				5.55
			)
			box.add_output(
				InitItems.SCROLL_TRUTH,
				1, 1,
				8.36
			)
			box.add_output(
				InitItems.SCROLL_WAR,
				1, 1,
				11.11
			)
			return box
	)

	# Structures
	BUSH_DESTROY = LOOT_BOXES.add_entry(
		'bush_destroy',
		func():
			var box = LootBox.new()
			box.set_cycles(1, 1)
			box.add_output(
				InitFuels.STICK,
				1, 2,
				.5
			)
			box.add_output(
				InitItems.PLANT_FIBER,
				2, 4,
				.5
			)
			return box
	)

	CAVE_HOLE_DIG = LOOT_BOXES.add_entry(
		'cave_hole_dig',
		func():
			var box = LootBox.new()
			box.set_cycles(1, 1)
			box.add_output(
				InitItems.HANDFUL_OF_DIRT,
				1, 2,
				.6
			)
			box.add_output(
				InitItems.STONE,
				1, 2,
				.4
			)
			return box
	)

	ROSE_BUSH_DESTROY = LOOT_BOXES.add_entry(
		'rose_bush_destroy',
		func():
			var box = LootBox.new()
			box.set_cycles(1, 2)
			box.add_output(
				InitItems.ROSE,
				1, 2,
				.45
			)
			box.add_output(
				InitRelics.PALE_ROSE,
				1, 1,
				.05
			)
			box.add_output(
				InitItems.PLANT_FIBER,
				2, 4,
				.5
			)
			return box
	)

	LOOT_BOXES.register()
