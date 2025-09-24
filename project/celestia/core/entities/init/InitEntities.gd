extends Node
class_name InitEntities

static var ENTITIES: DeferredRegister
# Animals
static var CHICKEN: DeferredHolder
# Player
static var PLAYER: DeferredHolder
# Monsters
static var ZOMBIE: DeferredHolder



static func setup() -> void:
	ENTITIES = DeferredRegister.create(
		Celestia.GAME_ID,
		EntityRegistry.REGISTRY_TYPE
	)

	# Animals
	CHICKEN = ENTITIES.add_entry(
		'chicken',
		func():
			return preload('res://core/entities/creatures/animals/chicken/Chicken.tscn').instantiate()
	)

	# Player
	PLAYER = ENTITIES.add_entry(
		'player',
		func():
			return preload('res://core/entities/creatures/player/Player.tscn').instantiate()
	)

	# Monsters
	ZOMBIE = ENTITIES.add_entry(
		'zombie',
		func():
			return preload('res://core/entities/creatures/monsters/zombie/Zombie.tscn').instantiate()
	)

	ENTITIES.register()
