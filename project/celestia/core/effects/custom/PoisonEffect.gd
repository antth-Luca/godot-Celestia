extends BaseEffect
class_name PoisonEffect

const DAMAGE_PERCENTAGE_PER_TICK: float = .05
const POISON_DAMAGE_LIMITER_PERCENTAGE: float = .1

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, BaseEffect.EffectCategory.MALEFICIAL, false, true, true, 30, 1)

# Handlers
func _on_effect_tick(entity: LivingEntity) -> void:
	var hp_prop: HealthProperty = entity.entity_data.stats.get_property(InitPropProviders.HEALTH)
	var damage: float = get_brute_damage(hp_prop)
	var limiter: float = hp_prop.get_max_health() * POISON_DAMAGE_LIMITER_PERCENTAGE
	if not hp_prop.get_health() - damage < limiter:  # Cannot kill
		DamageManager.try_apply_effect(self, entity)

# MAIN
func get_brute_damage(target_hp_prop: HealthProperty) -> float:
	return target_hp_prop.get_health() * DAMAGE_PERCENTAGE_PER_TICK
