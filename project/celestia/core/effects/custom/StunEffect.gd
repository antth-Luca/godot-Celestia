extends BaseEffect
class_name StunEffect

const EFFECT_DURATION := 2.0

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, false, true, EFFECT_DURATION)

# Handlers
func _on_effect_added(entity: LivingEntity) -> void:
	entity.entity_data.is_stunned = true
	super._on_effect_added(entity)


func _on_effect_removed(entity: LivingEntity) -> void:
	entity.entity_data.is_stunned = false
