extends Node
class_name InitLootBoxes

static var LOOT_BOXES: DeferredRegister
# Animals
static var CHICKEN_DEATH: DeferredHolder
static var CHICKEN_LAY: DeferredHolder
# Monsters
static var ZOMBIE_DEATH: DeferredHolder


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
				1
			)
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
				InitItems.BONE,
				1, 2,
				.2
			)
			return box
	)

	LOOT_BOXES.register()
