extends Node
class_name InitItems

static var ITEMS: DeferredRegister
# Items
static var BONE: DeferredHolder
static var GOLD_INGOT: DeferredHolder
static var IRON_INGOT: DeferredHolder
static var PLANT_FIBER: DeferredHolder


static func setup() -> void:
	ITEMS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Items
	BONE = ITEMS.add_entry(
		'bone',
		func(): return BaseItem.new()
	)

	GOLD_INGOT = ITEMS.add_entry(
		'gold_ingot',
		func(): return BaseItem.new()
	)

	IRON_INGOT = ITEMS.add_entry(
		'iron_ingot',
		func(): return BaseItem.new()
	)

	PLANT_FIBER = ITEMS.add_entry(
		'plant_fiber',
		func(): return BaseItem.new()
	)

	ITEMS.register()
