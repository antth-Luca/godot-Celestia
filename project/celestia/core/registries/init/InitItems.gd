extends Object
class_name InitItems


static func setup() -> void:
	var ITEMS = DeferredRegister.new(
		Celestia.GAME_ID,
		RegistryManager.ITEM_REGISTRY
	)

	var EGG = ITEMS.register(
		"egg", func(): BaseItem.new(Rarity.COMMON, 12))
