extends BaseEffect
class_name RootsEffect

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, BaseEffect.EffectCategory.MALEFICIAL, false, false, true, 2, 0)

# Getters and Setters
func set_time(effect_duration_param: float, entity: LivingEntity = null) -> void:
	if entity: effect_duration_param *= entity.entity_data.stats.get_property(InitPropProviders.MOBILITY_MODIFIER).get_modifier()
	super.set_time(effect_duration_param)

# Handlers
func _on_effect_added(entity: LivingEntity) -> void:
	entity.entity_data.is_rooted = true


func _on_effect_removed(entity: LivingEntity) -> void:
	entity.entity_data.is_rooted = false
