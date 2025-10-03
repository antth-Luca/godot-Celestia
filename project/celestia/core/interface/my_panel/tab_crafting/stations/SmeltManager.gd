extends Control

@onready var input_slot: InputSlot = $InputSlot
@onready var fuel_slot: InputSlot = $FuelSlot
@onready var output_slot: OutputSlot = $OutputSlot
@onready var interact_hammer: InteractConfirm = $InteractConfirm

var recipe_cache: BaseRecipe

# MAIN
func fill_children(player: Player) -> void:
	input_slot.player = player
	fuel_slot.player = player
	output_slot.player = player
