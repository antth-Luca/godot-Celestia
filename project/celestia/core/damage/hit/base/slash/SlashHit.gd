extends BaseHit
class_name SlashHit

# SUPER
func _ready() -> void:
	ANIMATION.speed_scale = ANIMATION.get_animation('attack').length / calc_use_speed

# Get hitdata
func get_hit_data() -> HitData:
	return HitData.new(
		source_entity.entity_data,
		HitData.PRIMITIVE_TYPE.PHYSIC,
		HitData.SPECIALIZED_TYPE.NONE
	)
