extends BaseRelic
class_name ArcaneLinesRelic

const BUFF_MANA: float = 15
const BUFF_DAMAGE_PERCENTAGE: float = .15

var last_max_mana: float
var owner_player: Player

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.UNCOMMON.get_registered()

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	owner_player = player
	last_max_mana = 0
	var player_mp_prop: ManaProperty = player.entity_data.stats.get_property(InitPropProviders.MANA)
	player_mp_prop.connect('max_mana_changed', Callable(self, '_on_max_mana_changed'))
	player_mp_prop.add_max_mana(BUFF_MANA)
	player_mp_prop.add_mana(BUFF_MANA)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_mp_prop: ManaProperty = player.entity_data.stats.get_property(InitPropProviders.MANA)
	player_mp_prop.disconnect('max_mana_changed', Callable(self, '_on_max_mana_changed'))
	remove_all_damage_buff()
	player_mp_prop.sub_mana(BUFF_MANA)
	player_mp_prop.sub_max_mana(BUFF_MANA)

# HANDLERS
func _on_max_mana_changed(newMaxMP: float) -> void:
	if last_max_mana == newMaxMP: return
	var player_force_prop: ForceProperty = owner_player.entity_data.stats.get_property(InitPropProviders.FORCE)
	var difference: float
	if newMaxMP > last_max_mana:
		difference = newMaxMP - last_max_mana
		player_force_prop.add_force(difference * BUFF_DAMAGE_PERCENTAGE)
	else:  # newMaxMP < last_max_mana
		difference = last_max_mana - newMaxMP
		player_force_prop.sub_force(difference * BUFF_DAMAGE_PERCENTAGE)
	last_max_mana = newMaxMP


func remove_all_damage_buff() -> void:
	var player_force_prop: ForceProperty = owner_player.entity_data.stats.get_property(InitPropProviders.FORCE)
	player_force_prop.sub_force(last_max_mana * BUFF_DAMAGE_PERCENTAGE)
