extends Control
class_name CraftManager

@onready var forge = $Forging
@onready var smelt = $Smelting
@onready var bless = $Blessing
@onready var workstations: Dictionary[Control, Array] = {
	forge: [
		CraftingRecipe.WorkstationType.MANUAL,
		CraftingRecipe.WorkstationType.BENCH,
		CraftingRecipe.WorkstationType.STAR_FORGE
	],
	smelt: [
		SmeltingRecipe.WorkstationType.CLAY_FURNACE,
		SmeltingRecipe.WorkstationType.STONE_FURNACE
	],
	bless: [
		BlessingRecipe.WorkstationType.STAR_CHANNEL
	]
}

var selected: Array[int]

# GETTERS AND SETTERS
# Nodes
func get_inventory_panel() -> MyPanel:
	return get_parent()

# MAIN
func fill_children(player: Player) -> void:
	# Forge
	forge.fill_children(player)
	# Smelt
	smelt.get_node('InputSlot').player = player
	smelt.get_node('FuelSlot').player = player
	smelt.get_node('OutputSlot').player = player
	# Bless
	bless.get_node('InputSlot').player = player
	bless.get_node('OutputSlot').player = player

# Visibility
func show_workstation(workstation_type: int) -> void:
	self.visible = true
	selected.clear()
	for key in workstations.keys():
		var supported_types: Array = workstations[key]
		if workstation_type in supported_types:
			key.visible = true
			var idx = supported_types.find(workstation_type)
			for i in range(0, idx + 1):
				selected.append(supported_types[i])
		else:
			key.visible = false
	print_debug(selected)


func hide_all_workstations() -> void:
	self.visible = false
	selected = [ -1 ]
	for key in workstations.keys():
		key.visible = false
