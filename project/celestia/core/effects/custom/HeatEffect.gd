extends BaseEffect
class_name HeatEffect

const MOVE_SPEED_BONUS_PERCENTAGE: float = .1

var move_speed_bonus: float = 0

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, BaseEffect.EffectCategory.BENEFICIAL, false, false, true, 30, 0)

# Handlers
func _on_effect_added(entity: LivingEntity) -> void:
	var ms_prop: MoveSpeedProperty = entity.entity_data.stats.get_property(InitPropProviders.MOVE_SPEED)
	move_speed_bonus = ms_prop.get_move_speed() * MOVE_SPEED_BONUS_PERCENTAGE
	ms_prop.add_move_speed(move_speed_bonus)


func _on_effect_removed(entity: LivingEntity) -> void:
	var ms_prop: MoveSpeedProperty = entity.entity_data.stats.get_property(InitPropProviders.MOVE_SPEED)
	ms_prop.sub_move_speed(move_speed_bonus)
