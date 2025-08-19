extends Node
class_name InitPropProviders

static var PROVIDERS: DeferredRegister
# Items
static var HEALTH: DeferredHolder
static var ARMOR: DeferredHolder
static var COOLDOWN_REDUCTION: DeferredHolder


static func setup() -> void:
	PROVIDERS = DeferredRegister.create(
		Celestia.GAME_ID,
		PropProviderRegistry.REGISTRY_TYPE
	)

	# Items
	HEALTH = PROVIDERS.add_entry(
		'health', func(): return HealthProvider.new()
	)

	ARMOR = PROVIDERS.add_entry(
		'armor', func(): return ArmorProvider.new()
	)

	COOLDOWN_REDUCTION = PROVIDERS.add_entry(
		'cooldown_reduction', func(): return CooldownReductionProvider.new()
	)

	PROVIDERS.register()
