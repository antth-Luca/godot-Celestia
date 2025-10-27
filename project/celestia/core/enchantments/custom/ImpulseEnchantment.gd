extends BaseEnchantment
class_name ImpulseEnchantment

const KNOCKBACK_BUFF_PERCENTAGE: float = .15

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(1, init_level, [
		BaseTool.get_static_comparable_name(),
		AxeTool.get_static_comparable_name(),
		PickaxeTool.get_static_comparable_name(),
		SwordTool.get_static_comparable_name()
	])

# Hooks
func get_additional_knockback_factor() -> float:
	return KNOCKBACK_BUFF_PERCENTAGE * level
