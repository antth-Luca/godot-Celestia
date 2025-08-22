extends Node2D

# GETTERS AND SETTERS
#Nodes
func get_hud():
	return get_parent()


func get_pseudo_slot(slot_index: int):
	return get_node('PseudoSlotsGroup').get_child(slot_index)

# HANDLERS
func _synchronize_pseudo_slot(slot_index: int, stack: ItemStack = null) -> void:
	var slot = get_pseudo_slot(slot_index)
	if stack != null:
		slot.render_slot(stack)
		return
	slot.clear_slot()
