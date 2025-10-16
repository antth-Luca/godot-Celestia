extends BaseEffect
class_name DecompositionEffect

const RESISTANCE_DEBUFF_PERCENTAGE: float = .15
const HEAL_DEBUFF_PERCENTAGE: float = .5

var resistance_debuff: float = 0

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, BaseEffect.EffectCategory.MALEFICIAL, false, false, true, 3, 0, [InitEffects.REGENERATION])

# Handlers
func _on_effect_added(entity: LivingEntity) -> void:
	# Resistance
	var rs_prop: ResistanceProperty = entity.entity_data.stats.get_property(InitPropProviders.RESISTANCE)
	resistance_debuff = rs_prop.get_resistance() * RESISTANCE_DEBUFF_PERCENTAGE
	rs_prop.sub_resistance(resistance_debuff)
	# Heal modifier
	var heal_mod_prop: HealModifierProperty = entity.entity_data.stats.get_property(InitPropProviders.HEAL_MODIFIER)
	heal_mod_prop.sub_modifier(HEAL_DEBUFF_PERCENTAGE)


func _on_effect_removed(entity: LivingEntity) -> void:
	# Resistance
	var rs_prop: ResistanceProperty = entity.entity_data.stats.get_property(InitPropProviders.RESISTANCE)
	rs_prop.add_resistance(resistance_debuff)
	# Heal modifier
	var heal_mod_prop: HealModifierProperty = entity.entity_data.stats.get_property(InitPropProviders.HEAL_MODIFIER)
	heal_mod_prop.add_modifier(HEAL_DEBUFF_PERCENTAGE)
