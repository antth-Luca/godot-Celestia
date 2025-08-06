extends Object
class_name InitItems

static var EGG: BaseItem
static var GOLD_INGOT: BaseItem


static func setup() -> void:
	var ITEMS = DeferredRegister.new(
		Celestia.GAME_ID,
		RegistryManager.ITEM_REGISTRY
	)

	EGG = ITEMS.register(
		'egg',
		func():
			var item = BaseItem.new()
			item.set_max_stack(12)
			return item
	)

	GOLD_INGOT = ITEMS.register(
		'gold_ingot',
		func():
			return BaseItem.new()
	)
