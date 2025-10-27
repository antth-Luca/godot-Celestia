extends Node
class_name InitEnchantments

static var ENCHANTMENTS: DeferredRegister
# Enchantments
static var COMPULSION: DeferredHolder
static var CONSERVATION: DeferredHolder
static var DEVOUR: DeferredHolder
static var FREEZING_AIR: DeferredHolder
static var HULL_REINFORCEMENT: DeferredHolder
static var IGNITION: DeferredHolder
static var INTIMIDATION: DeferredHolder
static var SAWED_OFF: DeferredHolder


static func setup() -> void:
	ENCHANTMENTS = DeferredRegister.create(
		Celestia.GAME_ID,
		EnchantmentRegistry.REGISTRY_TYPE
	)

	# Enchantments
	COMPULSION = ENCHANTMENTS.add_entry(
		'compulsion',
		func(): return CompulsionEnchantment.new(1)
	)

	CONSERVATION = ENCHANTMENTS.add_entry(
		'conservation',
		func(): return ConservationEnchantment.new(1)
	)

	DEVOUR = ENCHANTMENTS.add_entry(
		'devour',
		func(): return DevourEnchantment.new(1)
	)

	FREEZING_AIR = ENCHANTMENTS.add_entry(
		'freezing_air',
		func(): return FreezingAirEnchantment.new(1)
	)

	HULL_REINFORCEMENT = ENCHANTMENTS.add_entry(
		'hull_reinforcement',
		func(): return HullReinforcementEnchantment.new(1)
	)

	IGNITION = ENCHANTMENTS.add_entry(
		'ignition',
		func(): return IgnitionEnchantment.new(1)
	)

	INTIMIDATION = ENCHANTMENTS.add_entry(
		'intimidation',
		func(): return IntimidationEnchantment.new(1)
	)

	SAWED_OFF = ENCHANTMENTS.add_entry(
		'sawed_off',
		func(): return SawedOffEnchantment.new(1)
	)

	ENCHANTMENTS.register()
