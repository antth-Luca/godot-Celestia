extends BaseEnchantment
class_name HullReinforcementEnchantment

const ARMOR_PER_LEVEL: float = 1

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(5, init_level, [
		BaseArmor.get_static_comparable_name()
	])

# Hooks
## Called by DamageManager#compute_defense and the value obtained is added to the entity's armor.
func get_additional_armor() -> float:
	return ARMOR_PER_LEVEL * level
