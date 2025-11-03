extends Node
class_name InitRelics

static var RELICS: DeferredRegister
# Relics
static var COIN_OF_BABYLON: DeferredHolder
static var COLLECTORS_GLOVE: DeferredHolder
static var EXPLORERS_KIT: DeferredHolder
static var BLOOD_ORB: DeferredHolder
static var VITAL_CORE: DeferredHolder


static func setup() -> void:
	RELICS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Relics
	COIN_OF_BABYLON = RELICS.add_entry(
		'coin_of_babylon',
		func(): return CoinOfBabylonRelic.new()
	)

	COLLECTORS_GLOVE = RELICS.add_entry(
		'collectors_glove',
		func(): return CollectorsGloveRelic.new()
	)

	EXPLORERS_KIT = RELICS.add_entry(
		'explorers_kit',
		func(): return ExplorersKitRelic.new()
	)

	BLOOD_ORB = RELICS.add_entry(
		'blood_orb',
		func(): return BloodOrbRelic.new()
	)

	VITAL_CORE = RELICS.add_entry(
		'vital_core',
		func(): return VitalCoreRelic.new()
	)

	RELICS.register()
