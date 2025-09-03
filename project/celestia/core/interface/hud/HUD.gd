extends MarginContainer
class_name PlayerHUD

# GETTERS
# Nodes
func get_ui() -> WorldUI:
	return get_parent()


func get_stats_bar() -> StatsBar:
	return get_node('HContainerLeft/VContainerDown/StatsBar')


func get_rotative_pocket() -> RotativePocket:
	return get_node('HContainerRight/VContainerDown/RotativePocket')
