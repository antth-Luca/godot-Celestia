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
			var tool = AxeTool.new()
			tool.material = InitMaterials.IRON.get_registered()
			tool.set_durability(1.5)
			return tool
	)

	TOOLS.register()
