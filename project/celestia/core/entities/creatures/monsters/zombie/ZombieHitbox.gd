extends Hitbox
class_name ZombieHitbox

func get_hit_data() -> HitData:
	return HitData.new(
		get_parent().entity_data,
		HitData.PRIMITIVE_TYPE.PHYSIC,
		HitData.SPECIALIZED_TYPE.NONE
	)
