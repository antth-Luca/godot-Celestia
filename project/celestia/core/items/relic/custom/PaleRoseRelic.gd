extends BaseRelic
class_name PaleRoseRelic

const BUFF_CRIT_CHANCE: float = .25
const BUFF_DEF_REDUCTION: float = .12

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.CRITICAL_STRIKE).add_crit_chance(BUFF_CRIT_CHANCE)
	player_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).add_def_reduction(BUFF_DEF_REDUCTION)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.CRITICAL_STRIKE).sub_crit_chance(BUFF_CRIT_CHANCE)
	player_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).sub_def_reduction(BUFF_DEF_REDUCTION)
