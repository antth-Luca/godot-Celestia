extends Node
class_name InitFuels

static var FUELS: DeferredRegister
# Fuels
static var COAL: DeferredHolder
static var STICK: DeferredHolder


static func setup() -> void:
	FUELS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Fuels
	COAL = FUELS.add_entry(
		'coal',
		func():
			var fuel = BaseFuel.new()
			fuel.energy = 5
			return fuel
	)

	STICK = FUELS.add_entry(
		'stick',
		func():
			var fuel = BaseFuel.new()
			fuel.energy = 1
			return fuel
	)

	FUELS.register()
