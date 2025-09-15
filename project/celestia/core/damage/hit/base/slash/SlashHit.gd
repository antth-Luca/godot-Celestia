extends BaseHit
class_name SlashHit

# SUPER
# Godot
func _ready() -> void:
	super._ready()
	ANIMATION.play('slash')

# Getters and setters
func get_hit_data() -> HitData:
	return HitData.new(
		source_entity.entity_data,
		source_tool.damage_factor,
		HitData.PRIMITIVE_TYPE.PHYSIC,
		HitData.SPECIALIZED_TYPE.NONE
	)
