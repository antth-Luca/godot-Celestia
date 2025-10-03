extends Control

@onready var input_slot: InputSlot = $InputSlot
@onready var fuel_slot: InputSlot = $FuelSlot
@onready var output_slot: OutputSlot = $OutputSlot
@onready var interact_shovel: InteractConfirm = $InteractConfirm

var can_set_input := true
var recipe_cache: BaseRecipe

# GODOT
func _ready() -> void:
	# Input
	input_slot.connect('slot_item_added', Callable(self, 'try_find_recipe'))
	input_slot.connect('slot_item_removed', Callable(self, 'try_find_recipe'))
	# Fuel
	fuel_slot.connect('slot_item_added', Callable(self, 'try_find_recipe'))
	fuel_slot.connect('slot_item_removed', Callable(self, 'try_find_recipe'))
	# Output
	output_slot.connect('slot_item_removed', Callable(self, 'cleanup_craft'))

# MAIN
func fill_children(player: Player) -> void:
	input_slot.player = player
	fuel_slot.player = player
	output_slot.player = player


func try_find_recipe() -> void:
	# Try to find a valid and compatible recipe. If find one, set the preview and enable the interaction hammer.
	pass


func cleanup_craft() -> void:
	# Enables new inputs and sets the recipe cache.
	pass
