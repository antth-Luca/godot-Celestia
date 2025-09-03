extends Node2D
class_name RotativePocket

# GETTERS AND SETTERS
#Nodes
func get_hud() -> PlayerHUD:
	return get_parent().get_parent().get_parent()


func get_pseudo_slot(slot_index: int) -> PseudoSlot:
	return get_node('PseudoSlotsGroup').get_child(slot_index)
