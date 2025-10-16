extends BaseEffect
class_name RegenerationEffect

const HEAL_PERCENTAGE_PER_TICK: float = .025

# SUPER
# Godot
func _init() -> void:
	super._init(3, 1, BaseEffect.EffectCategory.BENEFICIAL, false, true, true, 4, 1)

# Handlers
func _on_effect_tick(entity: LivingEntity) -> void:
	var hp_prop: HealthProperty = entity.entity_data.stats.get_property(InitPropProviders.HEALTH)
	entity.heal(hp_prop.get_max_health() * HEAL_PERCENTAGE_PER_TICK)
