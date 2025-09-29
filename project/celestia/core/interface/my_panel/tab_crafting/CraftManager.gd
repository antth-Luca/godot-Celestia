extends Control
class_name CraftManager

@onready var workstations: Dictionary[Control, Array] = {
	$Forge: [ WorkstationTypes.BENCH, WorkstationTypes.STAR_FORGE, WorkstationTypes.MANUAL ],
	$Smelt: [ WorkstationTypes.STONE_FURNACE, WorkstationTypes.CLAY_FURNACE ],
	$Bless: [ WorkstationTypes.STAR_CHANNEL ]
}

var stacks: Dictionary = { 'input': [], 'output': ItemStack.EMPTY }

# MAIN
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
