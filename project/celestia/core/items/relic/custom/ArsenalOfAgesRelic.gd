extends BaseRelic
class_name ArsenalOfAgesRelic

const BUFF_CRIT_CHANCE: float = .5
const BUFF_CRIT_DAMAGE: float = .4
const BUFF_DEF_REDUCTION: float = .12
const BUFF_MOVE_SPEED: float = 15
const BUFF_USE_SPEED: float = .15
const BUFF_RANGE: float = .12

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_crit_prop: CriticalStrikeProperty = player_stats.get_property(InitPropProviders.CRITICAL_STRIKE)
	player_crit_prop.add_crit_chance(BUFF_CRIT_CHANCE)
	player_crit_prop.add_crit_damage(BUFF_CRIT_DAMAGE)
	player_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).add_def_reduction(BUFF_DEF_REDUCTION)
	player_stats.get_property(InitPropProviders.MOVE_SPEED).add_move_speed(BUFF_MOVE_SPEED)
	player_stats.get_property(InitPropProviders.USE_SPEED).add_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.RANGE).add_range(BUFF_RANGE)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_crit_prop: CriticalStrikeProperty = player_stats.get_property(InitPropProviders.CRITICAL_STRIKE)
	player_crit_prop.sub_crit_chance(BUFF_CRIT_CHANCE)
	player_crit_prop.sub_crit_damage(BUFF_CRIT_DAMAGE)
	player_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).sub_def_reduction(BUFF_DEF_REDUCTION)
	player_stats.get_property(InitPropProviders.MOVE_SPEED).sub_move_speed(BUFF_MOVE_SPEED)
	player_stats.get_property(InitPropProviders.USE_SPEED).sub_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.RANGE).sub_range(BUFF_RANGE)

# Hooks
# TODO: Add passiva.
