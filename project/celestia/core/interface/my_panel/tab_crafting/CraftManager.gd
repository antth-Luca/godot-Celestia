extends Control
class_name CraftManager

@onready var forge = $Forge
@onready var smelt = $Smelt
@onready var bless = $Bless
@onready var workstations: Dictionary[Control, Array] = {
	forge: [ WorkstationTypes.BENCH, WorkstationTypes.STAR_FORGE, WorkstationTypes.MANUAL ],
	smelt: [ WorkstationTypes.STONE_FURNACE, WorkstationTypes.CLAY_FURNACE ],
	bless: [ WorkstationTypes.STAR_CHANNEL ]
}

var stacks: Dictionary = { 'input': [], 'output': ItemStack.EMPTY }

# GETTERS AND SETTERS
# Nodes
func get_inventory_panel() -> MyPanel:
	return get_parent()

# MAIN
func fill_children(player: Player) -> void:
	# Forge
	forge.get_node('InputSlot')
	forge.get_node('InputSlot')
	forge.get_node('InputSlot')
	forge.get_node('InputSlot')
	forge.get_node('InputSlot')
	forge.get_node('InputSlot')
	# Smelt
	smelt.get_node('InputSlot')
	smelt.get_node('InputSlot')
	smelt.get_node('InputSlot')
	# Bless
	bless.get_node('InputSlot')
	bless.get_node('InputSlot')

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
