extends Resource
class_name DamageRules

const DAMAGE_RULES = {
	EntityData.FACTION_MASK.PLAYER: 
		EntityData.FACTION_MASK.BOSS | 
		EntityData.FACTION_MASK.MONSTER |
		EntityData.FACTION_MASK.ANIMAL,
	EntityData.FACTION_MASK.BOSS:
		EntityData.FACTION_MASK.PLAYER,
	EntityData.FACTION_MASK.MONSTER:
		EntityData.FACTION_MASK.PLAYER |
		EntityData.FACTION_MASK.MONSTER,
	EntityData.FACTION_MASK.ANIMAL:
		EntityData.FACTION_MASK.PLAYER |
		EntityData.FACTION_MASK.ANIMAL
}

static func can_damage(hit: HitData, target: EntityData) -> bool:
	if (
		hit.attacker == target or
		target.is_dead or
		target.is_invincible
	): return false
	return (DAMAGE_RULES.get(hit.attacker.entity_data.faction, 0) & target.faction) != 0
