extends Resource
class_name DamageManager

const K: float = 15
const DAMAGE_TO_STRUCTURES: float = 1
const NOT_TOOL_DAM_FACTOR: float = 1

static func try_apply(hitbox_parent: Variant, target: LivingEntity) -> void:
	var hit: HitData = hitbox_parent.get_hit_data()
	if DamageRules.can_damage(hit, target):
		if hit.tool:
			for enchant in hit.tool.enchantments:
				hit = enchant.override_hitdata(hit, target)
		var attacker_stats = hit.attacker.entity_data.stats
		var target_stats: PropertyManager = target.entity_data.stats
		var final_def = compute_defense(hit.primitive_type, hit.source, target, target_stats, attacker_stats)
		var brute_dam = get_brute_damage(hit.tool, attacker_stats, target_stats)
		var final_dam = compute_crit(hit, compute_damage(hit.specialized_type, brute_dam, target_stats, final_def))
		target.hurt(final_dam, hit, hitbox_parent)
		if hit.tool:
			for enchant in hit.tool.enchantments:
				enchant.post_damage(hit, target, final_dam)
		if hit.attacker is Player:
			var relic_slots: Array[BaseSlot] = hit.attacker.inventory.get_relics()
			for slot in relic_slots:
				var relic: BaseRelic = slot.stack.item
				if relic: relic.post_damage(hit, target, final_dam)
		var attacker_life_steal = attacker_stats.get_property(InitPropProviders.LIFE_STEAL).get_life_steal()
		if attacker_life_steal > 0: hit.attacker.heal(final_dam * attacker_life_steal)


static func try_apply_structure(hitbox_parent: Variant, target: BaseStructure) -> void:
	var hit: HitData = hitbox_parent.get_hit_data()
	if DamageRules.can_damage_structure(hit, target):
		target.damage(DAMAGE_TO_STRUCTURES, hit, hitbox_parent)


static func try_apply_spell(hitbox_parent: Variant, target: LivingEntity) -> void:
	var hit: HitData = hitbox_parent.get_hit_data()
	if DamageRules.can_damage_effect(target):
		var attacker_stats = hit.attacker.entity_data.stats
		var target_stats: PropertyManager = target.entity_data.stats
		var final_def = compute_defense(hit.primitive_type, hit.source, target, target_stats)
		var brute_dam = get_brute_damage(hit.tool, attacker_stats, target_stats)
		var final_dam = compute_damage(hit.specialized_type, brute_dam, target_stats, final_def)
		target.hurt(final_dam, hit, hitbox_parent)
		var attacker_life_steal = attacker_stats.get_property(InitPropProviders.LIFE_STEAL).get_life_steal()
		if attacker_life_steal > 0: hit.attacker.heal(final_dam * attacker_life_steal)


static func try_apply_effect(effect: BaseEffect, target: LivingEntity) -> void:
	var hit: HitData = effect.get_hit_data()
	if DamageRules.can_damage_effect(target):
		var target_stats: PropertyManager = target.entity_data.stats
		var final_def = compute_defense(hit.primitive_type, hit.source, target, target_stats)
		var brute_dam = effect.get_brute_damage(target_stats.get_property(InitPropProviders.HEALTH))
		var final_dam = compute_damage(hit.specialized_type, brute_dam, target_stats, final_def)
		target.hurt(final_dam, hit, effect)


static func compute_defense(hit_primitive_type: HitData.PRIMITIVE_TYPE, hit_source: HitData.SOURCE, target: LivingEntity, target_stats: PropertyManager, source_stats: PropertyManager = null) -> float:
	if hit_primitive_type == HitData.PRIMITIVE_TYPE.TRUE: return 0
	var calc_def: float
	var target_armor_slots: Array[BaseSlot]
	if target is Player: target_armor_slots = target.inventory.get_armor()
	if hit_source in [HitData.SOURCE.SPELL, HitData.SOURCE.EFFECT]:
		calc_def = target_stats.get_property(InitPropProviders.RESISTANCE).get_resistance()
		if not target_armor_slots.is_empty():
			for slot in target_armor_slots:
				var slot_stack: ItemStack = slot.stack
				if slot_stack.is_empty(): continue
				for enchant in slot_stack.item.enchantments:
					calc_def += enchant.get_additional_resistance()
	else:
		var brute_def: float = target_stats.get_property(InitPropProviders.ARMOR).get_armor() + target_stats.get_property(InitPropProviders.RESISTANCE).get_resistance()
		if not target_armor_slots.is_empty():
			for slot in target_armor_slots:
				var slot_stack: ItemStack = slot.stack
				if slot_stack.is_empty(): continue
				for enchant in slot_stack.item.enchantments:
					brute_def += enchant.get_additional_resistance()
					brute_def += enchant.get_additional_armor()
		calc_def = brute_def - (brute_def * source_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).get_def_reduction()) - source_stats.get_property(InitPropProviders.PENETRATION).get_penetration()
	if hit_primitive_type == HitData.PRIMITIVE_TYPE.PHYSIC: return max(calc_def, 0)
	return calc_def


static func get_brute_damage(hit_tool: BaseItem, attacker_stats: PropertyManager, target_stats: PropertyManager) -> float:
	var damage_factor: float
	if not hit_tool:
		damage_factor = NOT_TOOL_DAM_FACTOR
	else:
		damage_factor = hit_tool.damage_factor
		for enchant in hit_tool.enchantments:
			damage_factor += enchant.get_additional_damage_factor(attacker_stats, target_stats)
	return attacker_stats.get_property(InitPropProviders.FORCE).get_force() * damage_factor


static func compute_damage(hit_specialized_type: HitData.SPECIALIZED_TYPE, brute_dam: float, target_stats: PropertyManager, calc_def: float) -> float:
	var calc_dam = brute_dam - brute_dam * target_stats.get_property(InitPropProviders.DAMAGE_REDUCTION).get_dam_reduction()
	if hit_specialized_type == HitData.SPECIALIZED_TYPE.ELETRIC:
		calc_dam *= target_stats.get_property(InitPropProviders.ELETRIC_DAMAGE_MODIFIER).get_modifier()
	if not calc_def < 0: return calc_dam * (1 / (1 + calc_def / K))
	return calc_dam * (2 - (1 / (1 - calc_def / K)))


static func compute_crit(hit: HitData, calc_dam: float) -> float:
	var attacker_stats: PropertyManager = hit.attacker.entity_data.stats
	if not hit.is_crit:
		hit.is_crit = attacker_stats.get_property(InitPropProviders.CRITICAL_STRIKE).compute_critical_strike()
	if hit.is_crit: return calc_dam + calc_dam * attacker_stats.get_property(InitPropProviders.CRITICAL_STRIKE).get_crit_damage()
	return calc_dam
