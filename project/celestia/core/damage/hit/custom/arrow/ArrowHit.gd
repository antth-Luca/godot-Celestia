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

# Handlers
func _on_hurt_entity() -> void:
	var can_despawn = true
	if source_tool:
		for enchant in source_tool.enchantments:
			can_despawn = enchant.check_despawn_hit()
	if can_despawn: despawn_hit()
