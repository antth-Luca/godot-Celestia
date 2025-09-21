extends Node
class_name InitLootBoxes

static var LOOT_BOXES: DeferredRegister
# Entities
static var ZOMBIE: DeferredHolder


static func setup() -> void:
	LOOT_BOXES = DeferredRegister.create(
		Celestia.GAME_ID,
		LootBoxRegistry.REGISTRY_TYPE
	)

	# Entities
	ZOMBIE = LOOT_BOXES.add_entry(
		'zombie',
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
