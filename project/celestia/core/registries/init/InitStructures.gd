extends Node
class_name InitStructures

static var STRUCTURES: DeferredRegister
# Buildable
static var BED: DeferredHolder


static func setup() -> void:
	STRUCTURES = DeferredRegister.create(
		Celestia.GAME_ID,
		StructureRegistry.REGISTRY_TYPE
	)

	# Buildable
	BED = STRUCTURES.add_entry(
		'bed',
		func():
			return preload('res://core/structures/bed/Bed.tscn')
	)

	STRUCTURES.register()
