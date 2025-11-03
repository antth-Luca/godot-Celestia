extends Node
class_name InitRelics

static var RELICS: DeferredRegister
# Relics
static var EXPLORERS_KIT: DeferredHolder


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

	RELICS.register()
