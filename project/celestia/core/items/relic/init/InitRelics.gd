extends Node
class_name InitRelics

static var RELICS: DeferredRegister
# Relics
static var EXPLORERS_KIT: DeferredHolder
static var BLOOD_ORB: DeferredHolder


static func setup() -> void:
	RELICS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Relics
	EXPLORERS_KIT = RELICS.add_entry(
		'explorers_kit',
		func(): return ExplorersKitRelic.new()
	)

	BLOOD_ORB = RELICS.add_entry(
		'blood_orb',
		func(): return BloodOrbRelic.new()
	)

	RELICS.register()
