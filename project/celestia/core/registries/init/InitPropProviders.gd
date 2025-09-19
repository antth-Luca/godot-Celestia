extends Node
class_name InitPropProviders

static var PROVIDERS: DeferredRegister
# Items
static var ARMOR: DeferredHolder
static var COOLDOWN_REDUCTION: DeferredHolder
static var CRITICAL_STRIKE: DeferredHolder
static var DAMAGE_REDUCTION: DeferredHolder
static var DEFENSE_REDUCTION: DeferredHolder
static var FORCE: DeferredHolder
static var HEALTH: DeferredHolder
static var LIFE_STEAL: DeferredHolder
static var MANA: DeferredHolder
static var MOVE_SPEED: DeferredHolder
static var PENETRATION: DeferredHolder
static var RANGE: DeferredHolder
static var RESISTANCE: DeferredHolder
static var HUNGRY: DeferredHolder
static var SURVIVOR_LEVEL: DeferredHolder
static var USE_SPEED: DeferredHolder


static func setup() -> void:
	PROVIDERS = DeferredRegister.create(
		Celestia.GAME_ID,
		PropProviderRegistry.REGISTRY_TYPE
	)

	# Providers
	ARMOR = PROVIDERS.add_entry(
		'armor', func(): return ArmorProvider.new()
	)

	COOLDOWN_REDUCTION = PROVIDERS.add_entry(
		'cooldown_reduction', func(): return CooldownReductionProvider.new()
	)

	CRITICAL_STRIKE = PROVIDERS.add_entry(
		'critical_strike', func(): return CriticalStrikeProvider.new()
	)

	DAMAGE_REDUCTION = PROVIDERS.add_entry(
		'damage_reduction', func(): return DamageReductionProvider.new()
	)

	DEFENSE_REDUCTION = PROVIDERS.add_entry(
		'defense_reduction', func(): return DefenseReductionProvider.new()
	)

	FORCE = PROVIDERS.add_entry(
		'force', func(): return ForceProvider.new()
	)

	HEALTH = PROVIDERS.add_entry(
		'health', func(): return HealthProvider.new()
	)

	LIFE_STEAL = PROVIDERS.add_entry(
		'life_steal', func(): return LifeStealProvider.new()
	)

	MANA = PROVIDERS.add_entry(
		'mana', func(): return ManaProvider.new()
	)

	MOVE_SPEED = PROVIDERS.add_entry(
		'move_speed', func(): return MoveSpeedProvider.new()
	)

	PENETRATION = PROVIDERS.add_entry(
		'penetration', func(): return PenetrationProvider.new()
	)

	RANGE = PROVIDERS.add_entry(
		'range', func(): return RangeProvider.new()
	)

	RESISTANCE = PROVIDERS.add_entry(
		'resistance', func(): return ResistanceProvider.new()
	)

	HUNGRY = PROVIDERS.add_entry(
		'hungry', func(): return HungryProvider.new()
	)

	SURVIVOR_LEVEL = PROVIDERS.add_entry(
		'survivor_level', func(): return SurvivorLevelProvider.new()
	)

	USE_SPEED = PROVIDERS.add_entry(
		'use_speed', func(): return UseSpeedProvider.new()
	)

	PROVIDERS.register()
