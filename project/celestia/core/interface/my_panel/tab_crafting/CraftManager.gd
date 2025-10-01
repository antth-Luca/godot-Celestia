extends Control
class_name CraftManager

@onready var forge = $Forge
@onready var smelt = $Smelt
@onready var bless = $Bless
@onready var workstations: Dictionary[Control, Array] = {
	forge: [ CraftingRecipe.WorkstationType.BENCH, CraftingRecipe.WorkstationType.STAR_FORGE, CraftingRecipe.WorkstationType.MANUAL ],
	smelt: [ SmeltingRecipe.WorkstationType.STONE_FURNACE, SmeltingRecipe.WorkstationType.CLAY_FURNACE ],
	bless: [ BlessingRecipe.WorkstationType.STAR_CHANNEL ]
}

var stacks: Dictionary = { 'input': [], 'output': ItemStack.EMPTY }

# GETTERS AND SETTERS
# Nodes
func get_inventory_panel() -> MyPanel:
	return get_parent()

# MAIN
func fill_children(player: Player) -> void:
	# Forge
	forge.get_node('InputSlot').player = player
	forge.get_node('InputSlot2').player = player
	forge.get_node('InputSlot3').player = player
	forge.get_node('InputSlot4').player = player
	forge.get_node('InputSlot5').player = player
	forge.get_node('OutputSlot').player = player
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
				return


func hide_all_workstations() -> void:
	self.visible = false
	for key in workstations.keys():
		key.visible = false
