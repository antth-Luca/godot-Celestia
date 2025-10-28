extends BaseEnchantment
class_name UnboundEnchantment

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(1, init_level, [
		FiringTool.get_static_comparable_name()
	])

# Hooks
func override_can_despawn_hit(_can_despawn: bool) -> bool:
	return false
