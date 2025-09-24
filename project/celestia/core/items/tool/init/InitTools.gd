extends Node
class_name InitTools

static var TOOLS: DeferredRegister
# Axes
static var IRON_AXE: DeferredHolder
# Pickaxes
static var IRON_PICKAXE: DeferredHolder


static func setup() -> void:
	TOOLS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Axes
	IRON_AXE = TOOLS.add_entry(
		'iron_axe',
		func():
			var tool = AxeTool.new()
			tool.material = InitMaterials.IRON.get_registered()
			tool.set_durability(1.5)
			return tool
	)

	# Pickaxes
	IRON_PICKAXE = TOOLS.add_entry(
		'iron_pickaxe',
		func():
			var tool = PickaxeTool.new()
			tool.material = InitMaterials.IRON.get_registered()
			tool.set_durability(1.5)
			return tool
	)

	TOOLS.register()
