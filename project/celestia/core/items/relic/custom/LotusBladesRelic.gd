extends BaseRelic
class_name LotusBladesRelic

const BUFF_ARMOR: float = 1
const BUFF_PENETRATION: float = 2

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.ARMOR).add_armor(BUFF_ARMOR)
	player_stats.get_property(InitPropProviders.PENETRATION).add_penetration(BUFF_PENETRATION)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.ARMOR).sub_armor(BUFF_ARMOR)
	player_stats.get_property(InitPropProviders.PENETRATION).sub_penetration(BUFF_PENETRATION)

# Hooks
# TODO: Add passiva.
