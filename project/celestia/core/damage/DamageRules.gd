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

static func can_damage(hit: HitData, target: EntityData) -> bool:
	if target.faction == EntityData.FACTION_MASK.STRUCTURE:
		return can_damage_structure(hit, target as StructureData)
	if (
		hit.attacker == target or
		target.is_dead or
		target.is_invincible
	): return false
	return (DAMAGE_RULES.get(hit.attacker.entity_data.faction, 0) & target.faction) != 0


static func can_damage_structure(hit: HitData, target: StructureData) -> bool:
	if not (DAMAGE_RULES.get(hit.attacker.entity_data.faction, 0) & EntityData.FACTION_MASK.STRUCTURE): return false
	if not hit.tool: return false
	var tool_is_compatible: bool = false
	for comp_tool in target.compatible_tools:
		tool_is_compatible = hit.tool.is_class(comp_tool)
		if tool_is_compatible: break
	if not tool_is_compatible: return false
	var material_is_compatible: bool = false
	for comp_mat in target.compatible_materials:
		material_is_compatible = hit.tool.material.is_class(comp_mat)
		if material_is_compatible: break
	return material_is_compatible
