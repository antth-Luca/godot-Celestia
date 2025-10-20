extends Node
class_name InitEnchantments

static var ENCHANTMENTS: DeferredRegister
# Base items
static var CONSERVATION: DeferredHolder


static func setup() -> void:
	ENCHANTMENTS = DeferredRegister.create(
		Celestia.GAME_ID,
		EnchantmentRegistry.REGISTRY_TYPE
	)

	# Base items
	CONSERVATION = ENCHANTMENTS.add_entry(
		'conservation',
		func(): return ConservationEnchantment.new(1)
	)

	ENCHANTMENTS.register()
