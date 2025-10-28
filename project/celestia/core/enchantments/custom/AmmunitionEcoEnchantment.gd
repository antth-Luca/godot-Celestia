extends BaseEnchantment
class_name AmmunitionEcoEnchantment

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(1, init_level, [
		FiringTool.get_static_comparable_name()
	])

# Hooks
func override_can_consume_ammo(_can_consume: bool) -> bool:
	return false
