extends Node
class_name InitEntities

static var ENTITIES: DeferredRegister
# Player
static var PLAYER: DeferredHolder
# Monsters
static var ZOMBIE: DeferredHolder



static func setup() -> void:
	ENTITIES = DeferredRegister.create(
		Celestia.GAME_ID,
		EntityRegistry.REGISTRY_TYPE
	)

	# Player
	PLAYER = ENTITIES.add_entry(
		'player',
		func():
			return preload('res://core/entities/creatures/player/Player.tscn')
	)

	# Monsters
	ZOMBIE = ENTITIES.add_entry(
		'zombie',
		func():
			return preload('res://core/entities/creatures/monsters/zombie/Zombie.tscn')
	)

	ENTITIES.register()
