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
@onready var supplementary_label = $SupplementaryLabel

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
func show_workstation(workstation_type: int, supplement: String) -> void:
	# General
	self.visible = true
	selected.clear()
	# Workstation visibility
	for key in workstations.keys():
		var supported_types: Array = workstations[key]
		var idx: int = supported_types.find(workstation_type)
		key.visible = idx != -1
		if idx != -1: selected.append_array(supported_types.slice(0, idx + 1))
	# Supplementary label
	if supplement.is_empty():
		supplement = ''


func hide_all_workstations() -> void:
	self.visible = false
	selected = [ -1 ]
	for key in workstations.keys():
		key.visible = false
