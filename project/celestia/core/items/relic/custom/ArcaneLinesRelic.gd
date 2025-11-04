extends BaseRelic
class_name ArcaneLinesRelic

const BUFF_MANA: float = 15
const BUFF_DAMAGE_PERCENTAGE: float = .15

var last_max_mana: float

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_mp_prop: ManaProperty = player.entity_data.stats.get_property(InitPropProviders.MANA)
	player_mp_prop.connect('max_mana_changed', Callable(self, '_on_max_mana_changed'))
	player_mp_prop.add_max_mana(BUFF_MANA)
	player_mp_prop.add_mana(BUFF_MANA)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_mp_prop: ManaProperty = player.entity_data.stats.get_property(InitPropProviders.MANA)
	player_mp_prop.sub_mana(BUFF_MANA)
	player_mp_prop.sub_max_mana(BUFF_MANA)
	player_mp_prop.disconnect('max_mana_changed', Callable(self, '_on_max_mana_changed'))

# HANDLERS
func _on_max_mana_changed(newMaxMP: float) -> void:
	if last_max_mana == newMaxMP: return
	if newMaxMP > last_max_mana:
		var difference: float = newMaxMP - last_max_mana
		var _a = difference * BUFF_DAMAGE_PERCENTAGE
		last_max_mana = newMaxMP
		return
	# newMaxMP < last_max_mana
	pass
	last_max_mana = newMaxMP
