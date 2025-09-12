extends LivingEntity
class_name Zombie

var state_left_time: float

# GODOT
func _init() -> void:
	entity_data = EntityData.new(
		EntityData.FACTION_MASK.MONSTER,
		PropertyManager.create_manager({
			InitPropProviders.HEALTH: 80,
			InitPropProviders.ARMOR: 0,
			InitPropProviders.RESISTANCE: 0,
			InitPropProviders.DAMAGE_REDUCTION: 0,
			InitPropProviders.FORCE: 16,
			InitPropProviders.PENETRATION: 0,
			InitPropProviders.DEFENSE_REDUCTION: 0,
			InitPropProviders.CRITICAL_STRIKE: 0,
			InitPropProviders.LIFE_STEAL: 0.3,
			InitPropProviders.RANGE: 1,
			InitPropProviders.USE_SPEED: 1,
			InitPropProviders.MOVE_SPEED: 20
		})
	)

# GETTERS AND SETTERS
# Source Entity
func get_source_entity() -> LivingEntity:
	return self

# HitData
func get_hit_data() -> HitData:
	return HitData.new(
		entity_data,
		1,
		HitData.PRIMITIVE_TYPE.PHYSIC,
		HitData.SPECIALIZED_TYPE.NONE
	)
