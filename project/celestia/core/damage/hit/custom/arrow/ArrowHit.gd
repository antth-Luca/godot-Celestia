extends BaseHit
class_name ArrowHit

# SUPER
# Godot
func _init():
	speed = 150

# Getters and setters
func get_hit_data() -> HitData:
	return HitData.new(
		source_entity,
		HitData.PRIMITIVE_TYPE.PHYSIC,
		HitData.SPECIALIZED_TYPE.PIERCE,
		HitData.SOURCE.HIT,
		source_tool
	)
