extends Node
class_name InitCreatures

static var CREATURES: DeferredRegister
# Animals
static var CHICKEN: DeferredHolder
# Player
static var PLAYER: DeferredHolder
# Monsters
static var ZOMBIE: DeferredHolder



static func setup() -> void:
	CREATURES = DeferredRegister.create(
		Celestia.GAME_ID,
		EntityRegistry.REGISTRY_TYPE
	)

	# Animals
	CHICKEN = CREATURES.add_entry(
		'chicken',
		func():
			return preload('res://core/entities/creatures/animals/chicken/Chicken.tscn').instantiate()
	)

	# Player
	PLAYER = CREATURES.add_entry(
		'player',
		func():
			return preload('res://core/entities/creatures/player/Player.tscn').instantiate()
	)

	# Monsters
	ZOMBIE = CREATURES.add_entry(
		'zombie',
		func():
			return preload('res://core/entities/creatures/monsters/zombie/Zombie.tscn').instantiate()
	)

	CREATURES.register()
