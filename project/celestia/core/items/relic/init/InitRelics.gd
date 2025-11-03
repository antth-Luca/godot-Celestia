extends Node
class_name InitRelics

static var RELICS: DeferredRegister
# Relics
static var BLOOD_ORB: DeferredHolder
static var CLAWED_GLOVE: DeferredHolder
static var COIN_OF_BABYLON: DeferredHolder
static var COLLECTORS_GLOVE: DeferredHolder
static var COSMIC_FOCUS: DeferredHolder
static var EXPLORERS_KIT: DeferredHolder
static var EYE_OF_THE_STORM: DeferredHolder
static var PALE_ROSE: DeferredHolder
static var VITAL_CORE: DeferredHolder


static func setup() -> void:
	RELICS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Relics
	BLOOD_ORB = RELICS.add_entry(
		'blood_orb',
		func(): return BloodOrbRelic.new()
	)

	CLAWED_GLOVE = RELICS.add_entry(
		'clawed_glove',
		func(): return ClawedGloveRelic.new()
	)

	COIN_OF_BABYLON = RELICS.add_entry(
		'coin_of_babylon',
		func(): return CoinOfBabylonRelic.new()
	)

	COLLECTORS_GLOVE = RELICS.add_entry(
		'collectors_glove',
		func(): return CollectorsGloveRelic.new()
	)

	COSMIC_FOCUS = RELICS.add_entry(
		'cosmic_focus',
		func(): return CosmicFocusRelic.new()
	)

	EXPLORERS_KIT = RELICS.add_entry(
		'explorers_kit',
		func(): return ExplorersKitRelic.new()
	)

	EYE_OF_THE_STORM = RELICS.add_entry(
		'eye_of_the_storm',
		func(): return EyeOfTheStormRelic.new()
	)

	PALE_ROSE = RELICS.add_entry(
		'pale_rose',
		func(): return PaleRoseRelic.new()
	)

	VITAL_CORE = RELICS.add_entry(
		'vital_core',
		func(): return VitalCoreRelic.new()
	)

	RELICS.register()
