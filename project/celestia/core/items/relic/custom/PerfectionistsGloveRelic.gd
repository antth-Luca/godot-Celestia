extends BaseRelic
class_name PerfectionistsGloveRelic

const BUFF_MANA: float = 15
const BUFF_LUCK: int = 2
const BUFF_ARMOR: float = 1
const BUFF_DAMAGE_PERCENTAGE: float = .15
const MANA_REGEN_PERCENTAGE: float = .18
const MANA_REGEN_COOLDOWN: float = 12

var last_max_mana: float
var owner_player: Player
var amount_time: float

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	owner_player = player
	last_max_mana = 0
	var player_stats: PropertyManager = player.entity_data.stats
	var player_mp_prop: ManaProperty = player_stats.get_property(InitPropProviders.MANA)
	player_mp_prop.connect('max_mana_changed', Callable(self, '_on_max_mana_changed'))
	player_mp_prop.add_max_mana(BUFF_MANA)
	player_mp_prop.add_mana(BUFF_MANA)
	player_stats.get_property(InitPropProviders.LUCK).add_luck(BUFF_LUCK)
	player_stats.get_property(InitPropProviders.ARMOR).add_armor(BUFF_ARMOR)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_mp_prop: ManaProperty = player_stats.get_property(InitPropProviders.MANA)
	player_mp_prop.disconnect('max_mana_changed', Callable(self, '_on_max_mana_changed'))
	remove_all_damage_buff()
	player_mp_prop.sub_mana(BUFF_MANA)
	player_mp_prop.sub_max_mana(BUFF_MANA)
	player_stats.get_property(InitPropProviders.LUCK).sub_luck(BUFF_LUCK)
	player_stats.get_property(InitPropProviders.ARMOR).sub_armor(BUFF_ARMOR)

# Hooks
func on_tick(equipped_entity: LivingEntity, delta: float) -> void:
	amount_time += delta
	if amount_time >= MANA_REGEN_COOLDOWN:
		var entity_mp_prop: ManaProperty = equipped_entity.entity_data.stats.get_property(InitPropProviders.MANA)
		entity_mp_prop.add_mana(entity_mp_prop.get_max_mana() * MANA_REGEN_PERCENTAGE)
		amount_time = 0

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
