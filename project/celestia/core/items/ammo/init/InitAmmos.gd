extends Node
class_name InitAmmos

static var AMMOS: DeferredRegister
# AMMOs
static var ARROW: DeferredHolder


static func setup() -> void:
	AMMOS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# AMMOs
	ARROW = AMMOS.add_entry(
		'arrow',
		func():
			var armor = BaseAmmo.new()
			return armor
	)

	AMMOS.register()
