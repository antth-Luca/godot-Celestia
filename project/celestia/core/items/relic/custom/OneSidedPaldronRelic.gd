extends BaseRelic
class_name OneSidedPaldronRelic

const BUFF_HEALTH: float = 140
const BUFF_REGENERATION: float = .3
const BUFF_RESISTANCE: float = 2

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_hp_prop: HealthProperty = player_stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.add_max_health(BUFF_HEALTH)
	player_hp_prop.add_health(BUFF_HEALTH)
	player_stats.get_property(InitPropProviders.HEAL_MODIFIER).add_modifier(BUFF_REGENERATION)
	player_stats.get_property(InitPropProviders.RESISTANCE).add_resistance(BUFF_RESISTANCE)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_hp_prop: HealthProperty = player_stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.sub_health(BUFF_HEALTH)
	player_hp_prop.sub_max_health(BUFF_HEALTH)
	player_stats.get_property(InitPropProviders.HEAL_MODIFIER).sub_modifier(BUFF_REGENERATION)
	player_stats.get_property(InitPropProviders.RESISTANCE).sub_resistance(BUFF_RESISTANCE)

# Hooks
# TODO: Add passiva.
