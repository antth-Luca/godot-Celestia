extends MarginContainer

# GETTERS
# Nodes
func get_ui():
	return get_parent()


func get_stats_bar():
	return get_node('HContainerLeft/VContainerDown/StatsBar')


func get_rotative_pocket():
	return get_node('HContainerRight/VContainerDown/RotativePocket')
