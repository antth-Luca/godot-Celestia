extends Node
class_name InitTools

static var TOOLS: DeferredRegister
# Items
static var IRON_AXE: DeferredHolder


static func setup() -> void:
	TOOLS = DeferredRegister.create(
		Celestia.GAME_ID,
		ToolRegistry.REGISTRY_TYPE
	)

	# Swords
	IRON_AXE = TOOLS.add_entry(
		'iron_axe',
		func():
			var weapon = AxeTool.new()
			weapon.material = InitMaterials.IRON.get_registered()
			return weapon
	)

	TOOLS.register()
