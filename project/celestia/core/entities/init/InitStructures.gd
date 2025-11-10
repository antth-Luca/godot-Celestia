extends Node
class_name InitStructures

static var STRUCTURES: DeferredRegister
# Buildable
static var BED: DeferredHolder
static var FARMLAND: DeferredHolder
static var STAR_CHANNEL: DeferredHolder
static var STAR_FORGE: DeferredHolder
static var STONE_FURNACE: DeferredHolder
# Natural
static var BUSH: DeferredHolder
static var CAVE_HOLE: DeferredHolder


static func setup() -> void:
	STRUCTURES = DeferredRegister.create(
		Celestia.GAME_ID,
		StructureRegistry.REGISTRY_TYPE
	)

	# Buildable
	BED = STRUCTURES.add_entry(
		'bed',
		func(): return preload('res://core/entities/structures/custom/bed/Bed.tscn').instantiate()
	)

	FARMLAND = STRUCTURES.add_entry(
		'farmland',
		func(): return preload('res://core/entities/structures/custom/farmland/Farmland.tscn').instantiate()
	)

	STAR_CHANNEL = STRUCTURES.add_entry(
		'star_channel',
		func(): return preload('res://core/entities/structures/custom/star_channel/StarChannel.tscn').instantiate()
	)

	STAR_FORGE = STRUCTURES.add_entry(
		'star_forge',
		func(): return preload('res://core/entities/structures/custom/star_forge/StarForge.tscn').instantiate()
	)

	STONE_FURNACE = STRUCTURES.add_entry(
		'stone_furnace',
		func(): return preload('res://core/entities/structures/custom/stone_furnace/StoneFurnace.tscn').instantiate()
	)

	# Natural
	BUSH = STRUCTURES.add_entry(
		'bush',
		func(): return preload('res://core/entities/structures/custom/bush/Bush.tscn').instantiate()
	)

	CAVE_HOLE = STRUCTURES.add_entry(
		'cave_hole',
		func(): return preload('res://core/entities/structures/custom/cave_hole/CaveHole.tscn').instantiate()
	)

	STRUCTURES.register()
