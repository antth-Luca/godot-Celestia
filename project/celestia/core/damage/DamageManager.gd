extends Resource
class_name DamageManager


static func apply_damage(hit: HitData, target: EntityData) -> void:
	if DamageRules.can_damage(hit, target):
		var comp_def = compute_defense(hit, target.stats)
		var comp_dam = compute_damage(hit, target)


static func compute_defense(hit: HitData, target_status: PropertyManager) -> float:
	return .0


static func compute_damage(hit: HitData, target: EntityData) -> float:
	return .0
