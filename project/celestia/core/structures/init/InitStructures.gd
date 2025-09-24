extends Node
class_name InitStructures

static var STRUCTURES: DeferredRegister
# Buildable
static var BED: DeferredHolder
# Natural
static var BUSH: DeferredHolder


static func setup() -> void:
	STRUCTURES = DeferredRegister.create(
		Celestia.GAME_ID,
		StructureRegistry.REGISTRY_TYPE
	)

	# Buildable
	BED = STRUCTURES.add_entry(
		'bed',
		func(): return preload('res://core/structures/custom/bed/Bed.tscn').instantiate()
	)

	# Natural
	BUSH = STRUCTURES.add_entry(
		'bush',
		func(): return preload('res://core/structures/custom/bush/Bush.tscn').instantiate()
	)

	STRUCTURES.register()
