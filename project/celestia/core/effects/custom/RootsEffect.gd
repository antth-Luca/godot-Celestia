extends BaseEffect
class_name RootsEffect

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, BaseEffect.EffectCategory.MALEFICIAL, false, false, true, 2, 0)

# Handlers
func _on_effect_added(entity: LivingEntity) -> void:
	entity.entity_data.is_rooted = true


func _on_effect_removed(entity: LivingEntity) -> void:
	entity.entity_data.is_rooted = false
