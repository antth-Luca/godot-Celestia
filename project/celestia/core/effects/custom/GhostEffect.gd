extends BaseEffect
class_name GhostEffect

const MOVE_SPEED_BONUS_PERCENTAGE: float = .2
const COLLISION_MASK_MODIFIER: Array[int] = [ 6, 8 ]

var move_speed_bonus: float = 0

# SUPER
# Godot
func _init() -> void:
	super._init(1, 1, BaseEffect.EffectCategory.MALEFICIAL, false, false, true, 10, 0)

# Handlers
func _on_effect_added(entity: LivingEntity) -> void:
	# Move speed
	var ms_prop: MoveSpeedProperty = entity.entity_data.stats.get_property(InitPropProviders.MOVE_SPEED)
	move_speed_bonus = ms_prop.get_move_speed() * MOVE_SPEED_BONUS_PERCENTAGE
	ms_prop.add_move_speed(move_speed_bonus)
	# Collision
	for mask in COLLISION_MASK_MODIFIER:
		entity.set_collision_mask_value(mask, false)


func _on_effect_removed(entity: LivingEntity) -> void:
	# Move speed
	var ms_prop: MoveSpeedProperty = entity.entity_data.stats.get_property(InitPropProviders.MOVE_SPEED)
	ms_prop.sub_move_speed(move_speed_bonus)
	# Collision
	for mask in COLLISION_MASK_MODIFIER:
		entity.set_collision_mask_value(mask, true)
