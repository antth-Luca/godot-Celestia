extends Control
class_name RotativePocket

# GETTERS AND SETTERS
#Nodes
func get_hud() -> PlayerHUD:
	return get_parent()


func get_pseudo_slot(slot_index: int) -> HUDPocketSlot:
	return get_node('Node2D/HUDSlotsGroup').get_child(slot_index)
