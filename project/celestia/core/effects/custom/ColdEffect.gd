extends BaseEffect
class_name ColdEffect

const DAMAGE_PERCENTAGE_PER_TICK: float = .05
const POISON_DAMAGE_LIMITER_PERCENTAGE: float = .1

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, BaseEffect.EffectCategory.BENEFICIAL, false, false, true, 30, 0)
