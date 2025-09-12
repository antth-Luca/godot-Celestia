extends Resource
class_name DamageRules

const DAMAGE_RULES = {
	EntityData.FACTION_MASK.PLAYER: 
		EntityData.FACTION_MASK.BOSS | 
		EntityData.FACTION_MASK.MONSTER |
		EntityData.FACTION_MASK.ANIMAL |
		EntityData.FACTION_MASK.STRUCT,
	EntityData.FACTION_MASK.BOSS:
		EntityData.FACTION_MASK.PLAYER,
	EntityData.FACTION_MASK.MONSTER:
		EntityData.FACTION_MASK.PLAYER |
		EntityData.FACTION_MASK.MONSTER,
	EntityData.FACTION_MASK.ANIMAL:
		EntityData.FACTION_MASK.PLAYER |
		EntityData.FACTION_MASK.ANIMAL,
	EntityData.FACTION_MASK.STRUCT: 0
}

static func can_damage(hit: HitData, target: EntityData) -> bool:
	if (
		hit.attacker == target or
		not target.is_alive or
		target.is_invincible
	): return false
	return (DAMAGE_RULES.get(hit.attacker.faction, 0) & target.faction) != 0
