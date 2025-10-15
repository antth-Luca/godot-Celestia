extends Node
class_name InitEffects

static var EFFECTS: DeferredRegister
# Beneficial
# Neutral
# Maleficial
static var STUN: DeferredHolder
static var POISON: DeferredHolder



static func setup() -> void:
	EFFECTS = DeferredRegister.create(
		Celestia.GAME_ID,
		EffectRegistry.REGISTRY_TYPE
	)

	# Beneficial
	# Neutral
	# Maleficial
	STUN = EFFECTS.add_entry(
		'stun',
		func(): return StunEffect.new()
	)

	POISON = EFFECTS.add_entry(
		'poison',
		func(): return PoisonEffect.new()
	)

	EFFECTS.register()
