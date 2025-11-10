extends Node
class_name InitFertilizers

static var FERTILIZERS: DeferredRegister
# Fertilizers
static var BONE: DeferredHolder
static var MANURE: DeferredHolder

static func setup() -> void:
	FERTILIZERS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Fertilizers
	BONE = FERTILIZERS.add_entry(
		'bone',
		func():
			var fertilizer = BaseFertilizer.new()
			fertilizer.power = .2
			return fertilizer
	)

	MANURE = FERTILIZERS.add_entry(
		'manure',
		func():
			var fertilizer = BaseFertilizer.new()
			fertilizer.power = .4
			return fertilizer
	)

	FERTILIZERS.register()
