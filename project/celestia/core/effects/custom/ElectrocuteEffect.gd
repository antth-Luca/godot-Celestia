extends BaseEffect
class_name ElectrocuteEffect

const ELETRIC_DAMAGE_MODIFIER: float = .2

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, BaseEffect.EffectCategory.NEUTRAL, false, false, true, 10, 0)


# Handlers
func _on_effect_added(entity: LivingEntity) -> void:
	var eletric_prop: EletricDamageModifierProperty = entity.entity_data.stats.get_property(InitPropProviders.ELETRIC_DAMAGE_MODIFIER)
	eletric_prop.add_modifier(ELETRIC_DAMAGE_MODIFIER)


func _on_effect_removed(entity: LivingEntity) -> void:
	var eletric_prop: EletricDamageModifierProperty = entity.entity_data.stats.get_property(InitPropProviders.ELETRIC_DAMAGE_MODIFIER)
	eletric_prop.sub_modifier(ELETRIC_DAMAGE_MODIFIER)
