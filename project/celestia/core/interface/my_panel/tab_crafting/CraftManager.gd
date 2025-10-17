extends Control
class_name CraftManager

@onready var forge = $Forging
@onready var smelt = $Smelting
@onready var bless = $Blessing
@onready var workstations: Dictionary[Control, Array] = {
	forge: [ CraftingRecipe.WorkstationType.BENCH, CraftingRecipe.WorkstationType.STAR_FORGE, CraftingRecipe.WorkstationType.MANUAL ],
	smelt: [ SmeltingRecipe.WorkstationType.STONE_FURNACE, SmeltingRecipe.WorkstationType.CLAY_FURNACE ],
	bless: [ BlessingRecipe.WorkstationType.STAR_CHANNEL ]
}

var selected: int

# GETTERS AND SETTERS
# Nodes
func get_inventory_panel() -> MyPanel:
	return get_parent()

# MAIN
func fill_children(player: Player) -> void:
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
	for key in workstations.keys():
		var supported_types: Array = workstations[key]
		for type in supported_types:
			if type == workstation_type:
				key.visible = true
				selected = type
				return


func hide_all_workstations() -> void:
	self.visible = false
	selected = -1
	for key in workstations.keys():
		key.visible = false
