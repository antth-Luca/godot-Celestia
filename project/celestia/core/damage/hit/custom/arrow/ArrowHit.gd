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
	if not source_tool: return
	var can_despawn = true
	for enchant in source_tool.enchantments:
		can_despawn = enchant.override_can_despawn_hit(can_despawn)
	if can_despawn: despawn_hit()
