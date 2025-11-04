extends Node
class_name InitRelics

static var RELICS: DeferredRegister
# Relics
static var ARCANE_LINES: DeferredHolder
static var ARSENAL_OF_AGES: DeferredHolder
static var BLOOD_ORB: DeferredHolder
static var CLAWED_GLOVE: DeferredHolder
static var COIN_OF_BABYLON: DeferredHolder
static var COLLECTORS_GLOVE: DeferredHolder
static var COSMIC_FOCUS: DeferredHolder
static var CROWN_OF_LUCIDITY: DeferredHolder
static var CYCLOPS_MASK: DeferredHolder
static var EXPLORERS_KIT: DeferredHolder
static var EYE_OF_THE_STORM: DeferredHolder
static var HEART_OF_THE_STORM: DeferredHolder
static var JADE_CHALICE: DeferredHolder
static var LOTUS_BLADES: DeferredHolder
static var MAGMA_CARAPACE: DeferredHolder
static var MECHANICAL_HEART: DeferredHolder
static var ONE_SIDED_PALDRON: DeferredHolder
static var PALE_ROSE: DeferredHolder
static var PERFECTIONISTS_GLOVE: DeferredHolder
static var ROSE_OF_JERICHO: DeferredHolder
static var SHATTERED_AEGIS: DeferredHolder
static var VITAL_CORE: DeferredHolder
static var WINGED_SOCKS: DeferredHolder


static func setup() -> void:
	RELICS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Relics
	ARCANE_LINES = RELICS.add_entry(
		'arcane_lines',
		func(): return ArcaneLinesRelic.new()
	)

	ARSENAL_OF_AGES = RELICS.add_entry(
		'arsenal_of_ages',
		func(): return ArsenalOfAgesRelic.new()
	)

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

	CROWN_OF_LUCIDITY = RELICS.add_entry(
		'crown_of_lucidity',
		func(): return CrownOfLucidityRelic.new()
	)

	CYCLOPS_MASK = RELICS.add_entry(
		'cyclops_mask',
		func(): return CyclopsMaskRelic.new()
	)

	EXPLORERS_KIT = RELICS.add_entry(
		'explorers_kit',
		func(): return ExplorersKitRelic.new()
	)

	EYE_OF_THE_STORM = RELICS.add_entry(
		'eye_of_the_storm',
		func(): return EyeOfTheStormRelic.new()
	)

	HEART_OF_THE_STORM = RELICS.add_entry(
		'heart_of_the_storm',
		func(): return HeartOfTheStormRelic.new()
	)

	JADE_CHALICE = RELICS.add_entry(
		'jade_chalice',
		func(): return JadeChaliceRelic.new()
	)

	LOTUS_BLADES = RELICS.add_entry(
		'lotus_blades',
		func(): return LotusBladesRelic.new()
	)

	MAGMA_CARAPACE = RELICS.add_entry(
		'magma_carapace',
		func(): return MagmaCarapaceRelic.new()
	)

	MECHANICAL_HEART = RELICS.add_entry(
		'mechanical_heart',
		func(): return MechanicHeartRelic.new()
	)

	ONE_SIDED_PALDRON = RELICS.add_entry(
		'one_sided_paldron',
		func(): return OneSidedPaldronRelic.new()
	)

	PALE_ROSE = RELICS.add_entry(
		'pale_rose',
		func(): return PaleRoseRelic.new()
	)

	PERFECTIONISTS_GLOVE = RELICS.add_entry(
		'perfectionists_glove',
		func(): return PerfectionistsGloveRelic.new()
	)

	ROSE_OF_JERICHO = RELICS.add_entry(
		'rose_of_jericho',
		func(): return RoseOfJerichoRelic.new()
	)

	SHATTERED_AEGIS = RELICS.add_entry(
		'shattered_aegis',
		func(): return ShatteredAegisRelic.new()
	)

	VITAL_CORE = RELICS.add_entry(
		'vital_core',
		func(): return VitalCoreRelic.new()
	)

	WINGED_SOCKS = RELICS.add_entry(
		'winged_socks',
		func(): return WingedSocksRelic.new()
	)

	RELICS.register()
