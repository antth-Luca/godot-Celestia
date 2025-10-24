extends BaseEnchantment
class_name IntimidationEnchantment

const MAX_DAM_INCREASE_PERCENTAGE: float = .15
const HEALTH_CEIL_FOR_INCREASE: float = 100

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(1, init_level, [
		BaseTool.get_static_comparable_name(),
		AxeTool.get_static_comparable_name(),
		PickaxeTool.get_static_comparable_name(),
		SwordTool.get_static_comparable_name(),
		FiringTool.get_static_comparable_name()
	])

# Hooks
func get_additional_damage_factor(source_stats: PropertyManager, target_stats: PropertyManager) -> float:
	var source_hp: float = source_stats.get_property(InitPropProviders.HEALTH).get_max_health()
	var target_hp: float = target_stats.get_property(InitPropProviders.HEALTH).get_max_health()
	if target_hp > source_hp: return remap(
		target_hp - source_hp,
		0, HEALTH_CEIL_FOR_INCREASE,
		0, MAX_DAM_INCREASE_PERCENTAGE
	)
	return 0
