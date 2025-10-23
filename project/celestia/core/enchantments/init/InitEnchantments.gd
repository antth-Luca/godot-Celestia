extends Node
class_name InitEnchantments

static var ENCHANTMENTS: DeferredRegister
# Enchantments
static var CONSERVATION: DeferredHolder
static var DEVOUR: DeferredHolder


static func setup() -> void:
	ENCHANTMENTS = DeferredRegister.create(
		Celestia.GAME_ID,
		EnchantmentRegistry.REGISTRY_TYPE
	)

	# Enchantments
	CONSERVATION = ENCHANTMENTS.add_entry(
		'conservation',
		func(): return ConservationEnchantment.new(1)
	)

	DEVOUR = ENCHANTMENTS.add_entry(
		'devour',
		func(): return DevourEnchantment.new(1)
	)

	ENCHANTMENTS.register()
