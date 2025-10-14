extends Resource
class_name DamageRules

const DAMAGE_RULES = {
	EntityData.FACTION_MASK.PLAYER: 
		EntityData.FACTION_MASK.BOSS | 
		EntityData.FACTION_MASK.MONSTER |
		EntityData.FACTION_MASK.ANIMAL |
		EntityData.FACTION_MASK.STRUCTURE,
	EntityData.FACTION_MASK.BOSS:
		EntityData.FACTION_MASK.PLAYER,
	EntityData.FACTION_MASK.MONSTER:
		EntityData.FACTION_MASK.PLAYER |
		EntityData.FACTION_MASK.MONSTER,
	EntityData.FACTION_MASK.ANIMAL:
		EntityData.FACTION_MASK.PLAYER |
		EntityData.FACTION_MASK.ANIMAL,
	EntityData.FACTION_MASK.STRUCTURE: 0
}

static func can_damage(hit: HitData, target: LivingEntity) -> bool:
	var target_data: EntityData = target.entity_data
	if (
		hit.attacker == target or
		target_data.is_dead or
		target_data.is_invincible
	): return false
	return (DAMAGE_RULES.get(hit.attacker.entity_data.faction, 0) & target_data.faction) != 0


static func can_damage_structure(hit: HitData, target: BaseStructure) -> bool:
	if not (DAMAGE_RULES.get(hit.attacker.entity_data.faction, 0) & EntityData.FACTION_MASK.STRUCTURE): return false
	if not hit.tool: return false
	var tool_is_compatible: bool = false
	var target_data: StructureData = target.structure_data
	for comp_tool in target_data.compatible_tools:
		tool_is_compatible = hit.tool.COMPARABLE_NAME == comp_tool
		if tool_is_compatible: break
	if not tool_is_compatible: return false
	var material_is_compatible: bool = false
	for comp_mat in target_data.compatible_materials:
		material_is_compatible = hit.tool.material.efficiency >= comp_mat.efficiency
		if material_is_compatible: break
	return material_is_compatible


static func can_damage_effect(target: LivingEntity) -> bool:
	var target_data: EntityData = target.entity_data
	if (
		target_data.is_dead or
		target_data.is_invincible
	): return false
	return true
