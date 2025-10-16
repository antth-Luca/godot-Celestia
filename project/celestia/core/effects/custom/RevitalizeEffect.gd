extends BaseEffect
class_name RevitalizeEffect

const HEAL_BONUS_PERCENTAGE: float = .05

# SUPER
# Godot
func _init() -> void:
	super._init(6, 1, BaseEffect.EffectCategory.BENEFICIAL, false, false, true, 10, 0)

# Handlers
func _on_effect_added(entity: LivingEntity) -> void:
	var heal_mod_prop: HealModifierProperty = entity.entity_data.stats.get_property(InitPropProviders.HEAL_MODIFIER)
	heal_mod_prop.add_modifier(HEAL_BONUS_PERCENTAGE)


func _on_effect_removed(entity: LivingEntity) -> void:
	var heal_mod_prop: HealModifierProperty = entity.entity_data.stats.get_property(InitPropProviders.HEAL_MODIFIER)
	heal_mod_prop.sub_modifier(HEAL_BONUS_PERCENTAGE)
