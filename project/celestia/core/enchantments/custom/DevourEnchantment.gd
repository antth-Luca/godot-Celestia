extends BaseEnchantment
class_name DevourEnchantment

const DEVOURING_PERCENTAGE: float = .08

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(1, init_level, [
		SwordTool.get_static_comparable_name(),
		FiringTool.get_static_comparable_name()
	])

# Hooks
func post_damage(hit: HitData, target: LivingEntity) -> void:
	var devour_dam: float = target.entity_data.stats.get_property(InitPropProviders.HEALTH).get_health() * DEVOURING_PERCENTAGE
	var devour_hit := HitData.new(
		hit.attacker,
		HitData.PRIMITIVE_TYPE.MAGIC,
		HitData.SPECIALIZED_TYPE.NONE,
		HitData.SOURCE.EFFECT
	)
	target.hurt(devour_dam, devour_hit, null)
