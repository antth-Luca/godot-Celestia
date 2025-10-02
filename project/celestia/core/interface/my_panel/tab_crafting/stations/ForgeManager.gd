extends Control

@onready var inputs: Array[InputSlot] = [
	$InputSlot,
	$InputSlot2,
	$InputSlot3,
	$InputSlot4,
	$InputSlot5,
]
@onready var output_slot = $OutputSlot
@onready var interact_hammer = $InteractHammer

var recipe_cache: BaseRecipe

# GODOT
func _ready() -> void:
	for slot in inputs:
		slot.connect('slot_item_added', Callable(self, 'try_find_recipe'))
		slot.connect('slot_item_removed', Callable(self, 'try_find_recipe'))

# MAIN
func fill_children(player: Player) -> void:
	for slot in inputs:
		slot.player = player


func try_find_recipe() -> void:
	# Try to find a valid and compatible recipe. If find one, set the preview and enable the interaction hammer.
	for recipe_holder in RegistryManager.registries[RecipeRegistry.REGISTRY_TYPE]._per_workstation[get_parent().selected]


func enable_interact_hammer() -> void:
	# Sets the sprite's total opacity and enables dragging.
	pass


func set_result() -> void:
	# Sets the result in the output slot and blocks new inputs.
	pass


func finish_craft() -> void:
	# Enables new inputs and sets the recipe cache.
	pass
