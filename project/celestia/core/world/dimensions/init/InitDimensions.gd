extends Node
class_name InitDimensions

static var DIMENSIONS: DeferredRegister
# Dimensions
static var CAVES: DeferredHolder
static var SURFACE: DeferredHolder


static func setup() -> void:
	DIMENSIONS = DeferredRegister.create(
		Celestia.GAME_ID,
		DimensionRegistry.REGISTRY_TYPE
	)

	# Dimensions
	CAVES = DIMENSIONS.add_entry(
		'caves',
		func(): return preload('res://core/world/dimensions/custom/caves/Caves.tscn').instantiate()
	)

	SURFACE = DIMENSIONS.add_entry(
		'surface',
		func(): return preload('res://core/world/dimensions/custom/surface/Surface.tscn').instantiate()
	)

	DIMENSIONS.register()
