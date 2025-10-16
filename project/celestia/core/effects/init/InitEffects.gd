extends Node
class_name InitEffects

static var EFFECTS: DeferredRegister
# Beneficial
static var COLD: DeferredHolder
static var HEAT: DeferredHolder
static var REGENERATION: DeferredHolder
# Neutral
# Maleficial
static var BURN: DeferredHolder
static var FREEZE: DeferredHolder
static var STUN: DeferredHolder
static var POISON: DeferredHolder
static var ROOTS: DeferredHolder



static func setup() -> void:
	EFFECTS = DeferredRegister.create(
		Celestia.GAME_ID,
		EffectRegistry.REGISTRY_TYPE
	)

	# Beneficial
	COLD = EFFECTS.add_entry(
		'cold',
		func(): return ColdEffect.new()
	)

	HEAT = EFFECTS.add_entry(
		'heat',
		func(): return HeatEffect.new()
	)

	REGENERATION = EFFECTS.add_entry(
		'regeneration',
		func(): return RegenerationEffect.new()
	)

	# Neutral
	# Maleficial
	BURN = EFFECTS.add_entry(
		'burn',
		func(): return BurnEffect.new()
	)

	FREEZE = EFFECTS.add_entry(
		'freeze',
		func(): return FreezeEffect.new()
	)

	STUN = EFFECTS.add_entry(
		'stun',
		func(): return StunEffect.new()
	)

	POISON = EFFECTS.add_entry(
		'poison',
		func(): return PoisonEffect.new()
	)

	ROOTS = EFFECTS.add_entry(
		'roots',
		func(): return RootsEffect.new()
	)

	EFFECTS.register()
