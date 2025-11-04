extends BaseEffect
class_name FreezeEffect

const MOVE_SPEED_DEBUFF_PERCENTAGE: float = .3

var move_speed_debuff: float = 0

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, BaseEffect.EffectCategory.MALEFICIAL, false, false, true, 2, 0, [InitEffects.HEAT])

# Getters and Setters
func set_time(effect_duration_param: float, entity: LivingEntity = null) -> void:
	if entity: effect_duration_param *= entity.entity_data.stats.get_property(InitPropProviders.MOBILITY_MODIFIER).get_modifier()
	super.set_time(effect_duration_param)

# Handlers
func _on_effect_added(entity: LivingEntity) -> void:
	var ms_prop: MoveSpeedProperty = entity.entity_data.stats.get_property(InitPropProviders.MOVE_SPEED)
	move_speed_debuff = ms_prop.get_move_speed() * MOVE_SPEED_DEBUFF_PERCENTAGE
	ms_prop.sub_move_speed(move_speed_debuff)


func _on_effect_removed(entity: LivingEntity) -> void:
	var ms_prop: MoveSpeedProperty = entity.entity_data.stats.get_property(InitPropProviders.MOVE_SPEED)
	ms_prop.add_move_speed(move_speed_debuff)
