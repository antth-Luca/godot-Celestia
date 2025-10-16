extends BaseEffect
class_name BleedEffect

const DAMAGE_PERCENTAGE_PER_TICK: float = .015

# SUPER
# Godot
func _init() -> void:
	super._init(8, 1, BaseEffect.EffectCategory.MALEFICIAL, false, true, true, 3, 1)

# Handlers
func _on_effect_renewed(entity: LivingEntity) -> void:
	amplifier += 1
	super._on_effect_renewed(entity)


func _on_effect_tick(entity: LivingEntity) -> void:
	DamageManager.try_apply_effect(self, entity)

# MAIN
func get_brute_damage(target_hp_prop: HealthProperty) -> float:
	return (target_hp_prop.get_health() * DAMAGE_PERCENTAGE_PER_TICK) * amplifier
