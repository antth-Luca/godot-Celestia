extends Node2D

# HANDLERS
func _synchronize_pseudo_slot(slot_index: int, stack: ItemStack = null) -> void:
	var slot = get_child(slot_index)
	if stack != null:
		slot.render_slot(stack)
		return
	slot.clear_slot()
