extends BaseRelic
class_name CrownOfLucidityRelic

const BUFF_RESISTANCE: float = 5
const BUFF_MOBILIOTY_MOD: float = .2

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.RESISTANCE).add_resistance(BUFF_RESISTANCE)
	player_stats.get_property(InitPropProviders.MOBILITY_MODIFIER).sub_modifier(BUFF_MOBILIOTY_MOD)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.RESISTANCE).sub_resistance(BUFF_RESISTANCE)
	player_stats.get_property(InitPropProviders.MOBILITY_MODIFIER).add_modifier(BUFF_MOBILIOTY_MOD)
