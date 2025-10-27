extends BaseEnchantment
class_name CompulsionEnchantment

const EXTRA_HIT_PER_LEVEL: int = 1

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(1, init_level, [
		FiringTool.get_static_comparable_name()
	])

# Hooks
func get_additional_hit_number() -> int:
	return EXTRA_HIT_PER_LEVEL * level
