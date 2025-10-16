extends BaseEffect
class_name ElectrocuteEffect

const ELETRIC_DAMAGE_MODIFIER: float = 1.2

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, BaseEffect.EffectCategory.NEUTRAL, false, false, true, 10, 0)
