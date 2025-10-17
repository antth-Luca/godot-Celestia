extends OutputSlot
class_name BlessOutputSlot

# SUPER
# Handlers
func clear_slot() -> void:
	super.clear_slot()
	if can_get_output:
		var outputs = get_parent().output_stacks
		for output in outputs.slice(1, outputs.size()):
			player.inventory.add_item_to_backpack(output)
