extends Node
class_name InitItems

static var ITEMS: DeferredRegister
# Items
static var EGG: DeferredHolder
static var GOLD_INGOT: DeferredHolder
static var IRON_INGOT: DeferredHolder


static func setup() -> void:
	ITEMS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Items
	EGG = ITEMS.add_entry(
		'egg',
		func():
			var item = BaseItem.new()
			item.set_max_stack(12)
			return item
	)

	GOLD_INGOT = ITEMS.add_entry(
		'gold_ingot',
		func():
			return BaseItem.new()
	)

	IRON_INGOT = ITEMS.add_entry(
		'iron_ingot',
		func():
			return BaseItem.new()
	)

	ITEMS.register()
