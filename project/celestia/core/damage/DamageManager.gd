extends Resource
class_name DamageManager

const K: float = 15

static func try_apply(hit: HitData, target: EntityData) -> void:
	if DamageRules.can_damage(hit, target):
		var final_def = compute_defense(hit, target.stats)
		var final_dam = compute_crit(
			hit, compute_damage(hit, target.stats, final_def)
		)
		apply_damage(final_dam, target.stats)


static func compute_defense(hit: HitData, target_stats: PropertyManager) -> float:
	if hit.primitive_type == HitData.PRIMITIVE_TYPE.TRUE: return 0
	var brute_def = target_stats.get_property(InitPropProviders.ARMOR).get_armor() - target_stats.get_property(InitPropProviders.RESISTANCE).get_resistance()
	var source_stats: PropertyManager = hit.attacker.stats
	var calc_def = brute_def - (brute_def * source_stats.get_property(InitPropProviders.DEFENSE_REDUCTION)) - source_stats.get_property(InitPropProviders.PENETRATION)
	if hit.primitive_type == HitData.PRIMITIVE_TYPE.PHYSIC: return max(calc_def, 0)
	return calc_def


static func compute_damage(hit: HitData, target_stats: PropertyManager, calc_def: float) -> float:
	var brute_dam = hit.attacker.stats.get_property(InitPropProviders.FORCE).get_force()
	var calc_dam = brute_dam - (brute_dam * target_stats.get_property(InitPropProviders.DAMAGE_REDUCTION).get_dam_r())
	if calc_def >= 0: return calc_dam * (1 / (1 + calc_def / K))
	return calc_dam * (2 - (1 / (1 - calc_def / K)))


static func compute_crit(hit: HitData, calc_dam: float) -> float:
	if hit.is_crit: return calc_dam * hit.attacker.stats.get_property(InitPropProviders.CRITICAL_STRIKE).get_crit_dam()
	return calc_dam


static func apply_damage(final_dam: float, target_stats: PropertyManager) -> void:
	var hp_prop = target_stats.get_property(InitPropProviders.HEALTH)
	hp_prop.sub_health(final_dam)
