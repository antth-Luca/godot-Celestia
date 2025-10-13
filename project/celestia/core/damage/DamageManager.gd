extends Resource
class_name DamageManager

const K: float = 15

static func try_apply(hitbox_parent: Variant, target: LivingEntity) -> void:
	var hit: HitData = hitbox_parent.get_hit_data()
	if DamageRules.can_damage(hit, target):
		var final_def = compute_defense(hit, target.entity_data.stats)
		var final_dam = compute_crit(
			hit, compute_damage(hit, target.entity_data.stats, final_def)
		)
		target.hurt(final_dam, hit, hitbox_parent)
		var attacker_stats = hit.attacker.entity_data.stats
		var attacker_life_steal = attacker_stats.get_property(InitPropProviders.LIFE_STEAL).get_life_steal()
		if attacker_life_steal > 0: hit.attacker.heal(final_dam * attacker_life_steal)


static func try_apply_structure(hitbox_parent: Variant, target: BaseStructure) -> void:
	var hit: HitData = hitbox_parent.get_hit_data()
	if DamageRules.can_damage_structure(hit, target):
		target.damage(1, hit, hitbox_parent)


static func try_apply_effect(effect: BaseEffect, target: LivingEntity) -> void:
	var hit: HitData = effect.get_hit_data()
	if DamageRules.can_damage(hit, target):
		pass


static func compute_defense(hit: HitData, target_stats: PropertyManager) -> float:
	if hit.primitive_type == HitData.PRIMITIVE_TYPE.TRUE: return 0
	var brute_def
	if hit.source == HitData.SOURCE.SPELL or hit.source == HitData.SOURCE.EFFECT:
		brute_def = target_stats.get_property(InitPropProviders.RESISTANCE).get_resistance()
	else:
		brute_def = target_stats.get_property(InitPropProviders.ARMOR).get_armor() - target_stats.get_property(InitPropProviders.RESISTANCE).get_resistance()
	var source_stats: PropertyManager = hit.attacker.entity_data.stats
	var calc_def = brute_def - (brute_def * source_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).get_def_reduction()) - source_stats.get_property(InitPropProviders.PENETRATION).get_penetration()
	if hit.primitive_type == HitData.PRIMITIVE_TYPE.PHYSIC: return max(calc_def, 0)
	return calc_def


static func compute_damage(hit: HitData, target_stats: PropertyManager, calc_def: float) -> float:
	var damage_factor: float = 1 if not hit.tool else hit.tool.damage_factor
	var brute_dam = hit.attacker.entity_data.stats.get_property(InitPropProviders.FORCE).get_force() * damage_factor
	var calc_dam = brute_dam - (brute_dam * target_stats.get_property(InitPropProviders.DAMAGE_REDUCTION).get_dam_reduction())
	if calc_def >= 0: return calc_dam * (1 / (1 + calc_def / K))
	return calc_dam * (2 - (1 / (1 - calc_def / K)))


static func compute_crit(hit: HitData, calc_dam: float) -> float:
	var is_crit: bool = hit.attacker.entity_data.stats.get_property(InitPropProviders.CRITICAL_STRIKE).compute_critical_strike()
	if is_crit: return calc_dam + calc_dam * hit.attacker.entity_data.stats.get_property(InitPropProviders.CRITICAL_STRIKE).get_crit_dam()
	return calc_dam
