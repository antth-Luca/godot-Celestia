extends BaseEnchantment
class_name ConservationEnchantment

const CHANCE_PER_LEVEL_NOT_CONSUME: float = .1

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(5, init_level, [
		BaseTool.get_static_comparable_name(),
		AxeTool.get_static_comparable_name(),
		PickaxeTool.get_static_comparable_name(),
		SwordTool.get_static_comparable_name(),
		FiringTool.get_static_comparable_name()
	])

# Hooks
func check_consume_durability() -> bool:
	return not randf() <= level * CHANCE_PER_LEVEL_NOT_CONSUME
