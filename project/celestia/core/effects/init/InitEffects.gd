extends Node
class_name InitEffects

static var EFFECTS: DeferredRegister
# Beneficial
# Neutral
# Maleficial
static var STUN: DeferredHolder
static var VENOM: DeferredHolder



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

	VENOM = EFFECTS.add_entry(
		'venom',
		func(): return VenomEffect.new()
	)

	EFFECTS.register()
