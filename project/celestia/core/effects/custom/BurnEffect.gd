extends BaseEffect
class_name BurnEffect

const DAMAGE_PERCENTAGE_PER_TICK: float = .01

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, BaseEffect.EffectCategory.MALEFICIAL, false, true, true, 5, 1, [InitEffects.COLD])

# Handlers
func _on_effect_tick(entity: LivingEntity) -> void:
	DamageManager.try_apply_effect(self, entity)

# MAIN
func get_brute_damage(target_hp_prop: HealthProperty) -> float:
	return target_hp_prop.get_max_health() * DAMAGE_PERCENTAGE_PER_TICK
