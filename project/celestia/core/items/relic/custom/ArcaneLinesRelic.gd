extends BaseRelic
class_name ArcaneLinesRelic

const BUFF_MANA: float = 15

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_mp_prop: ManaProperty = player.entity_data.stats.get_property(InitPropProviders.MANA)
	player_mp_prop.add_max_mana(BUFF_MANA)
	player_mp_prop.add_mana(BUFF_MANA)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_mp_prop: ManaProperty = player.entity_data.stats.get_property(InitPropProviders.MANA)
	player_mp_prop.sub_mana(BUFF_MANA)
	player_mp_prop.sub_max_mana(BUFF_MANA)

# Hooks
# TODO: Add passiva.
