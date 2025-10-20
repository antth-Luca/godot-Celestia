extends BaseEnchantment
class_name ConservationEnchantment

const CHANCE_PER_LEVEL_NOT_CONSUME: float = .02

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(1, init_level, [BaseItem.get_comparable_name()])

# Hooks
func check_consome_durability() -> bool:
	return not randf() <= level * CHANCE_PER_LEVEL_NOT_CONSUME
