extends MarginContainer
class_name PlayerHUD

# GETTERS
# Nodes
func get_ui() -> WorldUI:
	return get_parent()


func get_effects_display() -> EffectsDisplay:
	return get_node('EffectsDisplay')


func get_boss_health_bar() -> BossHealthBar:
	return get_node('BossHealthBar')


func get_stats_bar() -> StatsBar:
	return get_node('StatsBar')


func get_rotative_pocket() -> RotativePocket:
	return get_node('RotativePocket')
