extends BaseHit
class_name SlashHit

# SUPER
func _ready() -> void:
	super()
	ANIMATION.play('attack')

# Get hitdata
func get_hit_data() -> HitData:
	return HitData.new(
		source_entity.entity_data,
		HitData.PRIMITIVE_TYPE.PHYSIC,
		HitData.SPECIALIZED_TYPE.NONE
	)
