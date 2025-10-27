extends BaseEnchantment
class_name AmmunitionEcoEnchantment

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(1, init_level, [
		FiringTool.get_static_comparable_name()
	])

# Hooks
func check_consume_ammo() -> bool:
	return false
