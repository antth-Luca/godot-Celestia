extends Object
class_name InitItems


static var ITEMS = DeferredRegister.create(
	Celestia.GAME_ID,
	ItemRegistry.REGISTRY_TYPE
)

# Items
static var EGG: DeferredHolder = ITEMS.add_entry(
	'egg',
	func():
		var item = BaseItem.new()
		item.set_max_stack(12)
		return item
)

static var GOLD_INGOT: DeferredHolder = ITEMS.add_entry(
	'gold_ingot',
	func():
		return BaseItem.new()
)

static var IRON_INGOT: DeferredHolder = ITEMS.add_entry(
	'iron_ingot',
	func():
		return BaseItem.new()
)
