extends BaseHit
class_name SlashHit

# GETTERS AND SETTERS
# HitData
func get_hit_data() -> HitData:
	return HitData.new(
		source_entity.entity_data,
		HitData.PRIMITIVE_TYPE.PHYSIC,
		HitData.SPECIALIZED_TYPE.NONE
	)
