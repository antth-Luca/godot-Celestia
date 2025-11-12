extends LivingEntity
class_name UlkenGolem

# GODOT
func _init() -> void:
	entity_data = EntityData.new(
		EntityData.FACTION_MASK.MONSTER,
		PropertyManager.create_manager({
			InitPropProviders.ELETRIC_DAMAGE_MODIFIER: 1,
			InitPropProviders.MOBILITY_MODIFIER: 1,
			InitPropProviders.HEAL_MODIFIER: 1,
			InitPropProviders.HEALTH: 300,
			InitPropProviders.ARMOR: 5,
			InitPropProviders.RESISTANCE: 5,
			InitPropProviders.DAMAGE_REDUCTION: 0,
			InitPropProviders.FORCE: 12,
			InitPropProviders.PENETRATION: 0,
			InitPropProviders.DEFENSE_REDUCTION: 0,
			InitPropProviders.CRITICAL_STRIKE: 0,
			InitPropProviders.LIFE_STEAL: 0.3,
			InitPropProviders.MOVE_SPEED: 30
		})
	)

# GETTERS AND SETTERS
# Source Entity
func get_source_entity() -> LivingEntity:
	return self

# HitData
func get_hit_data() -> HitData:
	return HitData.new(
		self,
		HitData.PRIMITIVE_TYPE.MAGIC,
		HitData.SPECIALIZED_TYPE.EXPLOSION,
		HitData.SOURCE.HIT,
	)
