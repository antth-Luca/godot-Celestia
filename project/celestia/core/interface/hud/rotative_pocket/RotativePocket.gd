extends Node2D

# GETTERS AND SETTERS
#Nodes
func get_hud():
	return get_parent().get_parent().get_parent()


func get_pseudo_slot(slot_index: int):
	return get_node('PseudoSlotsGroup').get_child(slot_index)
