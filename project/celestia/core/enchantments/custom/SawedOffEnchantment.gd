extends BaseEnchantment
class_name SawedOffEnchantment

const DAMAGE_BUFF_PERCENTAGE: float = .5
const RANGE_DEBUFF_PERCENTAGE: float = -.2

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(1, init_level, [
		FiringTool.get_static_comparable_name()
	])

# Hooks
func get_additional_range() -> float:
	return RANGE_DEBUFF_PERCENTAGE


func get_additional_damage_factor(_source_stats: PropertyManager, _target_stats: PropertyManager) -> float:
	return DAMAGE_BUFF_PERCENTAGE
