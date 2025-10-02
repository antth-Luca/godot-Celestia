extends Control

@onready var input_slot: InputSlot = $InputSlot
@onready var output_slot: OutputSlot = $OutputSlot
@onready var interact_hammer: Sprite2D = $InteractHammer

var recipe_cache: BaseRecipe

# MAIN
func fill_children(player: Player) -> void:
	input_slot.player = player
	output_slot.player = player
